import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/firebase_failure.dart';
import 'package:nemorixpay/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:nemorixpay/features/auth/data/models/user_model.dart';
import 'package:nemorixpay/features/auth/domain/entities/user_entity.dart';
import 'package:nemorixpay/features/auth/domain/repositories/auth_repository.dart';

/// @file        firebase_auth_repository.dart
/// @brief       Authentication repository implementation for NemorixPay auth feature.
/// @details     This class implements the AuthRepository interface using Firebase Auth.
///              It handles the conversion between Firebase User and UserEntity.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
/// @copyright   Apache 2.0 License
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;

  FirebaseAuthRepository({required this.firebaseAuthDataSource});

  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      debugPrint('FirebaseAuthRepository');
      final UserModel user = await firebaseAuthDataSource.signIn(
        email: email,
        password: password,
      );
      debugPrint('FirebaseAuthRepository - return User');
      return Right(user.toUserEntity());
    } catch (e) {
      debugPrint('FirebaseAuthRepository - return FirebaseFailure');
      return Left(
        FirebaseFailure(
          firebaseMessage:
              'Ha ocurrido un error inesperado. Por favor, intenta nuevamente.',
          firebaseCode: 'Unknown',
        ),
      );
    }
  }
}
