import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        firebase_error_codes.dart
/// @brief       Firebase Authentication error codes enum for NemorixPay.
/// @details     This file contains all possible Firebase Auth error codes
///              and their corresponding message keys for internationalization.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.0
/// @copyright   Apache 2.0 License
enum FirebaseErrorCode {
  // Authentication errors
  userNotFound('user-not-found', 'authErrorUserNotFound'),
  wrongPassword('wrong-password', 'authErrorWrongPassword'),
  invalidEmail('invalid-email', 'authErrorInvalidEmail'),
  userDisabled('user-disabled', 'authErrorUserDisabled'),
  emailAlreadyInUse('email-already-in-use', 'authErrorEmailAlreadyInUse'),
  weakPassword('weak-password', 'authErrorWeakPassword'),
  operationNotAllowed('operation-not-allowed', 'authErrorOperationNotAllowed'),
  tooManyRequests('too-many-requests', 'authErrorTooManyRequests'),
  networkRequestFailed(
    'network-request-failed',
    'authErrorNetworkRequestFailed',
  ),
  requiresRecentLogin('requires-recent-login', 'authErrorRequiresRecentLogin'),
  emailNotVerified('email-not-verified', 'authErrorEmailNotVerified'),

  // General errors
  unknown('unknown', 'authErrorUnknown'),
  invalidCredential('invalid-credential', 'authErrorInvalidCredential'),
  accountExistsWithDifferentCredential(
    'account-exists-with-different-credential',
    'authErrorAccountExistsWithDifferentCredential',
  ),
  invalidVerificationCode(
    'invalid-verification-code',
    'authErrorInvalidVerificationCode',
  ),
  invalidVerificationId(
    'invalid-verification-id',
    'authErrorInvalidVerificationId',
  ),
  missingVerificationCode(
    'missing-verification-code',
    'authErrorMissingVerificationCode',
  ),
  missingVerificationId(
    'missing-verification-id',
    'authErrorMissingVerificationId',
  );

  final String code;
  final String messageKey;

  const FirebaseErrorCode(this.code, this.messageKey);

  /// Gets the user-friendly error message using the i18n system
  static String getMessageForCode(String code, BuildContext context) {
    try {
      final errorCode = FirebaseErrorCode.values.firstWhere(
        (error) => error.code == code,
      );
      return _getLocalizedMessage(errorCode.messageKey, context);
    } catch (e) {
      return _getLocalizedMessage(
        FirebaseErrorCode.unknown.messageKey,
        context,
      );
    }
  }

  /// Checks if the error code exists in the enum
  static bool isValidCode(String code) {
    return FirebaseErrorCode.values.any((error) => error.code == code);
  }

  /// Gets the localized message using the i18n system
  static String _getLocalizedMessage(String key, BuildContext context) {
    switch (key) {
      case 'authErrorUserNotFound':
        return AppLocalizations.of(context)!.authErrorUserNotFound;
      case 'authErrorWrongPassword':
        return AppLocalizations.of(context)!.authErrorWrongPassword;
      case 'authErrorInvalidEmail':
        return AppLocalizations.of(context)!.authErrorInvalidEmail;
      case 'authErrorUserDisabled':
        return AppLocalizations.of(context)!.authErrorUserDisabled;
      case 'authErrorEmailAlreadyInUse':
        return AppLocalizations.of(context)!.authErrorEmailAlreadyInUse;
      case 'authErrorWeakPassword':
        return AppLocalizations.of(context)!.authErrorWeakPassword;
      case 'authErrorOperationNotAllowed':
        return AppLocalizations.of(context)!.authErrorOperationNotAllowed;
      case 'authErrorTooManyRequests':
        return AppLocalizations.of(context)!.authErrorTooManyRequests;
      case 'authErrorNetworkRequestFailed':
        return AppLocalizations.of(context)!.authErrorNetworkRequestFailed;
      case 'authErrorRequiresRecentLogin':
        return AppLocalizations.of(context)!.authErrorRequiresRecentLogin;
      case 'authErrorUnknown':
        return AppLocalizations.of(context)!.authErrorUnknown;
      case 'authErrorInvalidCredential':
        return AppLocalizations.of(context)!.authErrorInvalidCredential;
      case 'authErrorAccountExistsWithDifferentCredential':
        return AppLocalizations.of(
          context,
        )!.authErrorAccountExistsWithDifferentCredential;
      case 'authErrorInvalidVerificationCode':
        return AppLocalizations.of(context)!.authErrorInvalidVerificationCode;
      case 'authErrorInvalidVerificationId':
        return AppLocalizations.of(context)!.authErrorInvalidVerificationId;
      case 'authErrorMissingVerificationCode':
        return AppLocalizations.of(context)!.authErrorMissingVerificationCode;
      case 'authErrorMissingVerificationId':
        return AppLocalizations.of(context)!.authErrorMissingVerificationId;
      case 'authErrorEmailNotVerified':
        return AppLocalizations.of(context)!.authErrorEmailNotVerified;
      default:
        return AppLocalizations.of(context)!.authErrorUnknown;
    }
  }
}
