import '../repositories/terms_repository.dart';

/// @file        get_terms_content.dart
/// @brief       Use case for retrieving Terms and Conditions content.
/// @details     Calls the repository to get the terms and conditions text.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class GetTermsContent {
  final TermsRepository repository;

  GetTermsContent(this.repository);

  Future<String> call() async {
    return await repository.getTermsContent();
  }
}
