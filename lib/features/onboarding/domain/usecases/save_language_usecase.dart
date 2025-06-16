import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/onboarding/onboarding_failure.dart';
import '../repositories/onboarding_repository.dart';

/// @file        save_language_usecase.dart
/// @brief       Use case for saving the selected language.
/// @details     Handles the business logic for persisting the user's language preference.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class SaveLanguageUsecase {
  final OnboardingRepository repository;

  SaveLanguageUsecase(this.repository);

  Future<Either<OnboardingFailure, bool>> call(String language) async {
    return await repository.saveLanguage(language);
  }
}
