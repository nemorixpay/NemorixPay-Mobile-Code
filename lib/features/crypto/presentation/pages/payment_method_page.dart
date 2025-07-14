import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/data/mock_credit_cards.dart';
import 'package:nemorixpay/features/crypto/domain/entities/credit_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/custom_button_tile.dart';
import 'package:nemorixpay/features/crypto/domain/entities/payment_method_validator.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/credit_card_gradient.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        payment_method_page.dart
/// @brief       Payment method page.
/// @details     This file contains the base code for the second step in the crypto purchase process:
///              selecting the payment method.
/// @author      Miguel Fagundez
/// @date        2025-04-21
/// @version     1.1
/// @copyright   Apache 2.0 License
class PaymentMethodPage extends StatefulWidget {
  final String cryptoName;
  final double amount;
  final String currency;

  const PaymentMethodPage({
    super.key,
    required this.cryptoName,
    required this.amount,
    required this.currency,
  });

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  int selectedCardIndex = 0;
  bool sendReceipt = false;
  String selectedMethod = '';
  PaymentMethodValidationState _validationState =
      PaymentMethodValidationState.valid;

  @override
  void initState() {
    // TODO: implement initState
    debugPrint('cryptoName: ${widget.cryptoName}');
    debugPrint('amount: ${widget.amount}');
    debugPrint('currency: ${widget.currency}');
    super.initState();
  }

  void _showAddCardDialog() {
    final numberController = TextEditingController();
    final holderController = TextEditingController();
    final expiryController = TextEditingController();
    String selectedType = 'Visa';
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(localizations.addNewCardTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: numberController,
              decoration:
                  InputDecoration(labelText: localizations.cardNumberLabel),
            ),
            TextField(
              controller: holderController,
              decoration:
                  InputDecoration(labelText: localizations.cardHolderLabel),
            ),
            TextField(
              controller: expiryController,
              decoration:
                  InputDecoration(labelText: localizations.expiryDateLabel),
            ),
            DropdownButton<String>(
              value: selectedType,
              items: ['Visa', 'MasterCard', 'ApplePay']
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => selectedType = value!),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(localizations.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (numberController.text.isNotEmpty &&
                  holderController.text.isNotEmpty &&
                  expiryController.text.isNotEmpty) {
                setState(() {
                  creditCards.add(
                    CreditCard(
                      number: numberController.text,
                      holder: holderController.text,
                      expiry: expiryController.text,
                      type: selectedType,
                    ),
                  );
                  selectedCardIndex = creditCards.length - 1;
                  selectedMethod = 'Credit Card';
                  _validatePaymentMethod();
                });
                Navigator.pop(context);
              }
            },
            child: Text(localizations.addButton),
          ),
        ],
      ),
    );
  }

  void _validatePaymentMethod() {
    setState(() {
      _validationState = PaymentMethodValidator.validatePaymentMethod(
        selectedCardIndex: selectedCardIndex,
        cards: creditCards,
        selectedMethod: selectedMethod,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(
                title: localizations.paymentMethodTitle,
                showSearchButton: false,
              ),
              const SizedBox(height: 20),
              // Credit Card Selector
              BaseCard(
                cardWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.creditCardLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: DropdownButton<int>(
                        value: selectedCardIndex,
                        items: List.generate(
                          creditCards.length,
                          (index) => DropdownMenuItem(
                            value: index,
                            child: Row(
                              children: [
                                (creditCards[index].type == 'Visa')
                                    ? const FaIcon(FontAwesomeIcons.ccVisa)
                                    : const FaIcon(
                                        FontAwesomeIcons.ccMastercard),
                                const SizedBox(width: 8.0),
                                Text(
                                  creditCards[index].number,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedCardIndex = value!;
                            selectedMethod = 'Credit Card';
                            _validatePaymentMethod();
                          });
                        },
                      ),
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CreditCardGradient(
                          card: creditCards[selectedCardIndex],
                        ),
                        if (creditCards.length > 1)
                          GestureDetector(
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              size: 24,
                            ),
                            onTap: () {
                              setState(() {
                                creditCards.removeAt(selectedCardIndex);
                                if (creditCards.isEmpty) {
                                  selectedCardIndex = -1;
                                  selectedMethod = '';
                                } else {
                                  selectedCardIndex = 0;
                                }
                                _validatePaymentMethod();
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: _showAddCardDialog,
                        child: Text(
                          localizations.addNewCardButton,
                          style: const TextStyle(
                            color: NemorixColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Other Payment buttons
              CustomButtonTile(
                label: localizations.googlePayLabel,
                widgetLeft: const FaIcon(
                  size: 16,
                  FontAwesomeIcons.google,
                  color: NemorixColors.primaryColor,
                ),
                widgetRight: const Icon(Icons.arrow_forward_ios),
                function: () {
                  debugPrint('Google Play');

                  NemorixSnackBar.show(
                    context,
                    message:
                        AppLocalizations.of(context)!.featureNotImplemented,
                    type: SnackBarType.info,
                  );

                  // setState(() {
                  //   selectedMethod = 'Google Pay';
                  //   _validatePaymentMethod();
                  // });
                },
              ),
              const SizedBox(height: 10),
              CustomButtonTile(
                widgetLeft: const FaIcon(
                  size: 16,
                  FontAwesomeIcons.apple,
                  color: NemorixColors.primaryColor,
                ),
                widgetRight: const Icon(Icons.arrow_forward_ios),
                label: localizations.applePayLabel,
                function: () {
                  debugPrint('Apple Pay');

                  NemorixSnackBar.show(
                    context,
                    message:
                        AppLocalizations.of(context)!.featureNotImplemented,
                    type: SnackBarType.info,
                  );
                  // setState(() {
                  //   selectedMethod = 'Apple Pay';
                  //   _validatePaymentMethod();
                  // });
                },
              ),
              const SizedBox(height: 10),
              CustomButtonTile(
                label: localizations.mobileBankingLabel,
                widgetRight: const Icon(Icons.arrow_forward_ios),
                widgetLeft: const Icon(
                  size: 16,
                  Icons.phone_iphone,
                  color: NemorixColors.primaryColor,
                ),
                function: () {
                  debugPrint('Mobile Banking');

                  NemorixSnackBar.show(
                    context,
                    message:
                        AppLocalizations.of(context)!.featureNotImplemented,
                    type: SnackBarType.info,
                  );
                  // setState(() {
                  //   selectedMethod = 'Mobile Banking';
                  //   _validatePaymentMethod();
                  // });
                },
              ),
              if (_validationState != PaymentMethodValidationState.valid) ...[
                const SizedBox(height: 16),
                Text(
                  PaymentMethodValidator.getErrorMessage(
                    context,
                    _validationState,
                  ),
                  style: const TextStyle(
                    color: NemorixColors.errorColor,
                    fontSize: 14,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              // Switch email option
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.sendReceiptLabel,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Switch(
                    value: sendReceipt,
                    onChanged: (value) => setState(() => sendReceipt = value),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Continue button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedElevatedButton(
                  text: localizations.continueText,
                  onPressed:
                      _validationState == PaymentMethodValidationState.valid
                          ? () {
                              NemorixSnackBar.show(
                                context,
                                message: AppLocalizations.of(context)!
                                    .featureNotImplemented,
                                type: SnackBarType.info,
                              );
                            }
                          : null,
                  backgroundColor:
                      _validationState == PaymentMethodValidationState.valid
                          ? NemorixColors.primaryColor
                          : NemorixColors.greyLevel2,
                  textColor:
                      _validationState == PaymentMethodValidationState.valid
                          ? Colors.black
                          : NemorixColors.greyLevel3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
