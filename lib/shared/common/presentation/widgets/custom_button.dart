import 'package:flutter/material.dart';

/// @file        action_button.dart
/// @brief       Reusable custom button widget for NemorixPay.
/// @details     A configurable button component that supports different styles (elevated, text, outlined),
///              sizes, and states.
/// @author      Miguel Fagundez
/// @date        06/16/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: (backgroundColor != null)
            ? backgroundColor
            : Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      label: Text(
        label,
        style: (textColor != null)
            ? Theme.of(context).textTheme.labelLarge?.copyWith(color: textColor)
            : Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
