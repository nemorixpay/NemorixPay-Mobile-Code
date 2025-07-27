/// @file        settings_local_datasource.dart
/// @brief       Local datasource for Settings preferences.
/// @details     Provides access to user settings preferences stored locally using SharedPreferences.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

abstract class SettingsLocalDatasource {
  /// Gets the current dark mode preference
  Future<bool> getDarkModePreference();

  /// Saves the dark mode preference
  Future<void> saveDarkModePreference(bool isDarkMode);

  /// Toggles the current dark mode preference
  Future<bool> toggleDarkMode();

  /// Gets the current language preference
  Future<String> getLanguagePreference();

  /// Saves the language preference
  Future<void> saveLanguagePreference(String languageCode);
}
