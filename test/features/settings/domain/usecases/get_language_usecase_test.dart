import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/settings/domain/repositories/settings_repository.dart';
import 'package:nemorixpay/features/settings/domain/usecases/get_language_usecase.dart';

/// @file        get_language_usecase_test.dart
/// @brief       Unit tests for GetLanguageUseCase.
/// @details     Tests the use case for retrieving language preference from settings.
/// @author      Miguel Fagundez
/// @date        07/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

// Generate mocks
@GenerateMocks([SettingsRepository])
import 'get_language_usecase_test.mocks.dart';

void main() {
  group('GetLanguageUseCase', () {
    late GetLanguageUseCase useCase;
    late MockSettingsRepository mockRepository;

    setUp(() {
      mockRepository = MockSettingsRepository();
      useCase = GetLanguageUseCase(mockRepository);
    });

    group('call', () {
      test('should return language preference when successful', () async {
        // Arrange
        const expectedLanguage = 'es';
        when(mockRepository.getLanguagePreference())
            .thenAnswer((_) async => expectedLanguage);

        // Act
        final result = await useCase();

        // Assert
        expect(result, expectedLanguage);
        verify(mockRepository.getLanguagePreference()).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should return default language when no preference is set',
          () async {
        // Arrange
        const expectedLanguage = 'en';
        when(mockRepository.getLanguagePreference())
            .thenAnswer((_) async => expectedLanguage);

        // Act
        final result = await useCase();

        // Assert
        expect(result, expectedLanguage);
        verify(mockRepository.getLanguagePreference()).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should throw exception when repository fails', () async {
        // Arrange
        when(mockRepository.getLanguagePreference())
            .thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => useCase(),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.getLanguagePreference()).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should handle different language codes', () async {
        // Arrange
        const testCases = ['en', 'es', 'pt', 'fr', 'de'];

        for (final language in testCases) {
          when(mockRepository.getLanguagePreference())
              .thenAnswer((_) async => language);

          // Act
          final result = await useCase();

          // Assert
          expect(result, language);
          verify(mockRepository.getLanguagePreference()).called(1);
          verifyNoMoreInteractions(mockRepository);

          // Reset for next iteration
          reset(mockRepository);
        }
      });
    });
  });
}
