import '../repositories/terms_repository.dart';

/// @file        accept_terms.dart
/// @brief       Use case for accepting Terms and Conditions.
/// @details     Calls the repository to save the acceptance of the terms.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class AcceptTerms {
  final TermsRepository repository;

  AcceptTerms(this.repository);

  Future<void> call(String version, DateTime acceptedAt) async {
    await repository.acceptTerms(version, acceptedAt);
  }
}
