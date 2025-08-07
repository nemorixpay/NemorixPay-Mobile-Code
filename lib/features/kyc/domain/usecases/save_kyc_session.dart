import 'package:nemorixpay/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:nemorixpay/features/kyc/domain/entities/kyc_session.dart';

/// @file        save_kyc_session.dart
/// @brief       Use case for saving KYC sessions
/// @details     Handles the business logic for persisting KYC sessions locally
/// @author      Miguel Fagundez
/// @date        08/05/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class SaveKYCSession {
  final KYCRepository _repository;

  SaveKYCSession(this._repository);

  Future<void> call(KYCSession session) async {
    return await _repository.saveSession(session);
  }
}
