import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_dark_mode_preference.dart';
import '../../domain/usecases/toggle_dark_mode_usecase.dart';
import '../../domain/usecases/get_language_usecase.dart';
import '../../domain/usecases/set_language_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

/// @file        settings_bloc.dart
/// @brief       Bloc for Settings feature.
/// @details     Handles loading and toggling dark mode preference and language management.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetDarkModePreference getDarkModePreference;
  final ToggleDarkModeUseCase toggleDarkModeUseCase;
  final GetLanguageUseCase getLanguagePreference;
  final SetLanguageUseCase setLanguagePreference;

  SettingsBloc({
    required this.getDarkModePreference,
    required this.toggleDarkModeUseCase,
    required this.getLanguagePreference,
    required this.setLanguagePreference,
  }) : super(SettingsInitial()) {
    on<LoadCompleteSettingsData>(_onLoadCompleteSettingsData);
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<LoadLanguagePreference>(_onLoadLanguagePreference);
    on<SetLanguage>(_onSetLanguage);
  }

  Future<void> _onLoadCompleteSettingsData(
    LoadCompleteSettingsData event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    try {
      final isDarkMode = await getDarkModePreference();
      final currentLanguage = await getLanguagePreference();

      emit(SettingsLoaded(
        isDarkMode: isDarkMode,
        currentLanguage: currentLanguage,
        supportedLanguages: [],
      ));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onToggleDarkMode(
    ToggleDarkMode event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newDarkModeValue = await toggleDarkModeUseCase();
      emit(DarkModeToggled(isDarkMode: newDarkModeValue));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onLoadLanguagePreference(
    LoadLanguagePreference event,
    Emitter<SettingsState> emit,
  ) async {
    debugPrint('SettingsBloc: _onLoadLanguagePreference - Starting');
    try {
      final currentLanguage = await getLanguagePreference();
      debugPrint(
          'SettingsBloc: _onLoadLanguagePreference - Got language: $currentLanguage');
      emit(LanguageLoaded(currentLanguage: currentLanguage));
      debugPrint(
          'SettingsBloc: _onLoadLanguagePreference - Emitted LanguageLoaded');
    } catch (e) {
      debugPrint('SettingsBloc: _onLoadLanguagePreference - Error: $e');
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onSetLanguage(
    SetLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await setLanguagePreference(event.languageCode);
      emit(LanguageChanged(newLanguage: event.languageCode));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
