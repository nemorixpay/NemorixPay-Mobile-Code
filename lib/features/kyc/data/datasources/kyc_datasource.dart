import '../../domain/entities/kyc_session.dart';
import '../models/didit_session_model.dart';
import '../models/didit_create_session_request.dart';

/// @file        kyc_datasource.dart
/// @brief       Abstract datasource for KYC operations
/// @details     Defines the contract for KYC data operations including
///              session creation, status retrieval and local storage
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class KYCDatasource {
  /// Create a new KYC verification session with Didit
  Future<DiditSessionModel> createSession(
    DiditCreateSessionRequest request,
  );

  /// Get the current KYC session from local storage
  Future<KYCSession?> getCurrentSession();

  /// Save KYC session to local storage
  Future<void> saveSession(KYCSession session);

  /// Clear KYC session from local storage
  Future<void> clearSession();

  /// Get KYC verification status
  Future<KYCStatus> getVerificationStatus();
}
