import 'package:equatable/equatable.dart';

/// @file        settings_state.dart
/// @brief       States for Settings feature.
/// @details     Defines all possible states for the Settings feature including dark mode and language management.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDarkMode;
  final String currentLanguage;
  final List<Map<String, String>> supportedLanguages;

  const SettingsLoaded({
    required this.isDarkMode,
    required this.currentLanguage,
    required this.supportedLanguages,
  });

  @override
  List<Object?> get props => [isDarkMode, currentLanguage, supportedLanguages];
}

class DarkModeToggled extends SettingsState {
  final bool isDarkMode;

  const DarkModeToggled({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];
}

class LanguageChanged extends SettingsState {
  final String newLanguage;

  const LanguageChanged({required this.newLanguage});

  @override
  List<Object?> get props => [newLanguage];
}

class LanguageLoaded extends SettingsState {
  final String currentLanguage;

  const LanguageLoaded({required this.currentLanguage});

  @override
  List<Object?> get props => [currentLanguage];
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
