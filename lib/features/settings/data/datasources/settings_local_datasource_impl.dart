import 'package:nemorixpay/config/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_local_datasource.dart';

/// @file        settings_local_datasource_impl.dart
/// @brief       Implementation of SettingsLocalDatasource using SharedPreferences.
/// @details     Provides concrete implementation for local storage of settings preferences
///              using SharedPreferences with basic error handling and default values.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {
  static const String _darkModeKey = AppConstants.darkModeKey;
  static const String _languageKey = 'language';

  @override
  Future<bool> getDarkModePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Default to dark mode (true) if no preference is set
      return prefs.getBool(_darkModeKey) ?? true;
    } catch (e) {
      // Return dark mode as default if there's an error
      return true;
    }
  }

  @override
  Future<void> saveDarkModePreference(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_darkModeKey, isDarkMode);
    } catch (e) {
      throw Exception('Failed to save dark mode preference: $e');
    }
  }

  @override
  Future<bool> toggleDarkMode() async {
    try {
      final currentPreference = await getDarkModePreference();
      final newPreference = !currentPreference;
      await saveDarkModePreference(newPreference);
      return newPreference;
    } catch (e) {
      throw Exception('Failed to toggle dark mode: $e');
    }
  }

  @override
  Future<String> getLanguagePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Default to English if no preference is set
      return prefs.getString(_languageKey) ?? 'en';
    } catch (e) {
      // Return English as default if there's an error
      return 'en';
    }
  }

  @override
  Future<void> saveLanguagePreference(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {
      throw Exception('Failed to save language preference: $e');
    }
  }
}
