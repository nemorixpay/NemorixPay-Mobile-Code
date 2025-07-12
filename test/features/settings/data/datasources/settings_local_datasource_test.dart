import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/features/settings/data/datasources/settings_local_datasource_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @file        settings_local_datasource_test.dart
/// @brief       Unit tests for SettingsLocalDatasource.
/// @details     Tests the local storage functionality for settings preferences using SharedPreferences.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  group('SettingsLocalDatasource', () {
    late SettingsLocalDatasourceImpl datasource;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      datasource = SettingsLocalDatasourceImpl();
    });

    group('getDarkModePreference', () {
      test('should return true (dark mode) when no preference is set',
          () async {
        final result = await datasource.getDarkModePreference();
        expect(result, true);
      });

      test('should return true when dark mode is saved', () async {
        await prefs.setBool('dark_mode_preference', true);

        final result = await datasource.getDarkModePreference();
        expect(result, true);
      });

      test('should return false when light mode is saved', () async {
        await prefs.setBool('dark_mode_preference', false);

        final result = await datasource.getDarkModePreference();
        expect(result, false);
      });
    });

    group('saveDarkModePreference', () {
      test('should save dark mode preference correctly', () async {
        await datasource.saveDarkModePreference(true);

        expect(prefs.getBool('dark_mode_preference'), true);
      });

      test('should save light mode preference correctly', () async {
        await datasource.saveDarkModePreference(false);

        expect(prefs.getBool('dark_mode_preference'), false);
      });
    });

    group('toggleDarkMode', () {
      test('should toggle from dark to light mode', () async {
        await prefs.setBool('dark_mode_preference', true);

        final result = await datasource.toggleDarkMode();

        expect(result, false);
        expect(prefs.getBool('dark_mode_preference'), false);
      });

      test('should toggle from light to dark mode', () async {
        await prefs.setBool('dark_mode_preference', false);

        final result = await datasource.toggleDarkMode();

        expect(result, true);
        expect(prefs.getBool('dark_mode_preference'), true);
      });

      test('should toggle from default (dark) to light mode', () async {
        final result = await datasource.toggleDarkMode();

        expect(result, false);
        expect(prefs.getBool('dark_mode_preference'), false);
      });
    });
  });
}
