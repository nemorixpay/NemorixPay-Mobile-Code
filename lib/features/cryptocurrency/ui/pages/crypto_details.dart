import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
/// @version     1.0
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
        .map((e) => FlSpot(e.key.toDouble(), e.value))
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
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$${widgetcrypto.currentPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Icon(
                                  _isFav ? Icons.star : Icons.star_border,
                                  color: _isFav ? Colors.amber : Colors.grey,
                                ),
                                onTap: () {
                                  setState(() {
                                    _isFav = !_isFav;
                                  });
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
                                  color: Colors.yellow,
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(show: false),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
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
                                              ? Colors.yellow
                                              : Colors.grey[800],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        color:
                                            isSelected
                                                ? Colors.black
                                                : Colors.white,
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
