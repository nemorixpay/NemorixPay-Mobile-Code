import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/onboarding/onboarding_failure.dart';
import 'package:nemorixpay/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:nemorixpay/features/onboarding/domain/repositories/onboarding_repository.dart';

/// @file        onboarding_repository_impl.dart
/// @brief       Implementation of the OnboardingRepository interface.
/// @details     Handles the business logic for onboarding operations.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDatasource _localDatasource;

  OnboardingRepositoryImpl(this._localDatasource);

  /// @brief       Saves the selected language.
  /// @details     Persists the user's language preference to local storage.
  /// @param       language The language code to save.
  /// @return      Either an OnboardingFailure or true if successful.
  /// @throws      OnboardingFailure if the operation fails.
  @override
  Future<Either<OnboardingFailure, bool>> saveLanguage(String language) async {
    try {
      final result = await _localDatasource.saveLanguage(language);
      return Right(result);
    } catch (e) {
      if (e is OnboardingFailure) return Left(e);
      return Left(OnboardingFailure.unknown(e.toString()));
    }
  }

  /// @brief       Gets the saved language.
  /// @details     Retrieves the user's language preference from local storage.
  /// @return      Either an OnboardingFailure or the saved language (null if no language is saved).
  /// @throws      OnboardingFailure if the operation fails.
  @override
  Future<Either<OnboardingFailure, String?>> getLanguage() async {
    try {
      final language = await _localDatasource.getLanguage();
      return Right(language);
    } catch (e) {
      if (e is OnboardingFailure) return Left(e);
      return Left(OnboardingFailure.unknown(e.toString()));
    }
  }

  /// @brief       Marks onboarding as completed.
  /// @details     Persists the onboarding completion status to local storage.
  /// @return      Either an OnboardingFailure or true if successful.
  /// @throws      OnboardingFailure if the operation fails.
  @override
  Future<Either<OnboardingFailure, bool>> completeOnboarding() async {
    try {
      final result = await _localDatasource.completeOnboarding();
      return Right(result);
    } catch (e) {
      if (e is OnboardingFailure) return Left(e);
      return Left(OnboardingFailure.unknown(e.toString()));
    }
  }

  /// @brief       Checks if onboarding is completed.
  /// @details     Verifies if the user has already completed the onboarding process.
  /// @return      Either an OnboardingFailure or true if onboarding is completed.
  /// @throws      OnboardingFailure if the operation fails.
  @override
  Future<Either<OnboardingFailure, bool>> isOnboardingCompleted() async {
    try {
      final result = await _localDatasource.isOnboardingCompleted();
      return Right(result);
    } catch (e) {
      if (e is OnboardingFailure) return Left(e);
      return Left(OnboardingFailure.unknown(e.toString()));
    }
  }
}
