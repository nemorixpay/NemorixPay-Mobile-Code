import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/onboarding/onboarding_failure.dart';
import '../repositories/onboarding_repository.dart';

/// @file        get_language_usecase.dart
/// @brief       Use case for getting the saved language.
/// @details     Retrieves the language preference from the repository.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetLanguageUsecase {
  final OnboardingRepository repository;

  GetLanguageUsecase(this.repository);

  /// @brief       Executes the use case.
  /// @details     Gets the saved language from the repository.
  /// @return      Either an OnboardingFailure or the saved language (null if no language is saved).
  Future<Either<OnboardingFailure, String?>> call() async {
    return await repository.getLanguage();
  }
}
