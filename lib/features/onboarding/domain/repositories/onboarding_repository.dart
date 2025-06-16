import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/onboarding/onboarding_failure.dart';

/// @file        onboarding_repository.dart
/// @brief       Repository interface for Onboarding feature.
/// @details     Defines the contract for onboarding data operations.
/// @author      Miguel Fagundez
/// @date        06/16/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class OnboardingRepository {
  /// @brief       Saves the selected language.
  /// @details     Persists the user's language preference.
  /// @param       language The language code to save.
  /// @return      Either an OnboardingFailure or true if successful.
  Future<Either<OnboardingFailure, bool>> saveLanguage(String language);

  /// @brief       Gets the saved language.
  /// @details     Retrieves the user's language preference.
  /// @return      Either an OnboardingFailure or the saved language (null if no language is saved).
  Future<Either<OnboardingFailure, String?>> getLanguage();

  /// @brief       Marks onboarding as completed.
  /// @details     Persists the onboarding completion status.
  /// @return      Either an OnboardingFailure or true if successful.
  Future<Either<OnboardingFailure, bool>> completeOnboarding();

  /// @brief       Checks if onboarding is completed.
  /// @details     Verifies if the user has already completed the onboarding process.
  /// @return      Either an OnboardingFailure or true if onboarding is completed.
  Future<Either<OnboardingFailure, bool>> isOnboardingCompleted();
}
