import '../../domain/repositories/terms_repository.dart';
import '../datasources/terms_local_datasource.dart';

/// @file        terms_repository_impl.dart
/// @brief       Implementation of TermsRepository using local datasource.
/// @details     Provides access to terms content and manages acceptance using SharedPreferences.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TermsRepositoryImpl implements TermsRepository {
  final TermsLocalDatasource _localDatasource;

  TermsRepositoryImpl(this._localDatasource);

  @override
  Future<String> getTermsContent() async {
    return await _localDatasource.getTermsContent();
  }

  @override
  Future<void> acceptTerms(String version, DateTime acceptedAt) async {
    await _localDatasource.saveTermsAcceptance(version, acceptedAt);
  }
}
