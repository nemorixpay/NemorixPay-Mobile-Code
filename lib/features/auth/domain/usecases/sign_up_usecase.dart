import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/auth/domain/entities/user_entity.dart';
import 'package:nemorixpay/features/auth/domain/repositories/auth_repository.dart';

/// @file        sign_up_usecase.dart
/// @brief       Sign up use case for NemorixPay auth feature.
/// @details     This use case handles the user registration process.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.0
/// @copyright   Apache 2.0 License
class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String securityWord,
  }) async {
    debugPrint('SignUpUseCase');
    return await authRepository.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      securityWord: securityWord,
    );
  }
}
