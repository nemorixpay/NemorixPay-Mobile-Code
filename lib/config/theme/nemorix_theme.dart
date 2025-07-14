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
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return NemorixColors.primaryColor; // Fill color when selected
        }
        if (states.contains(WidgetState.disabled)) {
          return Colors.blue; // Fill color when selected
        }
        return null; // Use the default fill color when not selected
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? NemorixColors.primaryColor
            : null,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? NemorixColors.greyLevel2
            : null,
      ),
    ),
    primaryColor: NemorixColors.primaryColor,
    cardColor: NemorixColors.greyLevel1,
    textTheme: const TextTheme(
      labelSmall: TextStyle(color: NemorixColors.greyLevel4),
      labelMedium: TextStyle(color: NemorixColors.greyLevel4),
      labelLarge: TextStyle(color: NemorixColors.greyLevel6),
      bodySmall: TextStyle(color: NemorixColors.greyLevel6),
      bodyMedium: TextStyle(color: NemorixColors.greyLevel6),
      bodyLarge: TextStyle(color: NemorixColors.greyLevel6),
      titleSmall: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: NemorixColors.greyLevel5),
      headlineMedium: TextStyle(color: NemorixColors.greyLevel5),
      headlineLarge: TextStyle(color: NemorixColors.greyLevel5),
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
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return NemorixColors.primaryColor; // Fill color when selected
        }
        if (states.contains(WidgetState.disabled)) {
          return Colors.blue; // Fill color when selected
        }
        return null; // Use the default fill color when not selected
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? NemorixColors.primaryColor
            : null,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? NemorixColors.greyLevel2
            : null,
      ),
    ),
    primaryColor: NemorixColors.primaryColor,
    cardColor: NemorixColors.greyLevel6,
    textTheme: const TextTheme(
      labelSmall: TextStyle(color: NemorixColors.greyLevel3),
      labelMedium: TextStyle(color: NemorixColors.greyLevel3),
      labelLarge: TextStyle(color: NemorixColors.greyLevel2),
      bodySmall: TextStyle(color: NemorixColors.greyLevel2),
      bodyMedium: TextStyle(color: NemorixColors.greyLevel2),
      bodyLarge: TextStyle(color: NemorixColors.greyLevel2),
      titleSmall: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      headlineSmall: TextStyle(color: NemorixColors.greyLevel2),
      headlineMedium: TextStyle(color: NemorixColors.greyLevel2),
      headlineLarge: TextStyle(color: NemorixColors.greyLevel2),
    ),
  );
}
