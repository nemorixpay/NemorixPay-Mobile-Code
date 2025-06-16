import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        onboarding_error_codes.dart
/// @brief       Onboarding error codes enum for NemorixPay.
/// @details     This file contains all possible onboarding-related error codes
///              and their corresponding message keys for internationalization.
/// @author      Miguel Fagundez
/// @date        06/14/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
enum OnboardingErrorCode {
  // Network errors
  networkError('network-error', 'assetErrorNetworkError'),
  timeoutError('timeout-error', 'assetErrorTimeoutError'),

  // General errors
  unknown('unknown', 'assetErrorUnknown');

  final String code;
  final String messageKey;

  const OnboardingErrorCode(this.code, this.messageKey);

  /// Gets the user-friendly error message using the i18n system
  static String getMessageForCode(String code, BuildContext context) {
    try {
      final errorCode = OnboardingErrorCode.values.firstWhere(
        (error) => error.code == code,
      );
      return _getLocalizedMessage(errorCode.messageKey, context);
    } catch (e) {
      return _getLocalizedMessage(
        OnboardingErrorCode.unknown.messageKey,
        context,
      );
    }
  }

  /// Checks if the error code exists in the enum
  static bool isValidCode(String code) {
    return OnboardingErrorCode.values.any((error) => error.code == code);
  }

  /// Gets the localized message using the i18n system
  static String _getLocalizedMessage(String key, BuildContext context) {
    switch (key) {
      case 'assetErrorNetworkError':
        return AppLocalizations.of(context)!.assetErrorNetworkError;
      case 'assetErrorTimeoutError':
        return AppLocalizations.of(context)!.assetErrorTimeoutError;
      case 'assetErrorUnknown':
        return AppLocalizations.of(context)!.assetErrorUnknown;
      default:
        return AppLocalizations.of(context)!.assetErrorUnknown;
    }
  }
}
