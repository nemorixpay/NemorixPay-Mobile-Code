import 'package:nemorixpay/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:nemorixpay/features/kyc/domain/entities/kyc_session.dart';

/// @file        get_kyc_status.dart
/// @brief       Use case for getting KYC verification status
/// @details     Handles the business logic for retrieving current KYC status
/// @author      Miguel Fagundez
/// @date        08/05/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetKYCStatus {
  final KYCRepository _repository;

  GetKYCStatus(this._repository);

  Future<KYCStatus> call() async {
    return await _repository.getVerificationStatus();
  }
}
