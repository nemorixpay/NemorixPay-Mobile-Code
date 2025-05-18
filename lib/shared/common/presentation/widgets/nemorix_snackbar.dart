import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

/// @file        nemorix_snackbar.dart
/// @brief       Reusable SnackBar widget for NemorixPay.
/// @details     Provides a consistent, theme-aware SnackBar for feedback across the app.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License

/// Enum that defines the available SnackBar types
enum SnackBarType { success, error, warning, info }

class NemorixSnackBar {
  /// Shows a SnackBar using local context
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(context);
    final snackBar = _buildSnackBar(
      message: message,
      type: type,
      duration: duration,
      theme: theme,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Builds the SnackBar with the appropriate style based on type
  static SnackBar _buildSnackBar({
    required String message,
    required SnackBarType type,
    required Duration duration,
    required ThemeData theme,
  }) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = theme.cardColor;
        borderColor = NemorixColors.successColor;
        textColor = NemorixColors.successColor;
        break;
      case SnackBarType.error:
        backgroundColor = theme.cardColor;
        borderColor = NemorixColors.errorColor;
        textColor = NemorixColors.errorColor;
        break;
      case SnackBarType.warning:
        backgroundColor = theme.cardColor;
        borderColor = NemorixColors.warningColor;
        textColor = NemorixColors.warningColor;
        break;
      case SnackBarType.info:
        backgroundColor = theme.cardColor;
        borderColor = NemorixColors.infoColor;
        textColor = NemorixColors.infoColor;
        break;
    }

    return SnackBar(
      content: Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      elevation: 6,
    );
  }
}
