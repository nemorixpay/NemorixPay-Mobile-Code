import 'package:flutter/material.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/onboarding/onboarding_error_codes.dart';

/// @file        onboarding_failure.dart
/// @brief       Failure types for Onboarding feature.
/// @details     Defines possible failures that can occur during onboarding process.
/// @author      Miguel Fagundez
/// @date        06/14/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class OnboardingFailure extends Failure {
  /// Human-readable error message
  final String onboardingMessage;

  /// Error code that identifies the type of error
  final String onboardingCode;

  /// Creates a new [AssetFailure]
  ///
  /// Both [assetCode] and [assetMessage] are required
  OnboardingFailure({
    required this.onboardingMessage,
    required this.onboardingCode,
  }) : super(message: onboardingMessage, code: onboardingCode);

  /// Creates an [OnboardingFailure] for unknown errors
  factory OnboardingFailure.unknown(String message) {
    return OnboardingFailure(
      onboardingCode: OnboardingErrorCode.unknown.code,
      onboardingMessage: message,
    );
  }

  /// Checks if this failure represents a specific error type
  bool isErrorType(OnboardingErrorCode errorCode) =>
      onboardingCode == errorCode.code;

  /// Gets a localized message for this failure
  String getLocalizedMessage(BuildContext context) {
    return OnboardingErrorCode.getMessageForCode(onboardingCode, context);
  }
}
