import 'dart:math';

import 'package:intl/intl.dart';

/// @file        truncate_doubles.dart
/// @brief       Extension for formatting and truncating double values.
/// @details     Provides a method to format double numbers with specified decimal places
///              and proper thousand separators. Uses NumberFormat for consistent
///              formatting across the application.
/// @author      Miguel Fagundez
/// @date        06/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
extension TruncateDoubles on double {
  String truncateToDecimalPlaces(int fractionalDigits) {
    final number = (this * pow(10, fractionalDigits)).truncate() /
        pow(10, fractionalDigits);
    var numberFormat = NumberFormat("##,###.00#", "en_US");
    return numberFormat.format(number);
  }
}
