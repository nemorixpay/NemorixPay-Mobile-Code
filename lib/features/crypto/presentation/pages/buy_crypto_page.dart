import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';
import '../../../../shared/common/domain/entities/asset_entity.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_state.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/crypto_conversion_card.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/exchange_fee_card.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/terms_and_conditions_section.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/continue_button.dart';

/// @file        buy_crypto_page.dart
/// @brief       Buy Crypto page implementation for NemorixPay.
/// @details     This file contains the layout and UI logic for buying a crypto option in NemorixPay,
///              including asset information.
/// @author      Miguel Fagundez
/// @date        06/12/2025
/// @version     1.3
/// @copyright   Apache 2.0 License
class BuyCryptoPage extends StatefulWidget {
  const BuyCryptoPage({super.key});

  @override
  State<BuyCryptoPage> createState() => _BuyCryptoPageState();
}

class _BuyCryptoPageState extends State<BuyCryptoPage> {
  late List<CryptoAssetWithMarketData> listOfAssets;
  @override
  void initState() {
    // TODO: Checking if thi state is always available in this page
    try {
      if (context.read<CryptoHomeBloc>().state is CryptoHomeLoaded) {
        listOfAssets =
            (context.read<CryptoHomeBloc>().state as CryptoHomeLoaded)
                .accountAssets;
        selectedAsset = listOfAssets[0];
      } else {
        selectedAsset = CryptoAssetWithMarketData(
          asset: AssetEntity(
            id: 'test',
            assetCode: 'test',
            name: 'test',
            assetType: 'test',
            network: 'test',
            decimals: 0,
          ),
          marketData: MarketDataEntity(
            currentPrice: 0.0,
            priceChange: 0.0,
            priceChangePercentage: 0.0,
            marketCap: 1,
            volume: 1,
            high24h: 0.0,
            low24h: 0.0,
            circulatingSupply: 1,
            totalSupply: 1,
            maxSupply: 1,
            ath: 0.0,
            athChangePercentage: 0.0,
            athDate: DateTime.now(),
            atl: 0.0,
            atlChangePercentage: 0.0,
            atlDate: DateTime.now(),
            lastUpdated: DateTime.now(),
          ),
        );
        listOfAssets = [selectedAsset];
        debugPrint('InitState Failure - CryptoHomeLoaded not presented(1)');
        throw AssetFailure.unknown(
          'InitState Failure - CryptoHomeLoaded not presented.}',
        );
      }
    } catch (e) {
      debugPrint(
        'InitState Failure - CryptoHomeLoaded not presented(2): ${e.toString()}',
      );
      AssetFailure.unknown(
        'InitState Failure - CryptoHomeLoaded not presented: ${e.toString()}',
      );
      return;
    }
    super.initState();
  }

  final TextEditingController _payController = TextEditingController();

  String selectedFiat = 'USD';
  // AssetEntity selectedAsset = mockCryptos.first;
  late CryptoAssetWithMarketData selectedAsset;
  double exchangeFeePercent = 0.0005;

  double get assetPrice => selectedAsset.marketData.currentPrice;
  double get payAmount => double.tryParse(_payController.text) ?? 0;
  double get receiveAmount => payAmount / assetPrice;
  double get exchangeFee => payAmount * exchangeFeePercent;

  void _handleFiatChanged(String value) {
    setState(() => selectedFiat = value);
  }

  void _handleAssetChanged(CryptoAssetWithMarketData value) {
    debugPrint('Selected Asset: ${value.asset.name}');
    setState(() => selectedAsset = value);
  }

  void _handlePayAmountChanged(String value) {
    setState(() {});
  }

  void _handleTermsTap() {
    debugPrint('Terms and Conditions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    MainHeader(
                      title: AppLocalizations.of(context)!.buy,
                      showSearchButton: false,
                    ),
                    const SizedBox(height: 48),
                    CryptoConversionCard(
                      selectedFiat: selectedFiat,
                      listOfAssets: listOfAssets,
                      payController: _payController,
                      assetPrice: assetPrice,
                      receiveAmount: receiveAmount,
                      onFiatChanged: _handleFiatChanged,
                      onAssetChanged: _handleAssetChanged,
                      onPayAmountChanged: _handlePayAmountChanged,
                    ),
                    const SizedBox(height: 24),
                    ExchangeFeeCard(
                      exchangeFee: exchangeFee,
                      amount: payAmount,
                      commissionPercent: exchangeFeePercent,
                    ),
                    const SizedBox(height: 16),
                    TermsAndConditionsSection(onTermsTap: _handleTermsTap),
                    const Spacer(),
                    const SizedBox(height: 20),
                    ContinueButton(
                      onPressed: () {},
                      amount: _payController.text,
                      commissionPercent: exchangeFeePercent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
