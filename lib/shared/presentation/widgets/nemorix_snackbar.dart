import 'package:flutter/material.dart';

/// @file        nemorix_snackbar.dart
/// @brief       Reusable SnackBar widget for NemorixPay.
/// @details     Provides a consistent, theme-aware SnackBar for feedback across the app.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License
class NemorixSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
  }) {
    final theme = Theme.of(context);
    final snackBar = SnackBar(
      content: Text(
        message,
        style:
            textColor != null
                ? theme.textTheme.bodyMedium?.copyWith(color: textColor)
                : theme.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor ?? Theme.of(context).cardColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      elevation: 6,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
