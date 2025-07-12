import '../repositories/settings_repository.dart';

/// @file        get_dark_mode_preference.dart
/// @brief       Use case for retrieving dark mode preference.
/// @details     Calls the repository to get the current dark mode setting.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetDarkModePreference {
  final SettingsRepository repository;

  GetDarkModePreference(this.repository);

  Future<bool> call() async {
    return await repository.getDarkModePreference();
  }
}
