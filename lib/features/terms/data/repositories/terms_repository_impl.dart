import '../../domain/repositories/terms_repository.dart';
import '../datasources/terms_local_datasource.dart';

/// @file        terms_repository_impl.dart
/// @brief       Implementation of TermsRepository for Terms and Conditions.
/// @details     Handles the retrieval and acceptance of terms using a local datasource.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class TermsRepositoryImpl implements TermsRepository {
  final TermsLocalDatasource localDatasource;

  TermsRepositoryImpl(this.localDatasource);

  @override
  Future<String> getTermsContent() async {
    return await localDatasource.getTermsContent();
  }

  @override
  Future<void> acceptTerms(String version, DateTime acceptedAt) async {
    // TODO: Save acceptance locally (e.g., SharedPreferences)
    // For now, just a placeholder
    return;
  }
}
