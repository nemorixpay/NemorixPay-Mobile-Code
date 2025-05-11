import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// @file        send_verification_email_usecase.dart
/// @brief       Use case for sending email verification in NemorixPay auth feature.
/// @details     This use case handles the business logic for sending verification emails
///              to newly registered users.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.0
/// @copyright   Apache 2.0 License
class SendVerificationEmailUseCase {
  final AuthRepository authRepository;

  SendVerificationEmailUseCase({required this.authRepository});

  Future<Either<Failure, bool>> call() async {
    return await authRepository.sendVerificationEmail();
  }
}
