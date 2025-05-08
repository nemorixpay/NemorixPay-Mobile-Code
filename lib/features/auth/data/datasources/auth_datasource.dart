import 'package:nemorixpay/features/auth/data/models/user_model.dart';

/// @file        auth_datasource.dart
/// @brief       Authentication data source interface for NemorixPay auth feature.
/// @details     This interface defines the contract for authentication operations using, for example, Firebase Auth.
///              It provides methods for user registration, sign in/out, password recovery, and email verification.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class AuthDataSource {
  /// Signs in a user with email and password
  ///
  /// Returns [UserModel] from NemorixPay model if sign in is successful
  /// Throws [Failure] if there is an error
  Future<UserModel> signIn({required String email, required String password});
}
