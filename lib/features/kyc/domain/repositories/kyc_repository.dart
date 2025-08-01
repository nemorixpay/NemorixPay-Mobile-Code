import 'package:dartz/dartz.dart';
import '../entities/kyc_session.dart';

/// @file        kyc_repository.dart
/// @brief       Abstract repository for KYC operations
/// @details     Defines the contract for KYC business logic operations
///              including session management and status verification
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class KYCRepository {
  /// Create a new KYC verification session
  Future<Either<String, KYCSession>> createVerificationSession();

  /// Get the current KYC session
  Future<Either<String, KYCSession?>> getCurrentSession();

  /// Save KYC session
  Future<Either<String, void>> saveSession(KYCSession session);

  /// Clear KYC session
  Future<Either<String, void>> clearSession();

  /// Get KYC verification status
  Future<Either<String, KYCStatus>> getVerificationStatus();

  /// Check if user has active session
  Future<Either<String, bool>> hasActiveSession();
}
