import 'package:flutter/material.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_entity.dart';
import 'package:nemorixpay/features/asset/data/mock_cryptos.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/features/asset/presentation/widgets/asset_conversion_card.dart';
import 'package:nemorixpay/features/asset/presentation/widgets/exchange_fee_card.dart';
import 'package:nemorixpay/features/asset/presentation/widgets/terms_and_conditions_section.dart';
import 'package:nemorixpay/features/asset/presentation/widgets/continue_button.dart';

/// @file        buy_asset_page.dart
/// @brief       Buy Asset page implementation for NemorixPay.
/// @details     This file contains the layout and UI logic for buying asset option in NemorixPay,
///              including asset information.
/// @author      Miguel Fagundez
/// @date        2025-04-18
/// @version     1.2
/// @copyright   Apache 2.0 License
class BuyAssetPage extends StatefulWidget {
  const BuyAssetPage({super.key});

  @override
  State<BuyAssetPage> createState() => _BuyAssetPageState();
}

class _BuyAssetPageState extends State<BuyAssetPage> {
  final TextEditingController _payController = TextEditingController();

  String selectedFiat = 'USD';
  AssetEntity selectedAsset = mockCryptos.first;
  double exchangeFeePercent = 0.0005;

  double get assetPrice => selectedAsset.currentPrice;
  double get payAmount => double.tryParse(_payController.text) ?? 0;
  double get receiveAmount => payAmount / assetPrice;
  double get exchangeFee => payAmount * exchangeFeePercent;

  void _handleFiatChanged(String value) {
    setState(() => selectedFiat = value);
  }

  void _handleAssetChanged(AssetEntity value) {
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
                    AssetConversionCard(
                      selectedFiat: selectedFiat,
                      selectedAsset: selectedAsset,
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
