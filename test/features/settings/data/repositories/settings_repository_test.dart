import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:nemorixpay/features/settings/data/repositories/settings_repository_impl.dart';

/// @file        settings_repository_test.dart
/// @brief       Unit tests for SettingsRepositoryImpl.
/// @details     Tests the repository layer for settings management including language preferences.
/// @author      Miguel Fagundez
/// @date        07/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

// Generate mocks
@GenerateMocks([SettingsLocalDatasource])
import 'settings_repository_test.mocks.dart';

void main() {
  group('SettingsRepositoryImpl - Language', () {
    late SettingsRepositoryImpl repository;
    late MockSettingsLocalDatasource mockLocalDatasource;

    setUp(() {
      mockLocalDatasource = MockSettingsLocalDatasource();
      repository = SettingsRepositoryImpl(mockLocalDatasource);
    });

    group('getLanguagePreference', () {
      test('should return language preference from local datasource', () async {
        // Arrange
        const expectedLanguage = 'es';
        when(mockLocalDatasource.getLanguagePreference())
            .thenAnswer((_) async => expectedLanguage);

        // Act
        final result = await repository.getLanguagePreference();

        // Assert
        expect(result, expectedLanguage);
        verify(mockLocalDatasource.getLanguagePreference()).called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should return default language when no preference is set',
          () async {
        // Arrange
        const expectedLanguage = 'en';
        when(mockLocalDatasource.getLanguagePreference())
            .thenAnswer((_) async => expectedLanguage);

        // Act
        final result = await repository.getLanguagePreference();

        // Assert
        expect(result, expectedLanguage);
        verify(mockLocalDatasource.getLanguagePreference()).called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should propagate exception from local datasource', () async {
        // Arrange
        when(mockLocalDatasource.getLanguagePreference())
            .thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => repository.getLanguagePreference(),
          throwsA(isA<Exception>()),
        );
        verify(mockLocalDatasource.getLanguagePreference()).called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should handle different language codes', () async {
        // Arrange
        const testCases = ['en', 'es', 'pt', 'fr', 'de'];

        for (final language in testCases) {
          when(mockLocalDatasource.getLanguagePreference())
              .thenAnswer((_) async => language);

          // Act
          final result = await repository.getLanguagePreference();

          // Assert
          expect(result, language);
          verify(mockLocalDatasource.getLanguagePreference()).called(1);
          verifyNoMoreInteractions(mockLocalDatasource);

          // Reset for next iteration
          reset(mockLocalDatasource);
        }
      });
    });

    group('saveLanguagePreference', () {
      test('should save language preference through local datasource',
          () async {
        // Arrange
        const languageCode = 'es';
        when(mockLocalDatasource.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);

        // Act
        await repository.saveLanguagePreference(languageCode);

        // Assert
        verify(mockLocalDatasource.saveLanguagePreference(languageCode))
            .called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should save English language preference', () async {
        // Arrange
        const languageCode = 'en';
        when(mockLocalDatasource.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);

        // Act
        await repository.saveLanguagePreference(languageCode);

        // Assert
        verify(mockLocalDatasource.saveLanguagePreference(languageCode))
            .called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should save Portuguese language preference', () async {
        // Arrange
        const languageCode = 'pt';
        when(mockLocalDatasource.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);

        // Act
        await repository.saveLanguagePreference(languageCode);

        // Assert
        verify(mockLocalDatasource.saveLanguagePreference(languageCode))
            .called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should propagate exception from local datasource', () async {
        // Arrange
        const languageCode = 'invalid';
        when(mockLocalDatasource.saveLanguagePreference(languageCode))
            .thenThrow(Exception('Save error'));

        // Act & Assert
        expect(
          () => repository.saveLanguagePreference(languageCode),
          throwsA(isA<Exception>()),
        );
        verify(mockLocalDatasource.saveLanguagePreference(languageCode))
            .called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should handle empty language code', () async {
        // Arrange
        const languageCode = '';
        when(mockLocalDatasource.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);

        // Act
        await repository.saveLanguagePreference(languageCode);

        // Assert
        verify(mockLocalDatasource.saveLanguagePreference(languageCode))
            .called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should handle different language codes', () async {
        // Arrange
        const testCases = ['en', 'es', 'pt', 'fr', 'de'];

        for (final language in testCases) {
          when(mockLocalDatasource.saveLanguagePreference(language))
              .thenAnswer((_) async => true);

          // Act
          await repository.saveLanguagePreference(language);

          // Assert
          verify(mockLocalDatasource.saveLanguagePreference(language))
              .called(1);
          verifyNoMoreInteractions(mockLocalDatasource);

          // Reset for next iteration
          reset(mockLocalDatasource);
        }
      });
    });

    group('Language preference workflow', () {
      test('should save and retrieve language preference correctly', () async {
        // Arrange
        const languageCode = 'es';
        when(mockLocalDatasource.saveLanguagePreference(languageCode))
            .thenAnswer((_) async => true);
        when(mockLocalDatasource.getLanguagePreference())
            .thenAnswer((_) async => languageCode);

        // Act - Save
        await repository.saveLanguagePreference(languageCode);

        // Act - Retrieve
        final result = await repository.getLanguagePreference();

        // Assert
        expect(result, languageCode);
        verify(mockLocalDatasource.saveLanguagePreference(languageCode))
            .called(1);
        verify(mockLocalDatasource.getLanguagePreference()).called(1);
        verifyNoMoreInteractions(mockLocalDatasource);
      });

      test('should handle multiple language changes', () async {
        // Arrange
        const languages = ['en', 'es', 'pt'];

        for (int i = 0; i < languages.length; i++) {
          final language = languages[i];
          when(mockLocalDatasource.saveLanguagePreference(language))
              .thenAnswer((_) async => true);
          when(mockLocalDatasource.getLanguagePreference())
              .thenAnswer((_) async => language);

          // Act - Save
          await repository.saveLanguagePreference(language);

          // Act - Retrieve
          final result = await repository.getLanguagePreference();

          // Assert
          expect(result, language);
          verify(mockLocalDatasource.saveLanguagePreference(language))
              .called(1);
          verify(mockLocalDatasource.getLanguagePreference()).called(1);
          verifyNoMoreInteractions(mockLocalDatasource);

          // Reset for next iteration
          reset(mockLocalDatasource);
        }
      });
    });
  });
}
