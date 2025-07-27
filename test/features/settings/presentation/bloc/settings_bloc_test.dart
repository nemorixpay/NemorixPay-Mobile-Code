import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/settings/domain/usecases/get_dark_mode_preference.dart';
import 'package:nemorixpay/features/settings/domain/usecases/toggle_dark_mode_usecase.dart';
import 'package:nemorixpay/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:nemorixpay/features/settings/domain/usecases/set_language_usecase.dart';
import 'package:nemorixpay/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:nemorixpay/features/settings/presentation/bloc/settings_event.dart';
import 'package:nemorixpay/features/settings/presentation/bloc/settings_state.dart';

/// @file        settings_bloc_test.dart
/// @brief       Unit tests for SettingsBloc.
/// @details     Tests the business logic for settings management including dark mode and language preferences.
/// @author      Miguel Fagundez
/// @date        07/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

// Generate mocks
@GenerateMocks([
  GetDarkModePreference,
  ToggleDarkModeUseCase,
  GetLanguageUseCase,
  SetLanguageUseCase,
])
import 'settings_bloc_test.mocks.dart';

void main() {
  group('SettingsBloc', () {
    late SettingsBloc bloc;
    late MockGetDarkModePreference mockGetDarkModePreference;
    late MockToggleDarkModeUseCase mockToggleDarkModeUseCase;
    late MockGetLanguageUseCase mockGetLanguagePreference;
    late MockSetLanguageUseCase mockSetLanguagePreference;

    setUp(() {
      mockGetDarkModePreference = MockGetDarkModePreference();
      mockToggleDarkModeUseCase = MockToggleDarkModeUseCase();
      mockGetLanguagePreference = MockGetLanguageUseCase();
      mockSetLanguagePreference = MockSetLanguageUseCase();

      bloc = SettingsBloc(
        getDarkModePreference: mockGetDarkModePreference,
        toggleDarkModeUseCase: mockToggleDarkModeUseCase,
        getLanguagePreference: mockGetLanguagePreference,
        setLanguagePreference: mockSetLanguagePreference,
      );
    });

    tearDown(() {
      bloc.close();
    });

    group('LoadCompleteSettingsData', () {
      test('should emit [SettingsLoading, SettingsLoaded] when successful',
          () async {
        // Arrange
        when(mockGetDarkModePreference()).thenAnswer((_) async => true);
        when(mockGetLanguagePreference()).thenAnswer((_) async => 'en');

        // Act
        bloc.add(LoadCompleteSettingsData());

        // Assert
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<SettingsLoading>(),
            isA<SettingsLoaded>()
                .having(
                  (state) => state.isDarkMode,
                  'isDarkMode',
                  true,
                )
                .having(
                  (state) => state.currentLanguage,
                  'currentLanguage',
                  'en',
                )
                .having(
              (state) => state.supportedLanguages,
              'supportedLanguages',
              [],
            ),
          ]),
        );
      });

      test(
          'should emit [SettingsLoading, SettingsError] when getDarkModePreference fails',
          () async {
        // Arrange
        when(mockGetDarkModePreference())
            .thenThrow(Exception('Database error'));

        // Act
        bloc.add(LoadCompleteSettingsData());

        // Assert
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<SettingsLoading>(),
            isA<SettingsError>().having(
              (state) => state.message,
              'message',
              'Exception: Database error',
            ),
          ]),
        );
      });

      test(
          'should emit [SettingsLoading, SettingsError] when getLanguagePreference fails',
          () async {
        // Arrange
        when(mockGetDarkModePreference()).thenAnswer((_) async => true);
        when(mockGetLanguagePreference())
            .thenThrow(Exception('Language error'));

        // Act
        bloc.add(LoadCompleteSettingsData());

        // Assert
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<SettingsLoading>(),
            isA<SettingsError>().having(
              (state) => state.message,
              'message',
              'Exception: Language error',
            ),
          ]),
        );
      });
    });

    group('LoadLanguagePreference', () {
      test('should emit [LanguageLoaded] when successful', () async {
        // Arrange
        when(mockGetLanguagePreference()).thenAnswer((_) async => 'es');

        // Act
        bloc.add(LoadLanguagePreference());

        // Assert
        await expectLater(
          bloc.stream,
          emits(isA<LanguageLoaded>().having(
            (state) => state.currentLanguage,
            'currentLanguage',
            'es',
          )),
        );
      });

      test('should emit [SettingsError] when getLanguagePreference fails',
          () async {
        // Arrange
        when(mockGetLanguagePreference())
            .thenThrow(Exception('Language error'));

        // Act
        bloc.add(LoadLanguagePreference());

        // Assert
        await expectLater(
          bloc.stream,
          emits(isA<SettingsError>().having(
            (state) => state.message,
            'message',
            'Exception: Language error',
          )),
        );
      });
    });

    group('SetLanguage', () {
      test('should emit [LanguageChanged] when successful', () async {
        // Arrange
        when(mockSetLanguagePreference('pt')).thenAnswer((_) async => true);

        // Act
        bloc.add(SetLanguage('pt'));

        // Assert
        await expectLater(
          bloc.stream,
          emits(isA<LanguageChanged>().having(
            (state) => state.newLanguage,
            'newLanguage',
            'pt',
          )),
        );
      });

      test('should emit [SettingsError] when setLanguagePreference fails',
          () async {
        // Arrange
        when(mockSetLanguagePreference('invalid'))
            .thenThrow(Exception('Save error'));

        // Act
        bloc.add(SetLanguage('invalid'));

        // Assert
        await expectLater(
          bloc.stream,
          emits(isA<SettingsError>().having(
            (state) => state.message,
            'message',
            'Exception: Save error',
          )),
        );
      });
    });

    group('ToggleDarkMode', () {
      test('should emit [DarkModeToggled] when successful', () async {
        // Arrange
        when(mockToggleDarkModeUseCase()).thenAnswer((_) async => false);

        // Act
        bloc.add(ToggleDarkMode());

        // Assert
        await expectLater(
          bloc.stream,
          emits(isA<DarkModeToggled>().having(
            (state) => state.isDarkMode,
            'isDarkMode',
            false,
          )),
        );
      });

      test('should emit [SettingsError] when toggleDarkModeUseCase fails',
          () async {
        // Arrange
        when(mockToggleDarkModeUseCase()).thenThrow(Exception('Toggle error'));

        // Act
        bloc.add(ToggleDarkMode());

        // Assert
        await expectLater(
          bloc.stream,
          emits(isA<SettingsError>().having(
            (state) => state.message,
            'message',
            'Exception: Toggle error',
          )),
        );
      });
    });
  });
}
