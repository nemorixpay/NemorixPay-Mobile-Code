import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/auth/firebase_error_codes.dart';

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

  /// Creates a [FirebaseFailure] for user not found errors
  factory FirebaseFailure.userNotFound(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.userNotFound.code,
      firebaseMessage: message,
    );
  }

  /// Creates a [FirebaseFailure] for wrong password errors
  factory FirebaseFailure.wrongPassword(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.wrongPassword.code,
      firebaseMessage: message,
    );
  }

  /// Creates a [FirebaseFailure] for invalid email errors
  factory FirebaseFailure.invalidEmail(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.invalidEmail.code,
      firebaseMessage: message,
    );
  }

  /// Creates a [FirebaseFailure] for email already in use errors
  factory FirebaseFailure.emailAlreadyInUse(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.emailAlreadyInUse.code,
      firebaseMessage: message,
    );
  }

  /// Creates a [FirebaseFailure] for weak password errors
  factory FirebaseFailure.weakPassword(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.weakPassword.code,
      firebaseMessage: message,
    );
  }

  /// Creates a [FirebaseFailure] for email not verified errors
  factory FirebaseFailure.emailNotVerified(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.emailNotVerified.code,
      firebaseMessage: message,
    );
  }

  /// Creates a [FirebaseFailure] for network request failed errors
  factory FirebaseFailure.networkRequestFailed(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.networkRequestFailed.code,
      firebaseMessage: message,
    );
  }

  /// Creates a [FirebaseFailure] for too many requests errors
  factory FirebaseFailure.tooManyRequests(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.tooManyRequests.code,
      firebaseMessage: message,
    );
  }

  /// Creates a [FirebaseFailure] for unknown errors
  factory FirebaseFailure.unknown(String message) {
    return FirebaseFailure(
      firebaseCode: FirebaseErrorCode.unknown.code,
      firebaseMessage: message,
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
