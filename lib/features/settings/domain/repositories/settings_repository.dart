/// @file        settings_repository.dart
/// @brief       Repository interface for Settings feature.
/// @details     Defines contract for managing user settings preferences.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class SettingsRepository {
  /// Gets the current dark mode preference
  Future<bool> getDarkModePreference();

  /// Saves the dark mode preference
  Future<void> saveDarkModePreference(bool isDarkMode);

  /// Toggles the current dark mode preference
  Future<bool> toggleDarkMode();
}
