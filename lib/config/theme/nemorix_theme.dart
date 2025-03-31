import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

class NemorixTheme {
  static final ThemeData darkThemeMode = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: NemorixColors.darkModeBackground,
    appBarTheme: const AppBarTheme(backgroundColor: NemorixColors.greyLevel1),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: NemorixColors.primaryColor,
    ),
  );
  static final ThemeData lightThemeMode = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: NemorixColors.lightModeBackground,
    appBarTheme: const AppBarTheme(backgroundColor: NemorixColors.greyLevel6),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: NemorixColors.primaryColor,
    ),
  );
}
