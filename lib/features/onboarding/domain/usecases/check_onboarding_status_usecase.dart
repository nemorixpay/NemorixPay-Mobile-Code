import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/onboarding/onboarding_failure.dart';

import '../repositories/onboarding_repository.dart';

/// @file        check_onboarding_status_usecase.dart
/// @brief       Use case for checking onboarding status.
/// @details     Verifies if the user has already completed the onboarding process.
/// @author      Miguel Fagundez
/// @date        06/16/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CheckOnboardingStatusUsecase {
  final OnboardingRepository repository;

  CheckOnboardingStatusUsecase(this.repository);

  /// @brief       Executes the use case.
  /// @details     Checks if the onboarding process has been completed.
  /// @return      True if onboarding is completed, false otherwise.
  Future<Either<OnboardingFailure, bool>> call() async {
    return await repository.isOnboardingCompleted();
  }
}
