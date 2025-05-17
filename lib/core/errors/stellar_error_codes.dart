import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        stellar_error_codes.dart
/// @brief       Stellar network error codes enum for NemorixPay.
/// @details     This file contains all possible Stellar network error codes
///              and their corresponding message keys for internationalization.
/// @author      Miguel Fagundez
/// @date        2025-05-14
/// @version     1.0
/// @copyright   Apache 2.0 License

enum StellarErrorCode {
  // Account errors
  accountNotFound('account-not-found', 'stellarErrorAccountNotFound'),
  accountExists('account-exists', 'stellarErrorAccountExists'),
  invalidAccount('invalid-account', 'stellarErrorInvalidAccount'),
  insufficientBalance(
    'insufficient-balance',
    'stellarErrorInsufficientBalance',
  ),
  invalidPublicKey('invalid-public-key', 'stellarErrorInvalidPublicKey'),

  // Transaction errors
  transactionFailed('transaction-failed', 'stellarErrorTransactionFailed'),
  invalidTransaction('invalid-transaction', 'stellarErrorInvalidTransaction'),
  transactionExpired('transaction-expired', 'stellarErrorTransactionExpired'),
  invalidAmount('invalid-amount', 'stellarErrorInvalidAmount'),
  invalidMemo('invalid-memo', 'stellarErrorInvalidMemo'),

  // Network errors
  networkError('network-error', 'stellarErrorNetworkError'),
  serverError('server-error', 'stellarErrorServerError'),
  timeoutError('timeout-error', 'stellarErrorTimeoutError'),

  // General errors
  unknown('unknown', 'stellarErrorUnknown'),
  invalidOperation('invalid-operation', 'stellarErrorInvalidOperation'),
  invalidMnemonic('invalid-mnemonic', 'stellarErrorInvalidMnemonic'),
  invalidSecretKey('invalid-secret-key', 'stellarErrorInvalidSecretKey');

  final String code;
  final String messageKey;

  const StellarErrorCode(this.code, this.messageKey);

  /// Gets the user-friendly error message using the i18n system
  static String getMessageForCode(String code, BuildContext context) {
    try {
      final errorCode = StellarErrorCode.values.firstWhere(
        (error) => error.code == code,
      );
      return _getLocalizedMessage(errorCode.messageKey, context);
    } catch (e) {
      return _getLocalizedMessage(StellarErrorCode.unknown.messageKey, context);
    }
  }

  /// Checks if the error code exists in the enum
  static bool isValidCode(String code) {
    return StellarErrorCode.values.any((error) => error.code == code);
  }

  /// Gets the localized message using the i18n system
  static String _getLocalizedMessage(String key, BuildContext context) {
    switch (key) {
      case 'stellarErrorAccountNotFound':
        return AppLocalizations.of(context)!.stellarErrorAccountNotFound;
      case 'stellarErrorAccountExists':
        return AppLocalizations.of(context)!.stellarErrorAccountExists;
      case 'stellarErrorInvalidAccount':
        return AppLocalizations.of(context)!.stellarErrorInvalidAccount;
      case 'stellarErrorInsufficientBalance':
        return AppLocalizations.of(context)!.stellarErrorInsufficientBalance;
      case 'stellarErrorInvalidPublicKey':
        return AppLocalizations.of(context)!.stellarErrorInvalidPublicKey;
      case 'stellarErrorTransactionFailed':
        return AppLocalizations.of(context)!.stellarErrorTransactionFailed;
      case 'stellarErrorInvalidTransaction':
        return AppLocalizations.of(context)!.stellarErrorInvalidTransaction;
      case 'stellarErrorTransactionExpired':
        return AppLocalizations.of(context)!.stellarErrorTransactionExpired;
      case 'stellarErrorInvalidAmount':
        return AppLocalizations.of(context)!.stellarErrorInvalidAmount;
      case 'stellarErrorInvalidMemo':
        return AppLocalizations.of(context)!.stellarErrorInvalidMemo;
      case 'stellarErrorNetworkError':
        return AppLocalizations.of(context)!.stellarErrorNetworkError;
      case 'stellarErrorServerError':
        return AppLocalizations.of(context)!.stellarErrorServerError;
      case 'stellarErrorTimeoutError':
        return AppLocalizations.of(context)!.stellarErrorTimeoutError;
      case 'stellarErrorUnknown':
        return AppLocalizations.of(context)!.stellarErrorUnknown;
      case 'stellarErrorInvalidOperation':
        return AppLocalizations.of(context)!.stellarErrorInvalidOperation;
      case 'stellarErrorInvalidMnemonic':
        return AppLocalizations.of(context)!.stellarErrorInvalidMnemonic;
      case 'stellarErrorInvalidSecretKey':
        return AppLocalizations.of(context)!.stellarErrorInvalidSecretKey;
      default:
        return AppLocalizations.of(context)!.stellarErrorUnknown;
    }
  }
}
