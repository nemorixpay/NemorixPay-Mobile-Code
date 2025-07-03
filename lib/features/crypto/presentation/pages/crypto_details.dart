import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';
import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/crypto_stats_card.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/custom_two_buttons.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';

/// @file        crypto_details.dart
/// @brief       Screen to display detailed information about a crypto.
/// @details     This screen shows detailed information about a crypto,
///             including its price history, market data, and trading options.
/// @author      Miguel Fagundez
/// @date        04/28/2025
/// @version     1.2
/// @copyright   Apache 2.0 License
class CryptoDetailsPage extends StatefulWidget {
  // final AssetEntity crypto;
  final CryptoAssetWithMarketData crypto;

  const CryptoDetailsPage({super.key, required this.crypto});

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  String selectedTimeFrame = '1M';
  final List<String> timeFrameOptions = ['1D', '1W', '1M', '1Y'];

  late bool _isFav;
  bool _isAssetInAccount = false;

  @override
  void initState() {
    super.initState();
    _isFav = widget.crypto.isFavorite;
    checkAssetInAccount();
  }

// -------------------------------------
// TODO: This needs to be checked
  void checkAssetInAccount() async {
    _isAssetInAccount = false;
    AssetCacheManager cache = AssetCacheManager();

    final list = await cache.getAccountAssets();
    debugPrint('list(length): ${list.length}');
    debugPrint(
        'checkingAssetList (widget.crypto): ${widget.crypto.asset.name}');
    for (var asset in list) {
      // TODO: Need to verify this condition in general case
      debugPrint('checkingAssetList (asset): ${asset.assetCode}');
      if (asset.assetCode == widget.crypto.asset.name) {
        debugPrint('checkingAssetList: true');
        _isAssetInAccount = true;
      }
    }
    setState(() {});
  }

  void toggleFavorite(CryptoAssetWithMarketData crypto) {
    setState(() {
      crypto.isFavorite = !crypto.isFavorite;
      _isFav = crypto.isFavorite;
      // Need to connect with database local/remote
    });
  }

  List<FlSpot> getChartData(String timeframe) {
    // Por ahora, generamos datos de ejemplo para el gráfico
    return List.generate(
      30,
      (i) => FlSpot(
        i.toDouble(),
        widget.crypto.marketData.currentPrice * (1 + (i % 10) / 100),
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
                    title: widget.crypto.asset.name,
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
                              widget.crypto.asset.isNative()
                                  ? ImageUrl.xlmLogo
                                  : widget.crypto.asset.logoUrl ??
                                      ImageUrl.temporalCryptoLogo,
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.crypto.asset.assetCode,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  '\$${widget.crypto.marketData.currentPrice.toStringAsFixed(2)}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.copyWith(
                                        color: widget.crypto.marketData
                                                    .priceChange >=
                                                0
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
                                color: _isFav
                                    ? NemorixColors.errorColor
                                    : NemorixColors.greyLevel3,
                              ),
                              onPressed: () => toggleFavorite(widget.crypto),
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
                          children: timeFrameOptions.map((timeframe) {
                            return TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedTimeFrame = timeframe;
                                });
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: selectedTimeFrame == timeframe
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
                    onFunctionButton1: _isAssetInAccount
                        ? () {
                            debugPrint('Button01 - Send');
                            Navigator.pushNamed(
                              context,
                              RouteNames.sendCrypto,
                              arguments: {
                                'crypto': widget.crypto,
                              },
                            );
                          }
                        : null,
                    textButton2: AppLocalizations.of(context)!.receive,
                    onFunctionButton2: _isAssetInAccount
                        ? () {
                            debugPrint('Button02 - Receive');
                            StellarAccountProvider _provider =
                                StellarAccountProvider();

                            Navigator.pushNamed(
                              context,
                              RouteNames.receiveCrypto,
                              arguments: {
                                'cryptoName': _provider
                                        .currentAccount!.assets?[0].assetCode ??
                                    'XLM',
                                'logoAsset': "assets/logos/xlm_white.png",
                                'publicKey': _provider
                                        .currentAccount?.publicKey ??
                                    "GARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AERL",
                              },
                            );
                          }
                        : null,
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
                    child: CryptoStatsCard(crypto: widget.crypto),
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
                onFunctionButton1: _isAssetInAccount
                    ? () {
                        // TODO: Implement buy action
                      }
                    : null,
                onFunctionButton2: _isAssetInAccount
                    ? () {
                        // TODO: Implement sell action
                      }
                    : null,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
