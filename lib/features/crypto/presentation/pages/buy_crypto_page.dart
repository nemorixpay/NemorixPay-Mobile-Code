import 'package:flutter/material.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/crypto/domain/entities/commission_validator.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/continue_button.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/exchange_fee_card.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/crypto_conversion_card.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/terms_and_conditions_section.dart';

/// @file        buy_crypto_page.dart
/// @brief       Buy Crypto page implementation for NemorixPay.
/// @details     This file contains the layout and UI logic for buying a crypto option in NemorixPay,
///              including asset information.
/// @author      Miguel Fagundez
/// @date        06/12/2025
/// @version     1.3
/// @copyright   Apache 2.0 License
class BuyCryptoPage extends StatefulWidget {
  final CryptoAssetWithMarketData selectedAsset;
  const BuyCryptoPage({super.key, required this.selectedAsset});

  @override
  State<BuyCryptoPage> createState() => _BuyCryptoPageState();
}

class _BuyCryptoPageState extends State<BuyCryptoPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _payController = TextEditingController();

  String selectedFiat = 'USD';
  double exchangeFeePercent = 0.0005;

  double get assetPrice => widget.selectedAsset.marketData.currentPrice;
  double get payAmount => double.tryParse(_payController.text) ?? 0;
  double get receiveAmount => payAmount / assetPrice;
  double get exchangeFee => payAmount * exchangeFeePercent;

  void _handleFiatChanged(String value) {
    setState(() => selectedFiat = value);
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
                      selectedAsset: widget.selectedAsset,
                      payController: _payController,
                      assetPrice: assetPrice,
                      receiveAmount: receiveAmount,
                      onFiatChanged: _handleFiatChanged,
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
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.paymentMethod,
                          arguments: {
                            'assetName': widget.selectedAsset.asset.assetCode,
                            'amount': CommissionValidator.calculateTotalAmount(
                              amount: payAmount,
                              commissionPercent: exchangeFeePercent,
                            ),
                            'currency': selectedFiat,
                          },
                        );
                      },
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
