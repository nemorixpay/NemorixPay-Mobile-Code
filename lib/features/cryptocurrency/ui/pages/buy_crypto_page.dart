import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/crypto_entity.dart';
import 'package:nemorixpay/features/cryptocurrency/data/mock_cryptos.dart';
import 'package:nemorixpay/shared/data/mock_fiats.dart';
import 'package:nemorixpay/shared/ui/widgets/main_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/crypto_conversion_card.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/exchange_fee_card.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/terms_and_conditions_section.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/continue_button.dart';

/// @file        buy_crypto_page.dart
/// @brief       Buy Crypto screen implementation for NemorixPay.
/// @details     This file contains the layout and UI logic for buying crypto option in NemorixPay,
///              including crypto asset information.
/// @author      Miguel Fagundez
/// @date        2025-04-18
/// @version     1.1
/// @copyright   Apache 2.0 License
class BuyCryptoPage extends StatefulWidget {
  const BuyCryptoPage({super.key});

  @override
  State<BuyCryptoPage> createState() => _BuyCryptoScreenState();
}

class _BuyCryptoScreenState extends State<BuyCryptoPage> {
  final TextEditingController _payController = TextEditingController();

  String selectedFiat = 'USD';
  CryptoEntity selectedCrypto = mockCryptos.first;
  double exchangeFeePercent = 0.0005;

  double get cryptoPrice => selectedCrypto.currentPrice;
  double get payAmount => double.tryParse(_payController.text) ?? 0;
  double get receiveAmount => payAmount / cryptoPrice;
  double get exchangeFee => payAmount * exchangeFeePercent;

  void _handleFiatChanged(String value) {
    setState(() => selectedFiat = value);
  }

  void _handleCryptoChanged(CryptoEntity value) {
    setState(() => selectedCrypto = value);
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
                      selectedCrypto: selectedCrypto,
                      payController: _payController,
                      cryptoPrice: cryptoPrice,
                      receiveAmount: receiveAmount,
                      onFiatChanged: _handleFiatChanged,
                      onCryptoChanged: _handleCryptoChanged,
                      onPayAmountChanged: _handlePayAmountChanged,
                    ),
                    const SizedBox(height: 24),
                    ExchangeFeeCard(exchangeFee: exchangeFee),
                    const SizedBox(height: 16),
                    TermsAndConditionsSection(onTermsTap: _handleTermsTap),
                    const Spacer(),
                    const SizedBox(height: 20),
                    ContinueButton(onPressed: () {}, isEnabled: payAmount > 0),
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
