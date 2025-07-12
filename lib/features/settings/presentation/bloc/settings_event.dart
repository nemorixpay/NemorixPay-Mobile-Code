/// @file        settings_event.dart
/// @brief       Events for Settings Bloc.
/// @details     Defines the events for loading and toggling dark mode preference.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class SettingsEvent {}

class LoadDarkModePreference extends SettingsEvent {}

class ToggleDarkMode extends SettingsEvent {}
