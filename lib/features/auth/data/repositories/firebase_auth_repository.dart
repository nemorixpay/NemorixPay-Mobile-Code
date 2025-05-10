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
/// @date        2024-05-08
/// @version     1.1
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
      debugPrint('FirebaseAuthRepository - Begin sign in process');

      final UserModel user = await firebaseAuthDataSource.signIn(
        email: email,
        password: password,
      );

      debugPrint('FirebaseAuthRepository - User authenticated successfully');
      return Right(user.toUserEntity());
    } on FirebaseFailure catch (failure) {
      debugPrint(
        'FirebaseAuthRepository - Firebase error: ${failure.firebaseCode}',
      );
      return Left(failure);
    } catch (e) {
      debugPrint('FirebaseAuthRepository - Unexpected error: $e');
      return Left(
        FirebaseFailure(
          firebaseMessage: e.toString(),
          firebaseCode: e.runtimeType.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String securityWord,
  }) async {
    try {
      debugPrint('FirebaseAuthRepository - Begin sign up process');

      final UserModel user = await firebaseAuthDataSource.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        securityWord: securityWord,
      );

      debugPrint('FirebaseAuthRepository - User registered successfully');
      return Right(user.toUserEntity());
    } on FirebaseFailure catch (failure) {
      debugPrint(
        'FirebaseAuthRepository - Firebase error: ${failure.firebaseCode}',
      );
      return Left(failure);
    } catch (e) {
      debugPrint('FirebaseAuthRepository - Unexpected error: $e');
      return Left(
        FirebaseFailure(
          firebaseMessage: e.toString(),
          firebaseCode: e.runtimeType.toString(),
        ),
      );
    }
  }
}
