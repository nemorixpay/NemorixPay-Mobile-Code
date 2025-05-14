import 'package:flutter/material.dart';

/// @file        nemorix_colors.dart
/// @brief       Color palette for NemorixPay app.
/// @details     Defines the color scheme used throughout the application, including
///              primary colors, semantic colors, and grayscale variations.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License

/// Color palette for NemorixPay application
class NemorixColors {
  /// Main black color used for text and primary elements
  static const Color mainBlack = Color(0xFF03110A);

  /// Pure white color
  static const Color white = Color(0xFFFFFFFF);

  /// Background color for dark mode
  static const Color darkModeBackground = Color(0xFF04160D);

  /// Background color for light mode
  static const Color lightModeBackground = Color(0xFFFFFFFF);

  /// Primary brand color - Gold
  static const Color primaryColor = Color(0xFFE7C200);

  /// Secondary color - Light gray
  static const Color secondaryColor = Color(0XFFF6F7F8);

  /// Error state color - Red
  static const Color errorColor = Color(0xFFF65556);

  /// Darkest gray level - Used for primary text
  static const Color greyLevel1 = Color(0xFF272727);

  /// Dark gray level - Used for secondary text
  static const Color greyLevel2 = Color(0xFF5E5E5E);

  /// Medium gray level - Used for tertiary text
  static const Color greyLevel3 = Color(0xFF949494);

  /// Light gray level - Used for borders and dividers
  static const Color greyLevel4 = Color(0xFFCCCCCC);

  /// Very light gray level - Used for disabled states
  static const Color greyLevel5 = Color(0xFFEEEEEE);

  /// Lightest gray level - Used for backgrounds
  static const Color greyLevel6 = Color(0xFFF8F8F8);

  /// Success state color - Bright green
  static const Color successColor = Color(0xFF09ff04);

  /// Warning state color - Orange
  static const Color warningColor = Color(0xFFFFA500);

  /// Information state color - Light blue
  static const Color infoColor = Color(0xFF4A90E2);
}
