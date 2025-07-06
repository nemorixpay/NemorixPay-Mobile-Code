import 'package:dartz/dartz.dart';
import '../../data/datasources/terms_local_datasource.dart';
import '../../data/models/terms_acceptance_model.dart';

/// @file        check_terms_acceptance_usecase.dart
/// @brief       Use case to check if user has accepted terms and conditions.
/// @details     Verifies if the user has accepted the current version of terms
///              and conditions by checking local storage.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CheckTermsAcceptanceUseCase {
  final TermsLocalDatasource _localDatasource;

  CheckTermsAcceptanceUseCase(this._localDatasource);

  /// Checks if the user has accepted the current version of terms and conditions
  /// Returns true if accepted, false otherwise
  Future<bool> call() async {
    try {
      return await _localDatasource.isTermsAccepted();
    } catch (e) {
      // If there's an error, assume terms are not accepted
      return false;
    }
  }

  /// Gets the complete terms acceptance information
  /// Returns the TermsAcceptanceModel with all details
  Future<TermsAcceptanceModel> getTermsAcceptanceDetails() async {
    try {
      return await _localDatasource.getTermsAcceptance();
    } catch (e) {
      return TermsAcceptanceModel.notAccepted();
    }
  }
}
