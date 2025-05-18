import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'credit_card.dart';

/// @file        payment_method_validator.dart
/// @brief       Validator for payment methods.
/// @details     This file contains the validation logic for payment methods,
///              including states and error messages.
/// @author      Miguel Fagundez
/// @date        2025-05-01
/// @version     1.0
/// @copyright   Apache 2.0 License

enum PaymentMethodValidationState {
  valid,
  noMethodSelected,
  invalidCard,
  cardExpired,
}

class PaymentMethodValidator {
  static PaymentMethodValidationState validatePaymentMethod({
    required int selectedCardIndex,
    required List<CreditCard> cards,
    required String selectedMethod,
  }) {
    if (selectedMethod.isEmpty) {
      return PaymentMethodValidationState.noMethodSelected;
    }

    if (selectedMethod == 'Credit Card') {
      if (selectedCardIndex < 0 || selectedCardIndex >= cards.length) {
        return PaymentMethodValidationState.invalidCard;
      }

      final card = cards[selectedCardIndex];
      if (_isCardExpired(card.expiry)) {
        return PaymentMethodValidationState.cardExpired;
      }
    }

    return PaymentMethodValidationState.valid;
  }

  static bool _isCardExpired(String expiry) {
    try {
      final parts = expiry.split('/');
      if (parts.length != 2) return true;

      final month = int.parse(parts[0]);
      final year = int.parse('20${parts[1]}');

      final now = DateTime.now();
      final cardExpiry = DateTime(year, month + 1, 0);

      return now.isAfter(cardExpiry);
    } catch (e) {
      return true;
    }
  }

  static String getErrorMessage(
    BuildContext context,
    PaymentMethodValidationState state,
  ) {
    switch (state) {
      case PaymentMethodValidationState.noMethodSelected:
        return AppLocalizations.of(context)!.noPaymentMethodSelected;
      case PaymentMethodValidationState.invalidCard:
        return AppLocalizations.of(context)!.invalidCardSelected;
      case PaymentMethodValidationState.cardExpired:
        return AppLocalizations.of(context)!.cardExpired;
      case PaymentMethodValidationState.valid:
        return '';
    }
  }
}
