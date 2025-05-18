import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_entity.dart';
import 'package:nemorixpay/features/asset/presentation/widgets/asset_stats_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/features/asset/data/mock_cryptos.dart';
import 'package:nemorixpay/features/asset/presentation/widgets/custom_two_buttons.dart';

/// @file        asset_details.dart
/// @brief       Screen to display detailed information about an asset.
/// @details     This screen shows detailed information about an asset,
///             including its price history, market data, and trading options.
/// @author      Miguel Fagundez
/// @date        04/28/2025
/// @version     1.2
/// @copyright   Apache 2.0 License
class AssetDetailsPage extends StatefulWidget {
  final AssetEntity asset;

  const AssetDetailsPage({super.key, required this.asset});

  @override
  State<AssetDetailsPage> createState() => _AssetDetailsPageState();
}

class _AssetDetailsPageState extends State<AssetDetailsPage> {
  String selectedTimeFrame = '1M';
  final List<String> timeFrameOptions = ['1D', '1W', '1M', '1Y'];

  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = favoriteCryptos.contains(widget.asset);
  }

  void toggleFavorite(AssetEntity asset) {
    setState(() {
      if (favoriteCryptos.contains(asset)) {
        favoriteCryptos.remove(asset);
        _isFav = false;
      } else {
        favoriteCryptos.add(asset);
        _isFav = true;
      }
    });
  }

  List<FlSpot> getChartData(String timeframe) {
    // Por ahora, generamos datos de ejemplo para el gráfico
    return List.generate(
      30,
      (i) => FlSpot(
        i.toDouble(),
        widget.asset.currentPrice * (1 + (i % 10) / 100),
      ),
    );
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
                  // Back button/Asset Name
                  // --------------------
                  MainHeader(
                    title: widget.asset.name,
                    showBackButton: true,
                    showSearchButton: false,
                  ),
                  // --------------------
                  // Asset Info Header
                  // --------------------
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              widget.asset.logoPath,
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.asset.symbol,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  '\$${widget.asset.currentPrice.toStringAsFixed(2)}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.copyWith(
                                    color:
                                        widget.asset.priceChange >= 0
                                            ? NemorixColors.successColor
                                            : NemorixColors.errorColor,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                _isFav ? Icons.favorite : Icons.favorite_border,
                                color:
                                    _isFav
                                        ? NemorixColors.errorColor
                                        : NemorixColors.greyLevel3,
                              ),
                              onPressed: () => toggleFavorite(widget.asset),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40.0),
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              gridData: const FlGridData(show: false),
                              titlesData: const FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: getChartData(selectedTimeFrame),
                                  isCurved: true,
                                  color: NemorixColors.primaryColor,
                                  barWidth: 2,
                                  isStrokeCapRound: true,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    // TODO 'withOpacity' is deprecated and shouldn't be used. Use .withValues() to avoid precision loss.
                                    color: NemorixColors.primaryColor
                                        .withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              timeFrameOptions.map((timeframe) {
                                return TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedTimeFrame = timeframe;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        selectedTimeFrame == timeframe
                                            ? NemorixColors.primaryColor
                                            : NemorixColors.greyLevel3,
                                  ),
                                  child: Text(timeframe),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
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
                  const SizedBox(height: 20.0),
                  // --------------------
                  // Asset Stats
                  // --------------------
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      left: 16.0,
                      bottom: 16.0,
                    ),
                    child: AssetStatsCard(asset: widget.asset),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
            // --------------------
            // Sell/Buy Buttons
            // --------------------
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTwoButtons(
                textButton1: AppLocalizations.of(context)!.buy,
                textButton2: AppLocalizations.of(context)!.sell,
                onFunctionButton1: () {
                  // TODO: Implement buy action
                },
                onFunctionButton2: () {
                  // TODO: Implement sell action
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
