import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nemorixpay/core/errors/firebase_failure.dart';
import 'package:nemorixpay/features/auth/data/datasources/auth_datasource.dart';
import 'package:nemorixpay/features/auth/data/models/user_model.dart';

/// @file        firebase_auth_datasource.dart
/// @brief       Firebase Authentication implementation for NemorixPay auth feature.
/// @details     This class implements the AuthDataSource interface using Firebase Authentication.
///              It handles all authentication operations including sign in, sign up, and email verification.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
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
      debugPrint('FirebaseAuthDataSource - Begin');
      debugPrint(email);
      debugPrint(password);
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(credentials.toString());
      debugPrint('FirebaseAuthDataSource - End');

      if (credentials.user?.uid != null) {
        debugPrint('FirebaseAuthDataSource - User can be authenticated!');
        final UserModel user = UserModel(
          id: credentials.user?.uid.toString() ?? '',
          email: email,
          isEmailVerified: true,
          createdAt: DateTime.now(),
        );
        return user;
      } else {
        debugPrint('FirebaseAuthDataSource - User cannot be authenticated!');
        throw (FirebaseFailure(
          firebaseMessage: 'User cannot be authenticated!',
          firebaseCode: 'Unknown',
        ));
      }
    } catch (error) {
      debugPrint('FirebaseAuthDataSource - Try - catch block');
      if (kDebugMode) {
        debugPrint(error.toString());
      }
      throw (FirebaseFailure(
        firebaseMessage: 'User cannot be authenticated!',
        firebaseCode: 'Unknown',
      ));
    }
  }
}
