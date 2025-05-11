import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/firebase_error_codes.dart';

/// @file        firebase_failure.dart
/// @brief       Authentication failure for NemorixPay auth feature using FirebaseAuth.
/// @details     This class represents authentication errors in the data/domain layer.
///              It provides a standardized way to handle auth-related errors with
///              proper error code mapping and internationalization support.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.1
/// @copyright   Apache 2.0 License
class FirebaseFailure extends Failure {
  /// Human-readable error message
  final String firebaseMessage;

  /// Error code that identifies the type of error
  final String firebaseCode;

  /// Creates a new [FirebaseFailure]
  ///
  /// Both [firebaseCode] and [firebaseMessage] are required
  FirebaseFailure({required this.firebaseMessage, required this.firebaseCode})
    : super(message: firebaseMessage, code: firebaseCode);

  /// Creates a [FirebaseFailure] from a Firebase Auth exception
  ///
  /// This factory constructor handles the conversion of Firebase Auth
  /// exceptions to our standardized failure format
  factory FirebaseFailure.fromFirebaseAuthException(
    FirebaseAuthException exception,
    BuildContext context,
  ) {
    return FirebaseFailure(
      firebaseCode: exception.code,
      firebaseMessage: exception.message ?? 'Unknown error',
    );
  }

  /// Creates a [FirebaseFailure] from a generic exception
  ///
  /// This factory constructor handles unknown errors and converts them
  /// to our standardized failure format
  factory FirebaseFailure.fromException(
    Exception exception,
    BuildContext context,
  ) {
    if (exception is FirebaseAuthException) {
      return FirebaseFailure.fromFirebaseAuthException(exception, context);
    }

    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.unknown.code,
      firebaseMessage: exception.toString(),
    );
  }

  /// Checks if this failure represents a specific error type
  bool isErrorType(FirebaseErrorCode errorCode) =>
      firebaseCode == errorCode.code;

  /// Gets a localized message for this failure
  String getLocalizedMessage(BuildContext context) {
    return FirebaseErrorCode.getMessageForCode(firebaseCode, context);
  }
}
