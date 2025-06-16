import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/onboarding/onboarding_failure.dart';
import '../repositories/onboarding_repository.dart';

/// @file        complete_onboarding_usecase.dart
/// @brief       Use case for completing the onboarding process.
/// @details     Handles the business logic for marking onboarding as completed.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CompleteOnboardingUsecase {
  final OnboardingRepository repository;

  CompleteOnboardingUsecase(this.repository);

  /// @brief       Executes the use case.
  /// @details     Marks the onboarding process as completed.
  /// @return      Either an OnboardingFailure or true if successful.
  Future<Either<OnboardingFailure, bool>> call() async {
    return await repository.completeOnboarding();
  }
}
