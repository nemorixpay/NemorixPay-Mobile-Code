import 'package:flutter/material.dart';
import 'package:nemorixpay/core/errors/failures.dart';

/// @file        stellar_failure.dart
/// @brief       Stellar network failure for NemorixPay.
/// @details     This class represents Stellar network errors in the data/domain layer.
///              It provides a standardized way to handle Stellar-related errors with
///              proper error code mapping and internationalization support.
/// @author      Miguel Fagundez
/// @date        2025-05-04
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarFailure extends Failure {
  /// Human-readable error message
  final String stellarMessage;

  /// Error code that identifies the type of error
  final String stellarCode;

  /// Creates a new [StellarFailure]
  ///
  /// Both [stellarCode] and [stellarMessage] are required
  StellarFailure({required this.stellarMessage, required this.stellarCode})
    : super(message: stellarMessage, code: stellarCode);

  /// Creates a [StellarFailure] from a generic exception
  ///
  /// This factory constructor handles unknown errors and converts them
  /// to our standardized failure format
  factory StellarFailure.fromException(Exception exception) {
    return StellarFailure(
      stellarCode: 'STELLAR_ERROR',
      stellarMessage: exception.toString(),
    );
  }

  /// Creates a [StellarFailure] for account-related errors
  factory StellarFailure.accountError(String message) {
    return StellarFailure(
      stellarCode: 'STELLAR_ACCOUNT_ERROR',
      stellarMessage: message,
    );
  }

  /// Creates a [StellarFailure] for transaction-related errors
  factory StellarFailure.transactionError(String message) {
    return StellarFailure(
      stellarCode: 'STELLAR_TRANSACTION_ERROR',
      stellarMessage: message,
    );
  }

  /// Creates a [StellarFailure] for network-related errors
  factory StellarFailure.networkError(String message) {
    return StellarFailure(
      stellarCode: 'STELLAR_NETWORK_ERROR',
      stellarMessage: message,
    );
  }
}
