import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entity/crypto_entity.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/crypto_stats_tile.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/custom_two_buttons.dart';
import 'package:nemorixpay/shared/ui/widgets/main_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/shared/data/mock_cryptos.dart';

/// @file        crypto_details.dart
/// @brief       Crypto deatils screen implementation for NemorixPay.
/// @details     This file contains the layout and logic for the crypto details info of NemorixPay,
///              including crypto asset information, buy/sell buttons, charts, and more.
/// @author      Miguel Fagundez
/// @date        2025-04-14
/// @version     1.1
/// @copyright   Apache 2.0 License
class CryptoDetailsPage extends StatefulWidget {
  const CryptoDetailsPage({super.key});

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsScreenState();
}

class _CryptoDetailsScreenState extends State<CryptoDetailsPage> {
  String selectedTimeFrame = '1D';

  final Crypto widgetcrypto = mockCryptos[3];
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = false;
  }

  void toggleFavorite(Crypto crypto) {
    if (favoriteCryptos.contains(crypto)) {
      favoriteCryptos.remove(crypto);
    } else {
      favoriteCryptos.add(crypto);
    }
  }

  List<FlSpot> getChartData(String range) {
    final data = widgetcrypto.priceHistory[range] ?? [];
    return data
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.price))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --------------------
                  // Back button/Crypto Name
                  // --------------------
                  MainHeader(title: widgetcrypto.name),
                  // --------------------
                  // Crypto Info Header
                  // --------------------
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              widgetcrypto.logoPath,
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widgetcrypto.abbreviation,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  '\$${widgetcrypto.currentPrice.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Icon(
                                  _isFav ? Icons.star : Icons.star_border,
                                  color:
                                      _isFav
                                          ? NemorixColors.primaryColor
                                          : Colors.grey,
                                ),
                                onTap: () {
                                  setState(() {
                                    _isFav = !_isFav;
                                  });
                                  // TODO Uncheck option not implemented
                                  toggleFavorite(widgetcrypto);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // --------------------
                        // Crypto chart
                        // --------------------
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              lineBarsData: [
                                LineChartBarData(
                                  spots: getChartData(selectedTimeFrame),
                                  isCurved: true,
                                  color: NemorixColors.primaryColor,
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: NemorixColors.primaryColor
                                        .withOpacity(0.1),
                                  ),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                show: false,
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      final data =
                                          widgetcrypto
                                              .priceHistory[selectedTimeFrame]!;
                                      if (value.toInt() >= 0 &&
                                          value.toInt() < data.length) {
                                        final date =
                                            data[value.toInt()].timestamp;
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                          ),
                                          child: Text(
                                            '${date.hour}:00',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                          ),
                                        );
                                      }
                                      return const Text('');
                                    },
                                  ),
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: 1,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Theme.of(context).dividerColor,
                                    strokeWidth: 0.5,
                                  );
                                },
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor: Theme.of(context).cardColor,
                                  tooltipRoundedRadius: 8,
                                  getTooltipItems: (touchedSpots) {
                                    return touchedSpots.map((spot) {
                                      final data =
                                          widgetcrypto
                                              .priceHistory[selectedTimeFrame]!;
                                      final point = data[spot.x.toInt()];
                                      return LineTooltipItem(
                                        '\$${point.price.toStringAsFixed(2)}\n',
                                        Theme.of(
                                          context,
                                        ).textTheme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Vol: \$${point.volume.toStringAsFixed(2)}\n',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                          ),
                                          TextSpan(
                                            text:
                                                'Cap: \$${point.marketCap.toStringAsFixed(2)}',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                          ),
                                        ],
                                      );
                                    }).toList();
                                  },
                                ),
                                handleBuiltInTouches: true,
                                getTouchedSpotIndicator: (
                                  LineChartBarData barData,
                                  List<int> spotIndexes,
                                ) {
                                  return spotIndexes.map((spotIndex) {
                                    return TouchedSpotIndicatorData(
                                      FlLine(
                                        color: NemorixColors.primaryColor,
                                        strokeWidth: 2,
                                      ),
                                      FlDotData(
                                        getDotPainter: (
                                          spot,
                                          percent,
                                          barData,
                                          index,
                                        ) {
                                          return FlDotCirclePainter(
                                            radius: 4,
                                            color: NemorixColors.primaryColor,
                                            strokeWidth: 2,
                                            strokeColor:
                                                Theme.of(
                                                  context,
                                                ).scaffoldBackgroundColor,
                                          );
                                        },
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // --------------------
                        // Time Frame Options (1D, 1W, etc)
                        // --------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              timeFrameOptions.map((option) {
                                final isSelected = selectedTimeFrame == option;
                                return GestureDetector(
                                  onTap:
                                      () => setState(
                                        () => selectedTimeFrame = option,
                                      ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? NemorixColors.primaryColor
                                              : Theme.of(
                                                context,
                                              ).cardColor, //Colors.grey[800],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        color:
                                            isSelected
                                                ? Colors.black
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color, //Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 40),
                        // --------------------
                        // Send/Receive Buttons
                        // --------------------
                        CustomTwoButtons(
                          textButton1: AppLocalizations.of(context)!.send,
                          onFunctionButton1: () {
                            debugPrint('Button01 - Send');
                          },
                          textButton2: AppLocalizations.of(context)!.receive,
                          onFunctionButton2: () {
                            debugPrint('Button02 - Receive');
                          },
                        ),
                        const SizedBox(height: 40),
                        // --------------------
                        // Crypto Stats
                        // --------------------
                        Column(
                          children: [
                            CryptoStatsTile(
                              label: AppLocalizations.of(context)!.marketCap,
                              value:
                                  '\$${widgetcrypto.marketCap.toStringAsFixed(2)}',
                            ),
                            CryptoStatsTile(
                              label: AppLocalizations.of(context)!.volume,
                              value:
                                  '\$${widgetcrypto.volume.toStringAsFixed(2)}',
                            ),
                            CryptoStatsTile(
                              label:
                                  AppLocalizations.of(
                                    context,
                                  )!.circulatingSupply,
                              value:
                                  '${widgetcrypto.circulatingSupply.toStringAsFixed(2)}',
                            ),
                            CryptoStatsTile(
                              label: AppLocalizations.of(context)!.totalSupply,
                              value:
                                  '${widgetcrypto.totalSupply.toStringAsFixed(2)}',
                            ),
                            CryptoStatsTile(
                              label: AppLocalizations.of(context)!.allTimeHigh,
                              value:
                                  '\$${widgetcrypto.allTimeHigh.toStringAsFixed(2)}',
                            ),
                            CryptoStatsTile(
                              label: AppLocalizations.of(context)!.performance,
                              value:
                                  '${widgetcrypto.performance.toStringAsFixed(2)}%',
                            ),
                          ],
                        ),
                        SizedBox(height: 75),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // --------------------
            // Sell/Buy Buttons
            // --------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTwoButtons(
                textButton1: AppLocalizations.of(context)!.sell,
                onFunctionButton1: () {
                  debugPrint('Button01 - Sell');
                },
                textButton2: AppLocalizations.of(context)!.buy,
                onFunctionButton2: () {
                  debugPrint('Button02 - Buy');
                },
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
