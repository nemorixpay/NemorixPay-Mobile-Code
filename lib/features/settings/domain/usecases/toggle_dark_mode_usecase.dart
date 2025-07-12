import '../repositories/settings_repository.dart';

/// @file        toggle_dark_mode_usecase.dart
/// @brief       Use case for toggling dark mode preference.
/// @details     Calls the repository to toggle the current dark mode setting.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class ToggleDarkModeUseCase {
  final SettingsRepository repository;

  ToggleDarkModeUseCase(this.repository);

  Future<bool> call() async {
    return await repository.toggleDarkMode();
  }
}
