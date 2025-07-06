import 'package:dartz/dartz.dart';
import 'package:nemorixpay/features/terms/data/datasources/terms_local_datasource_impl.dart';

/// @file        save_terms_acceptance_usecase.dart
/// @brief       Use case to save user's acceptance of terms and conditions.
/// @details     Stores the user's acceptance of terms and conditions in local storage
///              with version tracking and timestamp.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class SaveTermsAcceptanceUseCase {
  final TermsLocalDatasourceImpl _localDatasource;

  SaveTermsAcceptanceUseCase(this._localDatasource);

  /// Saves the user's acceptance of terms and conditions
  /// [version] - The version of terms being accepted
  /// [acceptedAt] - The date and time when terms were accepted
  /// Returns void on success, throws Exception on failure
  Future<void> call({
    String? version,
    DateTime? acceptedAt,
  }) async {
    try {
      final currentVersion = version ?? _localDatasource.currentTermsVersion;
      final acceptanceTime = acceptedAt ?? DateTime.now();

      await _localDatasource.saveTermsAcceptance(
          currentVersion, acceptanceTime);
    } catch (e) {
      throw Exception('Failed to save terms acceptance: $e');
    }
  }

  /// Clears all terms acceptance data (useful for testing)
  /// Returns void on success, throws Exception on failure
  Future<void> clearAcceptance() async {
    try {
      await _localDatasource.clearTermsAcceptance();
    } catch (e) {
      throw Exception('Failed to clear terms acceptance: $e');
    }
  }
}
