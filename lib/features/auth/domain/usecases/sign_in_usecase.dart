import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/auth/domain/entities/user_entity.dart';
import 'package:nemorixpay/features/auth/domain/repositories/auth_repository.dart';

/// @file        sign_in_usecase.dart
/// @brief       Sign in use case for NemorixPay auth feature.
/// @details     This use case handles the user sign in process.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
/// @copyright   Apache 2.0 License
class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    debugPrint('SignInUseCase');
    return await authRepository.signIn(email, password);
  }
}
