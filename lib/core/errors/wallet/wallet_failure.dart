import 'package:flutter/material.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/wallet/wallet_error_codes.dart';

/// @file        wallet_failure.dart
/// @brief       Wallet failure interface for NemorixPay.
/// @details     This class represents wallet-related errors in the data/domain layer.
///              It provides a standardized way to handle wallet-related errors with
///              proper error code mapping and internationalization support.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class WalletFailure extends Failure {
  /// Human-readable error message
  final String walletMessage;

  /// Error code that identifies the type of error
  final String walletCode;

  /// Creates a new [WalletFailure]
  ///
  /// Both [walletCode] and [walletMessage] are required
  WalletFailure({required this.walletMessage, required this.walletCode})
    : super(message: walletMessage, code: walletCode);

  /// Creates a [WalletFailure] for wallet creation-related errors
  factory WalletFailure.creationFailed(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.creationFailed.code,
      walletMessage: message,
    );
  }

  factory WalletFailure.invalidMnemonic(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.invalidMnemonic.code,
      walletMessage: message,
    );
  }

  factory WalletFailure.mnemonicGenerationFailed(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.mnemonicGenerationFailed.code,
      walletMessage: message,
    );
  }

  /// Creates a [WalletFailure] for wallet import-related errors
  factory WalletFailure.importFailed(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.importFailed.code,
      walletMessage: message,
    );
  }

  factory WalletFailure.invalidSecretKey(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.invalidSecretKey.code,
      walletMessage: message,
    );
  }

  /// Creates a [WalletFailure] for account-related errors
  factory WalletFailure.accountNotFound(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.accountNotFound.code,
      walletMessage: message,
    );
  }

  /// Creates a [WalletFailure] for insufficient funds errors
  factory WalletFailure.insufficientFunds(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.insufficientFunds.code,
      walletMessage: message,
    );
  }

  /// Creates a [WalletFailure] for network-related errors
  factory WalletFailure.networkError(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.networkError.code,
      walletMessage: message,
    );
  }

  /// Creates a [WalletFailure] for unknown errors
  factory WalletFailure.unknown(String message) {
    return WalletFailure(
      walletCode: WalletErrorCode.unknown.code,
      walletMessage: message,
    );
  }

  /// Checks if this failure represents a specific error type
  bool isErrorType(WalletErrorCode errorCode) => walletCode == errorCode.code;

  /// Gets a localized message for this failure
  String getLocalizedMessage(BuildContext context) {
    return WalletErrorCode.getMessageForCode(walletCode, context);
  }
}
