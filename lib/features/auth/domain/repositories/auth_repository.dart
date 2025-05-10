import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/auth/domain/entities/user_entity.dart';

/// @file        auth_repository.dart
/// @brief       Authentication repository interface for NemorixPay auth feature.
/// @details     This interface defines the contract for authentication operations
///              at the domain layer, abstracting the data source implementation.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class AuthRepository {
  /// Signs in a user with email and password
  ///
  /// Returns [UserEntity] if sign in is successful
  /// Throws [Failure] if there is an error
  Future<Either<Failure, UserEntity>> signIn(String email, String password);

  /// Registers a new user with email and password
  ///
  /// Returns [UserEntity] if registration is successful
  /// Throws [Failure] if there is an error
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String securityWord,
  });
}
