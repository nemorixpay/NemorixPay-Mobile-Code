import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/onboarding/onboarding_failure.dart';
import 'package:nemorixpay/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'mocks/mock_onboarding_local_datasource.dart';

void main() {
  late OnboardingRepositoryImpl repository;
  late MockOnboardingLocalDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockOnboardingLocalDatasource();
    repository = OnboardingRepositoryImpl(mockDatasource);
  });

  group('saveLanguage', () {
    const tLanguage = 'en';

    test('should return true when language is saved successfully', () async {
      // act
      final result = await repository.saveLanguage(tLanguage);

      // assert
      expect(result, const Right(true));
    });

    test('should return OnboardingFailure when saving fails', () async {
      // arrange
      mockDatasource.setShouldThrow(true, message: 'Failed to save');

      // act
      final result = await repository.saveLanguage(tLanguage);

      // assert
      expect(result, isA<Left<OnboardingFailure, bool>>());
    });
  });

  group('getLanguage', () {
    test('should return language when it exists', () async {
      // arrange
      const tLanguage = 'es';
      await mockDatasource.saveLanguage(tLanguage);

      // act
      final result = await repository.getLanguage();

      // assert
      expect(result, const Right(tLanguage));
    });

    test('should return null when language does not exist', () async {
      // act
      final result = await repository.getLanguage();

      // assert
      expect(result, const Right(null));
    });

    test('should return OnboardingFailure when getting language fails',
        () async {
      // arrange
      mockDatasource.setShouldThrow(true, message: 'Failed to get');

      // act
      final result = await repository.getLanguage();

      // assert
      expect(result, isA<Left<OnboardingFailure, String?>>());
    });
  });

  group('completeOnboarding', () {
    test('should return true when onboarding is completed successfully',
        () async {
      // act
      final result = await repository.completeOnboarding();

      // assert
      expect(result, const Right(true));
    });

    test('should return OnboardingFailure when completing onboarding fails',
        () async {
      // arrange
      mockDatasource.setShouldThrow(true, message: 'Failed to complete');

      // act
      final result = await repository.completeOnboarding();

      // assert
      expect(result, isA<Left<OnboardingFailure, bool>>());
    });
  });

  group('isOnboardingCompleted', () {
    test('should return true when onboarding is completed', () async {
      // arrange
      await mockDatasource.completeOnboarding();

      // act
      final result = await repository.isOnboardingCompleted();

      // assert
      expect(result, const Right(true));
    });

    test('should return false when onboarding is not completed', () async {
      // act
      final result = await repository.isOnboardingCompleted();

      // assert
      expect(result, const Right(false));
    });

    test('should return OnboardingFailure when checking status fails',
        () async {
      // arrange
      mockDatasource.setShouldThrow(true, message: 'Failed to check');

      // act
      final result = await repository.isOnboardingCompleted();

      // assert
      expect(result, isA<Left<OnboardingFailure, bool>>());
    });
  });
}
