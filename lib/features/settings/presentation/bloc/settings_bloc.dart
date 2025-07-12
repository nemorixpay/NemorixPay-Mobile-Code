import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_dark_mode_preference.dart';
import '../../domain/usecases/toggle_dark_mode_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

/// @file        settings_bloc.dart
/// @brief       Bloc for Settings feature.
/// @details     Handles loading and toggling dark mode preference.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetDarkModePreference getDarkModePreference;
  final ToggleDarkModeUseCase toggleDarkModeUseCase;

  SettingsBloc({
    required this.getDarkModePreference,
    required this.toggleDarkModeUseCase,
  }) : super(SettingsInitial()) {
    on<LoadDarkModePreference>(_onLoadDarkModePreference);
    on<ToggleDarkMode>(_onToggleDarkMode);
  }

  Future<void> _onLoadDarkModePreference(
    LoadDarkModePreference event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    try {
      final isDarkMode = await getDarkModePreference();
      emit(SettingsLoaded(isDarkMode: isDarkMode));
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
}
