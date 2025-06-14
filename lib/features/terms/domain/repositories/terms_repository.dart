/// @file        terms_repository.dart
/// @brief       Repository interface for Terms and Conditions feature.
/// @details     Defines contract for retrieving and accepting terms and conditions.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class TermsRepository {
  Future<String> getTermsContent();
  Future<void> acceptTerms(String version, DateTime acceptedAt);
}
