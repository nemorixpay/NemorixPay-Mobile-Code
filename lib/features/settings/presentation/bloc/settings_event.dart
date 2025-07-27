/// @file        settings_event.dart
/// @brief       Events for Settings Bloc.
/// @details     Defines the events for loading and toggling dark mode preference and language management.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

abstract class SettingsEvent {}

class LoadCompleteSettingsData extends SettingsEvent {}

class ToggleDarkMode extends SettingsEvent {}

class LoadLanguagePreference extends SettingsEvent {}

class SetLanguage extends SettingsEvent {
  final String languageCode;
  SetLanguage(this.languageCode);
}
