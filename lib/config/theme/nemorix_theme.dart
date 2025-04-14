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
    primaryColor: NemorixColors.primaryColor,
    cardColor: NemorixColors.greyLevel1,
  );
  static final ThemeData lightThemeMode = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: NemorixColors.lightModeBackground,
    appBarTheme: const AppBarTheme(backgroundColor: NemorixColors.greyLevel6),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: NemorixColors.primaryColor,
    ),
    // checkboxTheme: const CheckboxThemeData(
    //   checkColor:
    // ),
    primaryColor: NemorixColors.primaryColor,
    cardColor: NemorixColors.greyLevel6,
  );
}
