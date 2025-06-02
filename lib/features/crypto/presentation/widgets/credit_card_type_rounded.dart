import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

/// @file        credit_card_type_rounded.dart
/// @brief       Show credit card information in a rounded widget.
/// @details     This file contains general code for building a rounded credit card ifnormation using a border decoration.
/// @author      Miguel Fagundez
/// @date        2025-04-22
/// @version     1.0
/// @copyright   Apache 2.0 License
class CreditCardTypeRounded extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CreditCardTypeRounded({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? NemorixColors.primaryColor : Colors.grey.shade800,
        ),
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label),
    );
  }
}
