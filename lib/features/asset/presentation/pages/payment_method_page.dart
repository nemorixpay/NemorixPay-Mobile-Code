import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/asset/domain/entities/credit_card.dart';
import 'package:nemorixpay/features/asset/domain/entities/payment_method_validator.dart';
import 'package:nemorixpay/features/asset/presentation/widgets/credit_card_gradient.dart';
import 'package:nemorixpay/shared/common/data/mock_credit_cards.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/custom_button_tile.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        payment_method_page.dart
/// @brief       Payment method page.
/// @details     This file contains the base code for the second step in the asset purchase process: selecting the payment method.
/// @author      Miguel Fagundez
/// @date        2025-04-21
/// @version     1.1
/// @copyright   Apache 2.0 License
class PaymentMethodPage extends StatefulWidget {
  final String assetName;
  final double amount;
  final String currency;

  const PaymentMethodPage({
    super.key,
    required this.assetName,
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

  void _showAddCardDialog() {
    final numberController = TextEditingController();
    final holderController = TextEditingController();
    final expiryController = TextEditingController();
    String selectedType = 'Visa';

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Add New Card'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: numberController,
                  decoration: const InputDecoration(labelText: 'Card Number'),
                ),
                TextField(
                  controller: holderController,
                  decoration: const InputDecoration(labelText: 'Card Holder'),
                ),
                TextField(
                  controller: expiryController,
                  decoration: const InputDecoration(labelText: 'Expiry Date'),
                ),
                DropdownButton<String>(
                  value: selectedType,
                  items:
                      ['Visa', 'MasterCard', 'ApplePay']
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
                child: const Text('Cancel'),
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
                child: const Text('Add'),
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainHeader(
                title: 'Payment Method',
                showSearchButton: false,
              ),
              const SizedBox(height: 20),
              // Credit Card Selector
              BaseCard(
                cardWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Credit Card',
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
                                    ? FaIcon(FontAwesomeIcons.ccVisa)
                                    : FaIcon(FontAwesomeIcons.ccMastercard),
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
                        child: const Text(
                          '+add new card',
                          style: TextStyle(
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
                label: 'Google Pay',
                widgetLeft: FaIcon(
                  size: 16,
                  FontAwesomeIcons.google,
                  color: NemorixColors.primaryColor,
                ),
                widgetRight: const Icon(Icons.arrow_forward_ios),
                function: () {
                  setState(() {
                    selectedMethod = 'Google Pay';
                    _validatePaymentMethod();
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomButtonTile(
                widgetLeft: FaIcon(
                  size: 16,
                  FontAwesomeIcons.apple,
                  color: NemorixColors.primaryColor,
                ),
                widgetRight: const Icon(Icons.arrow_forward_ios),
                label: 'Apple Pay',
                function: () {
                  setState(() {
                    selectedMethod = 'Apple Pay';
                    _validatePaymentMethod();
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomButtonTile(
                label: 'Mobile Banking',
                widgetRight: const Icon(Icons.arrow_forward_ios),
                widgetLeft: const Icon(
                  size: 16,
                  Icons.phone_iphone,
                  color: NemorixColors.primaryColor,
                ),
                function: () {
                  setState(() {
                    selectedMethod = 'Mobile Banking';
                    _validatePaymentMethod();
                  });
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
                  const Text(
                    'Send receipt to your email',
                    style: TextStyle(color: Colors.white),
                  ),
                  Switch(
                    value: sendReceipt,
                    activeColor: NemorixColors.primaryColor,
                    onChanged: (value) => setState(() => sendReceipt = value),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Continue button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedElevatedButton(
                  text: 'Continue',
                  onPressed:
                      _validationState == PaymentMethodValidationState.valid
                          ? () {
                            debugPrint('Button continue pressed');
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
