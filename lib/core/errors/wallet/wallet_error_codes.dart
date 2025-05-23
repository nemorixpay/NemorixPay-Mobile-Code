import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        wallet_error_codes.dart
/// @brief       Wallet error codes enum for NemorixPay.
/// @details     This file contains all possible wallet-related error codes
///              and their corresponding message keys for internationalization.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

enum WalletErrorCode {
  // Wallet creation errors
  creationFailed('WALLET_CREATION_ERROR', 'walletErrorCreationFailed'),
  invalidMnemonic('WALLET_INVALID_MNEMONIC', 'walletErrorInvalidMnemonic'),
  mnemonicGenerationFailed(
    'WALLET_MNEMONIC_GENERATION_ERROR',
    'walletErrorMnemonicGenerationFailed',
  ),

  // Wallet import errors
  importFailed('WALLET_IMPORT_ERROR', 'walletErrorImportFailed'),
  invalidSecretKey('WALLET_INVALID_SECRET_KEY', 'walletErrorInvalidSecretKey'),

  // Balance errors
  balanceRetrievalFailed(
    'WALLET_BALANCE_ERROR',
    'walletErrorBalanceRetrievalFailed',
  ),
  insufficientFunds(
    'WALLET_INSUFFICIENT_FUNDS',
    'walletErrorInsufficientFunds',
  ),
  accountNotFound('WALLET_ACCOUNT_NOT_FOUND', 'walletErrorAccountNotFound'),

  // Network errors
  networkError('WALLET_NETWORK_ERROR', 'walletErrorNetworkError'),
  timeoutError('WALLET_TIMEOUT_ERROR', 'walletErrorTimeoutError'),

  // General errors
  unknown('WALLET_UNKNOWN_ERROR', 'walletErrorUnknown');

  final String code;
  final String messageKey;

  const WalletErrorCode(this.code, this.messageKey);

  /// Gets the user-friendly error message using the i18n system
  static String getMessageForCode(String code, BuildContext context) {
    try {
      final errorCode = WalletErrorCode.values.firstWhere(
        (error) => error.code == code,
      );
      return _getLocalizedMessage(errorCode.messageKey, context);
    } catch (e) {
      return _getLocalizedMessage(WalletErrorCode.unknown.messageKey, context);
    }
  }

  /// Checks if the error code exists in the enum
  static bool isValidCode(String code) {
    return WalletErrorCode.values.any((error) => error.code == code);
  }

  /// Gets the localized message using the i18n system
  static String _getLocalizedMessage(String key, BuildContext context) {
    switch (key) {
      case 'walletErrorCreationFailed':
        return AppLocalizations.of(context)!.walletErrorCreationFailed;
      case 'walletErrorInvalidMnemonic':
        return AppLocalizations.of(context)!.walletErrorInvalidMnemonic;
      case 'walletErrorMnemonicGenerationFailed':
        return AppLocalizations.of(
          context,
        )!.walletErrorMnemonicGenerationFailed;
      case 'walletErrorImportFailed':
        return AppLocalizations.of(context)!.walletErrorImportFailed;
      case 'walletErrorInvalidSecretKey':
        return AppLocalizations.of(context)!.walletErrorInvalidSecretKey;
      case 'walletErrorBalanceRetrievalFailed':
        return AppLocalizations.of(context)!.walletErrorBalanceRetrievalFailed;
      case 'walletErrorInsufficientFunds':
        return AppLocalizations.of(context)!.walletErrorInsufficientFunds;
      case 'walletErrorAccountNotFound':
        return AppLocalizations.of(context)!.walletErrorAccountNotFound;
      case 'walletErrorNetworkError':
        return AppLocalizations.of(context)!.walletErrorNetworkError;
      case 'walletErrorTimeoutError':
        return AppLocalizations.of(context)!.walletErrorTimeoutError;
      case 'walletErrorUnknown':
        return AppLocalizations.of(context)!.walletErrorUnknown;
      default:
        return AppLocalizations.of(context)!.walletErrorUnknown;
    }
  }
}
