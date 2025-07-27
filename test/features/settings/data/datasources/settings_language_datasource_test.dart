import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/features/settings/data/datasources/settings_local_datasource_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @file        settings_language_datasource_test.dart
/// @brief       Unit tests for language functionality in SettingsLocalDatasource.
/// @details     Tests the local storage functionality for language preferences using SharedPreferences.
/// @author      Miguel Fagundez
/// @date        07/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  group('SettingsLocalDatasource - Language', () {
    late SettingsLocalDatasourceImpl datasource;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      datasource = SettingsLocalDatasourceImpl();
    });

    group('getLanguagePreference', () {
      test('should return default language (en) when no preference is set',
          () async {
        final result = await datasource.getLanguagePreference();
        expect(result, 'en');
      });

      test('should return saved language preference', () async {
        await prefs.setString('language', 'es');

        final result = await datasource.getLanguagePreference();
        expect(result, 'es');
      });

      test('should return English when English is saved', () async {
        await prefs.setString('language', 'en');

        final result = await datasource.getLanguagePreference();
        expect(result, 'en');
      });

      test('should return Spanish when Spanish is saved', () async {
        await prefs.setString('language', 'es');

        final result = await datasource.getLanguagePreference();
        expect(result, 'es');
      });

      test('should return Portuguese when Portuguese is saved', () async {
        await prefs.setString('language', 'pt');

        final result = await datasource.getLanguagePreference();
        expect(result, 'pt');
      });

      test('should handle different language codes', () async {
        const testCases = ['en', 'es', 'pt', 'fr', 'de', 'it'];

        for (final language in testCases) {
          await prefs.setString('language', language);

          final result = await datasource.getLanguagePreference();
          expect(result, language);
        }
      });
    });

    group('saveLanguagePreference', () {
      test('should save language preference correctly', () async {
        await datasource.saveLanguagePreference('es');

        expect(prefs.getString('language'), 'es');
      });

      test('should save English language preference', () async {
        await datasource.saveLanguagePreference('en');

        expect(prefs.getString('language'), 'en');
      });

      test('should save Portuguese language preference', () async {
        await datasource.saveLanguagePreference('pt');

        expect(prefs.getString('language'), 'pt');
      });

      test('should overwrite existing language preference', () async {
        // First save English
        await datasource.saveLanguagePreference('en');
        expect(prefs.getString('language'), 'en');

        // Then save Spanish
        await datasource.saveLanguagePreference('es');
        expect(prefs.getString('language'), 'es');
      });

      test('should handle empty language code', () async {
        await datasource.saveLanguagePreference('');

        expect(prefs.getString('language'), '');
      });

      test('should handle different language codes', () async {
        const testCases = ['en', 'es', 'pt', 'fr', 'de', 'it'];

        for (final language in testCases) {
          await datasource.saveLanguagePreference(language);
          expect(prefs.getString('language'), language);
        }
      });
    });

    group('Language preference persistence', () {
      test('should persist language preference across multiple reads',
          () async {
        await datasource.saveLanguagePreference('es');

        // Read multiple times
        final result1 = await datasource.getLanguagePreference();
        final result2 = await datasource.getLanguagePreference();
        final result3 = await datasource.getLanguagePreference();

        expect(result1, 'es');
        expect(result2, 'es');
        expect(result3, 'es');
      });

      test('should maintain default language when no preference is saved',
          () async {
        // Read multiple times without saving
        final result1 = await datasource.getLanguagePreference();
        final result2 = await datasource.getLanguagePreference();
        final result3 = await datasource.getLanguagePreference();

        expect(result1, 'en');
        expect(result2, 'en');
        expect(result3, 'en');
      });
    });
  });
}
