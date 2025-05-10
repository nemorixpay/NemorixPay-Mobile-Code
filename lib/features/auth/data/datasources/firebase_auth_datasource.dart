import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nemorixpay/core/errors/firebase_error_codes.dart';
import 'package:nemorixpay/core/errors/firebase_failure.dart';
import 'package:nemorixpay/features/auth/data/datasources/auth_datasource.dart';
import 'package:nemorixpay/features/auth/data/models/user_model.dart';

/// @file        firebase_auth_datasource.dart
/// @brief       Firebase Authentication implementation for NemorixPay auth feature.
/// @details     This class implements the AuthDataSource interface using Firebase Authentication.
///              It handles all authentication operations including sign in, sign up, and email verification.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.1
/// @copyright   Apache 2.0 License
class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('FirebaseAuthDataSource - Begin sign in process');
      debugPrint('Email: $email');

      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('FirebaseAuthDataSource - Authentication response received');

      if (credentials.user?.uid == null) {
        debugPrint(
          'FirebaseAuthDataSource - Authentication failed: No user ID',
        );
        throw FirebaseFailure(
          firebaseMessage: 'Authentication failed: No user ID',
          firebaseCode: FirebaseErrorCode.unknown.code,
        );
      }

      debugPrint('FirebaseAuthDataSource - User authenticated successfully');

      return UserModel(
        id: credentials.user!.uid,
        email: email,
        isEmailVerified: credentials.user!.emailVerified,
        createdAt: DateTime.now(),
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('FirebaseAuthDataSource - Firebase Auth Error: ${error.code}');
      throw FirebaseFailure(
        firebaseMessage: error.message ?? 'Authentication failed',
        firebaseCode: error.code,
      );
    } catch (error) {
      debugPrint('FirebaseAuthDataSource - Unexpected error: $error');
      throw FirebaseFailure(
        firebaseMessage: 'An unexpected error occurred',
        firebaseCode: FirebaseErrorCode.unknown.code,
      );
    }
  }
}
