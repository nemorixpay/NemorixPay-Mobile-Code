import 'package:nemorixpay/core/errors/failures.dart';

/// @file        firebase_failure.dart
/// @brief       Authentication failure for NemorixPay auth feature using FirebaseAuth.
/// @details     This class represents authentication errors in the data/domain layer.
///              It provides a standardized way to handle auth-related errors.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
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
}
