import 'package:nemorixpay/core/errors/failures.dart';

/// @file        transaction_failure.dart
/// @brief       Transaction network failure for NemorixPay.
/// @details     This class represents transaction network errors in the data/domain layer.
///              It provides a standardized way to handle transaction-related errors with
///              proper error code mapping and internationalization support.
/// @author      Miguel Fagundez
/// @date        2025-09-23
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionsFailure extends Failure {
  /// Human-readable error message
  final String transactionMessage;

  /// Error code that identifies the type of error
  final String transactionCode;

  /// Creates a new [TransactionsFailure]
  ///
  /// Both [transactionCode] and [transactionMessage] are required
  TransactionsFailure({
    required this.transactionMessage,
    required this.transactionCode,
  }) : super(
          message: transactionMessage,
          code: transactionCode,
        );
}
