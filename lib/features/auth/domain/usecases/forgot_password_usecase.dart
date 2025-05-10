import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/auth/domain/repositories/auth_repository.dart';

/// @file        forgot_password_usecase.dart
/// @brief       Forgot password use case for NemorixPay auth feature.
/// @details     This use case handles the password recovery process.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.0
/// @copyright   Apache 2.0 License
class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Either<Failure, bool>> call(String email) async {
    debugPrint('ForgotPasswordUseCase');
    return await _repository.forgotPassword(email);
  }
}
