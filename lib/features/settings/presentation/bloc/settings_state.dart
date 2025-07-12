/// @file        settings_state.dart
/// @brief       States for Settings Bloc.
/// @details     Defines the states for loading, loaded, and error states of settings.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDarkMode;
  SettingsLoaded({required this.isDarkMode});
}

class DarkModeToggled extends SettingsState {
  final bool isDarkMode;
  DarkModeToggled({required this.isDarkMode});
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}
