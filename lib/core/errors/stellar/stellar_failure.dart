import 'package:flutter/material.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_error_codes.dart';

/// @file        stellar_failure.dart
/// @brief       Stellar network failure for NemorixPay.
/// @details     This class represents Stellar network errors in the data/domain layer.
///              It provides a standardized way to handle Stellar-related errors with
///              proper error code mapping and internationalization support.
/// @author      Miguel Fagundez
/// @date        2025-05-13
/// @version     1.1
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
    final errorMessage = exception.toString().toLowerCase();

    if (errorMessage.contains('status code of 400')) {
      return StellarFailure(
        stellarCode: StellarErrorCode.accountExists.code,
        stellarMessage:
            'Esta wallet ya existe. Por favor, usa una frase semilla diferente.',
      );
    }

    if (errorMessage.contains('insufficient balance')) {
      return StellarFailure(
        stellarCode: StellarErrorCode.insufficientBalance.code,
        stellarMessage: 'Balance insuficiente para realizar la operación.',
      );
    }

    if (errorMessage.contains('network error')) {
      return StellarFailure(
        stellarCode: StellarErrorCode.networkError.code,
        stellarMessage: 'Error de conexión con la red Stellar.',
      );
    }

    return StellarFailure(
      stellarCode: StellarErrorCode.unknown.code,
      stellarMessage: exception.toString(),
    );
  }

  /// Creates a [StellarFailure] for account-related errors
  factory StellarFailure.accountError(String message) {
    return StellarFailure(
      stellarCode: StellarErrorCode.accountNotFound.code,
      stellarMessage: message,
    );
  }

  /// Creates a [StellarFailure] for transaction-related errors
  factory StellarFailure.transactionError(String message) {
    return StellarFailure(
      stellarCode: StellarErrorCode.transactionFailed.code,
      stellarMessage: message,
    );
  }

  /// Creates a [StellarFailure] for network-related errors
  factory StellarFailure.networkError(String message) {
    return StellarFailure(
      stellarCode: StellarErrorCode.networkError.code,
      stellarMessage: message,
    );
  }

  /// Checks if this failure represents a specific error type
  bool isErrorType(StellarErrorCode errorCode) => stellarCode == errorCode.code;

  /// Gets a localized message for this failure
  String getLocalizedMessage(BuildContext context) {
    return StellarErrorCode.getMessageForCode(stellarCode, context);
  }
}
