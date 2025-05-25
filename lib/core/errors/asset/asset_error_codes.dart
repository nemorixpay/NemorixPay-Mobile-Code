import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        asset_error_codes.dart
/// @brief       Asset error codes enum for NemorixPay.
/// @details     This file contains all possible asset-related error codes
///              and their corresponding message keys for internationalization.
/// @author      Miguel Fagundez
/// @date        2025-05-25
/// @version     1.0
/// @copyright   Apache 2.0 License

enum AssetErrorCode {
  // Price errors
  priceUpdateFailed('price-update-failed', 'assetErrorPriceUpdateFailed'),
  invalidPriceData('invalid-price-data', 'assetErrorInvalidPriceData'),
  priceHistoryNotFound(
    'price-history-not-found',
    'assetErrorPriceHistoryNotFound',
  ),

  // Network errors
  networkError('network-error', 'assetErrorNetworkError'),
  timeoutError('timeout-error', 'assetErrorTimeoutError'),

  // Data errors
  invalidSymbol('invalid-symbol', 'assetErrorInvalidSymbol'),
  dataParsingError('data-parsing-error', 'assetErrorDataParsingError'),

  // General errors
  unknown('unknown', 'assetErrorUnknown');

  final String code;
  final String messageKey;

  const AssetErrorCode(this.code, this.messageKey);

  /// Gets the user-friendly error message using the i18n system
  static String getMessageForCode(String code, BuildContext context) {
    try {
      final errorCode = AssetErrorCode.values.firstWhere(
        (error) => error.code == code,
      );
      return _getLocalizedMessage(errorCode.messageKey, context);
    } catch (e) {
      return _getLocalizedMessage(AssetErrorCode.unknown.messageKey, context);
    }
  }

  /// Checks if the error code exists in the enum
  static bool isValidCode(String code) {
    return AssetErrorCode.values.any((error) => error.code == code);
  }

  /// Gets the localized message using the i18n system
  static String _getLocalizedMessage(String key, BuildContext context) {
    switch (key) {
      case 'assetErrorPriceUpdateFailed':
        return AppLocalizations.of(context)!.assetErrorPriceUpdateFailed;
      case 'assetErrorInvalidPriceData':
        return AppLocalizations.of(context)!.assetErrorInvalidPriceData;
      case 'assetErrorPriceHistoryNotFound':
        return AppLocalizations.of(context)!.assetErrorPriceHistoryNotFound;
      case 'assetErrorNetworkError':
        return AppLocalizations.of(context)!.assetErrorNetworkError;
      case 'assetErrorTimeoutError':
        return AppLocalizations.of(context)!.assetErrorTimeoutError;
      case 'assetErrorInvalidSymbol':
        return AppLocalizations.of(context)!.assetErrorInvalidSymbol;
      case 'assetErrorDataParsingError':
        return AppLocalizations.of(context)!.assetErrorDataParsingError;
      case 'assetErrorUnknown':
        return AppLocalizations.of(context)!.assetErrorUnknown;
      default:
        return AppLocalizations.of(context)!.assetErrorUnknown;
    }
  }
}
