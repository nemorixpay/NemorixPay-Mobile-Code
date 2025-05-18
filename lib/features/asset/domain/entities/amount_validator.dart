import 'package:flutter/services.dart';

/// @file        amount_validator.dart
/// @brief       Utility class for amount validation in asset transactions.
/// @details     This class provides methods to validate transaction amounts,
///              including format validation and minimum amount checks.
/// @author      Miguel Fagundez
/// @date        2025-04-30
/// @version     1.0
/// @copyright   Apache 2.0 License
enum AmountValidationState { valid, invalidFormat, belowMinimum, aboveMaximum }

class AmountValidator {
  static const double minimumAmount = 1.0;
  static const double maximumAmount = 100000000.0;

  static AmountValidationState validateAmount(String amount) {
    final parsedAmount = double.tryParse(amount);

    if (parsedAmount == null) {
      return AmountValidationState.invalidFormat;
    }

    if (parsedAmount < minimumAmount) {
      return AmountValidationState.belowMinimum;
    }

    if (parsedAmount > maximumAmount) {
      return AmountValidationState.aboveMaximum;
    }

    return AmountValidationState.valid;
  }
}

class AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remover caracteres no numéricos excepto el punto decimal
    final String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Verificar si hay más de un punto decimal
    if (cleanedText.split('.').length > 2) {
      return oldValue;
    }

    // Verificar si el número excede el máximo
    final double? parsedValue = double.tryParse(cleanedText);
    if (parsedValue != null && parsedValue > AmountValidator.maximumAmount) {
      return oldValue;
    }

    // Limitar a 2 decimales
    if (cleanedText.contains('.')) {
      final parts = cleanedText.split('.');
      if (parts[1].length > 2) {
        return oldValue;
      }
    }

    return TextEditingValue(
      text: cleanedText,
      selection: TextSelection.collapsed(offset: cleanedText.length),
    );
  }
}
