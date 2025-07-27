import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/settings/domain/repositories/settings_repository.dart';
import 'package:nemorixpay/features/settings/domain/usecases/set_language_usecase.dart';

/// @file        set_language_usecase_test.dart
/// @brief       Unit tests for SetLanguageUseCase.
/// @details     Tests the use case for saving language preference to settings.
/// @author      Miguel Fagundez
/// @date        07/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

// Generate mocks
@GenerateMocks([SettingsRepository])
import 'set_language_usecase_test.mocks.dart';

void main() {
  group('SetLanguageUseCase', () {
    late SetLanguageUseCase useCase;
    late MockSettingsRepository mockRepository;

    setUp(() {
      mockRepository = MockSettingsRepository();
      useCase = SetLanguageUseCase(mockRepository);
    });

    group('call', () {
      test('should save language preference successfully', () async {
        // Arrange
        const languageCode = 'es';
        when(mockRepository.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);

        // Act
        await useCase(languageCode);

        // Assert
        verify(mockRepository.saveLanguagePreference(languageCode)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should save English language preference', () async {
        // Arrange
        const languageCode = 'en';
        when(mockRepository.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);

        // Act
        await useCase(languageCode);

        // Assert
        verify(mockRepository.saveLanguagePreference(languageCode)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should save Portuguese language preference', () async {
        // Arrange
        const languageCode = 'pt';
        when(mockRepository.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);

        // Act
        await useCase(languageCode);

        // Assert
        verify(mockRepository.saveLanguagePreference(languageCode)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should throw exception when repository fails', () async {
        // Arrange
        const languageCode = 'invalid';
        when(mockRepository.saveLanguagePreference(languageCode))
            .thenThrow(Exception('Save error'));

        // Act & Assert
        expect(
          () => useCase(languageCode),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.saveLanguagePreference(languageCode)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should handle empty language code', () async {
        // Arrange
        const languageCode = '';
        when(mockRepository.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);

        // Act
        await useCase(languageCode);

        // Assert
        verify(mockRepository.saveLanguagePreference(languageCode)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should handle different language codes', () async {
        // Arrange
        const testCases = ['en', 'es', 'pt', 'fr', 'de'];

        for (final language in testCases) {
          when(mockRepository.saveLanguagePreference(language))
              .thenAnswer((_) async => true);

          // Act
          await useCase(language);

          // Assert
          verify(mockRepository.saveLanguagePreference(language)).called(1);
          verifyNoMoreInteractions(mockRepository);

          // Reset for next iteration
          reset(mockRepository);
        }
      });
    });
  });
}
