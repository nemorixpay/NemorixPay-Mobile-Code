import 'package:nemorixpay/features/cryptocurrency/domain/entity/credit_card.dart';

/// @file        mock_credit_cards.dart
/// @brief       Mock data list for credit cards.
/// @details     This file includes sample credit card information used for UI development and testing.
/// @author      Miguel Fagundez
/// @date        2025-04-21
/// @version     1.0
/// @copyright   Apache 2.0 License
final List<CreditCard> creditCards = [
  CreditCard(
    number: '4629 9257 0189 4327',
    holder: 'John Greene',
    expiry: '09/24',
    type: 'Visa',
  ),
  CreditCard(
    number: '5423 8765 4321 1122',
    holder: 'Alice Smith',
    expiry: '11/25',
    type: 'MasterCard',
  ),
  CreditCard(
    number: '3782 822463 10005',
    holder: 'Emma Watson',
    expiry: '01/26',
    type: 'Visa',
  ),
];
