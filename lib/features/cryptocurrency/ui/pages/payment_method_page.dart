import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entity/credit_card.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/credit_card_gradient.dart';
import 'package:nemorixpay/shared/data/mock_credit_cards.dart';
import 'package:nemorixpay/shared/ui/widgets/base_card.dart';
import 'package:nemorixpay/shared/ui/widgets/custom_button_tile.dart';
import 'package:nemorixpay/shared/ui/widgets/main_header.dart';
import 'package:nemorixpay/shared/ui/widgets/rounded_elevated_button.dart';

/// @file        payment_method_page.dart
/// @brief       Payment method page.
/// @details     This file contains the base code for the second step in the crypto purchase process: selecting the payment method.
/// @author      Miguel Fagundez
/// @date        2025-04-21
/// @version     1.0
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

  void _showAddCardDialog() {
    final numberController = TextEditingController();
    final holderController = TextEditingController();
    final expiryController = TextEditingController();
    String selectedType = 'Visa';

    // TODO TEMPORAL
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
              const MainHeader(title: 'Payment Method'),
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
                        // dropdownColor: NemorixColors.primaryColor,
                        items: List.generate(
                          creditCards.length,
                          (index) => DropdownMenuItem(
                            value: index,
                            child: Row(
                              children: [
                                (creditCards[index].type == 'Visa')
                                    ? FaIcon(FontAwesomeIcons.ccVisa)
                                    : FaIcon(FontAwesomeIcons.ccMastercard),
                                SizedBox(width: 8.0),
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
                          child: Icon(Icons.delete_forever_rounded, size: 24),
                          onTap: () {
                            debugPrint('Credit Card Deleted');
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
                widgetRight: const Icon(
                  Icons.arrow_forward_ios,
                  // color: Colors.white,
                ),
                function: () {
                  debugPrint('New Google Pay');
                },
              ),
              const SizedBox(height: 10),
              CustomButtonTile(
                widgetLeft: FaIcon(
                  size: 16,
                  FontAwesomeIcons.apple,
                  color: NemorixColors.primaryColor,
                ),
                widgetRight: const Icon(
                  Icons.arrow_forward_ios,
                  // color: Colors.white,
                ),
                label: 'Apple Pay',
                // icon: Icons.chevron_right_outlined,
                function: () {
                  debugPrint('New Apple Pay');
                },
              ),
              const SizedBox(height: 10),
              CustomButtonTile(
                label: 'Mobile Banking',
                widgetRight: const Icon(
                  Icons.arrow_forward_ios,
                  // color: Colors.white,
                ),
                widgetLeft: const Icon(
                  size: 16,
                  Icons.phone_iphone,
                  color: NemorixColors.primaryColor,
                ),
                function: () {
                  debugPrint('New Mobile Banking');
                },
              ),
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
                  onPressed: () {
                    debugPrint('Button continue pressed');
                  }, // Flutter bloc action
                  backgroundColor: NemorixColors.primaryColor,
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
