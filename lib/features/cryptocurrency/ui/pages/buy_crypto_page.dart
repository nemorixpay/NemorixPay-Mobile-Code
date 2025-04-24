import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entity/crypto_entity.dart';
import 'package:nemorixpay/shared/data/mock_cryptos.dart';
import 'package:nemorixpay/shared/data/mock_fiats.dart';
import 'package:nemorixpay/shared/ui/widgets/base_card.dart';
import 'package:nemorixpay/shared/ui/widgets/main_header.dart';
import 'package:nemorixpay/shared/ui/widgets/rounded_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// @file        buy_crypto_page.dart
/// @brief       Buy Crypto screen implementation for NemorixPay.
/// @details     This file contains the layout and UI logic for buying crypto option in NemorixPay,
///              including crypto asset information.
/// @author      Miguel Fagundez
/// @date        2025-04-18
/// @version     1.0
/// @copyright   Apache 2.0 License
class BuyCryptoPage extends StatefulWidget {
  const BuyCryptoPage({super.key});

  @override
  State<BuyCryptoPage> createState() => _BuyCryptoScreenState();
}

class _BuyCryptoScreenState extends State<BuyCryptoPage> {
  final TextEditingController _payController = TextEditingController();

  String selectedFiat = 'USD';
  Crypto selectedCrypto = mockCryptos.first;
  double exchangeFeePercent = 0.0005;

  double get cryptoPrice => selectedCrypto.currentPrice;
  double get payAmount => double.tryParse(_payController.text) ?? 0;
  double get receiveAmount => payAmount / cryptoPrice;
  double get exchangeFee => payAmount * exchangeFeePercent;

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
                    MainHeader(title: AppLocalizations.of(context)!.buy),
                    const SizedBox(height: 48),
                    // -----------------------
                    // Convertion Card
                    // -----------------------
                    BaseCard(
                      cardWidget: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.youPay,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const Spacer(),
                              _buildFiatDropdown(),
                            ],
                          ),
                          TextField(
                            controller: _payController,
                            keyboardType: TextInputType.number,
                            style:
                                Theme.of(context)
                                    .textTheme
                                    .titleLarge, //const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: '0.00',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: const Icon(
                                  Icons.swap_vert,
                                  color: NemorixColors.primaryColor,
                                ),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.youReceive,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const Spacer(),
                              _buildCryptoDropdown(),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              receiveAmount.toStringAsFixed(4),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: NemorixColors.primaryColor,
                                size: 8,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '1 USD = ${(1 / cryptoPrice).toStringAsFixed(6)} ${selectedCrypto.abbreviation.toUpperCase()}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // ------------------------
                    // Exchange Fee Card
                    // ------------------------
                    BaseCard(
                      cardWidget: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: NemorixColors.greyLevel2,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.monetization_on,
                              color: NemorixColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            AppLocalizations.of(context)!.exchangeFee,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const Spacer(),
                          Text(
                            '\$${exchangeFee.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ---------------------------
                    // Terms & Conditions
                    // ---------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.clickHereFor,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              GestureDetector(
                                onTap: () {
                                  debugPrint('Terms and Conditions');
                                },
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.termsAndConditions,
                                  style: TextStyle(
                                    color: NemorixColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            AppLocalizations.of(context)!.transactionFeeTaken,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedElevatedButton(
                        text: AppLocalizations.of(context)!.continueLabel,
                        onPressed: () {}, // Flutter bloc action
                        backgroundColor: NemorixColors.primaryColor,
                        textColor: Colors.black,
                      ),
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

  Widget _buildFiatDropdown() {
    return DropdownButton<String>(
      value: selectedFiat,
      style: Theme.of(context).textTheme.labelLarge,
      underline: const SizedBox(),
      items:
          mockFiats
              .map(
                (currency) =>
                    DropdownMenuItem(value: currency, child: Text(currency)),
              )
              .toList(),
      onChanged: (value) => setState(() => selectedFiat = value!),
    );
  }

  Widget _buildCryptoDropdown() {
    return DropdownButton<Crypto>(
      value: selectedCrypto,
      style: Theme.of(context).textTheme.labelLarge,
      underline: const SizedBox(),
      items:
          mockCryptos
              .map(
                (crypto) => DropdownMenuItem(
                  value: crypto,
                  child: Text(crypto.abbreviation.toUpperCase()),
                ),
              )
              .toList(),
      onChanged: (value) => setState(() => selectedCrypto = value!),
    );
  }
}
