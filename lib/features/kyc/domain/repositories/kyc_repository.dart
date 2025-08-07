import '../../domain/entities/kyc_session.dart';

/// @file        kyc_repository.dart
/// @brief       Repository interface for KYC feature
/// @details     Defines contract for KYC verification operations
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class KYCRepository {
  /// Create a new KYC verification session
  Future<KYCSession> createVerificationSession();

  /// Get the current KYC session from local storage
  Future<KYCSession?> getCurrentSession();

  /// Save KYC session to local storage
  Future<void> saveSession(KYCSession session);

  /// Clear KYC session from local storage
  Future<void> clearSession();

  /// Get KYC verification status
  Future<KYCStatus> getVerificationStatus();

  /// Check if user has an active KYC session
  Future<bool> hasActiveSession();
}
