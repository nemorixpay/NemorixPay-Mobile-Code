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
    textTheme: TextTheme(
      labelSmall: TextStyle(color: NemorixColors.greyLevel4),
      labelMedium: TextStyle(color: NemorixColors.greyLevel4),
      labelLarge: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
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
    // checkboxTheme: const CheckboxThemeData(
    //   checkColor:
    // ),
    primaryColor: NemorixColors.primaryColor,
    cardColor: NemorixColors.greyLevel6,
    textTheme: TextTheme(
      labelSmall: TextStyle(color: NemorixColors.greyLevel3),
      labelMedium: TextStyle(color: NemorixColors.greyLevel3),
      labelLarge: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
    ),
  );
}
