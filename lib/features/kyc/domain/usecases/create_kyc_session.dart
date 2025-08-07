import 'package:nemorixpay/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:nemorixpay/features/kyc/domain/entities/kyc_session.dart';

/// @file        create_kyc_session.dart
/// @brief       Use case for creating KYC verification sessions
/// @details     Handles the business logic for creating new KYC sessions
///              and managing existing active sessions
/// @author      Miguel Fagundez
/// @date        08/05/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CreateKYCSession {
  final KYCRepository _repository;

  CreateKYCSession(this._repository);

  Future<KYCSession> call() async {
    return await _repository.createVerificationSession();
  }
}
