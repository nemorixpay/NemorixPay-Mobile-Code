import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// @file        email_verification_controller.dart
/// @brief       Email verification controller for managing verification attempts.
/// @details     This controller manages the email verification process, including:
///              - Enforcing wait time between attempts (10 minutes)
///              - Persisting verification state
/// @author      Miguel Fagundez
/// @date        2024-05-11
/// @version     1.1
/// @copyright   Apache 2.0 License
class EmailVerificationController {
  /// Wait time in minutes between verification attempts
  static const int WAIT_TIME_MINUTES = 10;

  /// Key for storing the timestamp of the last verification attempt
  static const String LAST_ATTEMPT_KEY = 'last_verification_attempt';

  /// Checks if a new verification email can be sent
  ///
  /// Returns [true] if a new verification email can be sent, [false] otherwise.
  /// This is based on the wait time constraint.
  static Future<bool> canResendVerification() async {
    final prefs = await SharedPreferences.getInstance();
    final lastAttempt = prefs.getInt(LAST_ATTEMPT_KEY) ?? 0;

    final now = DateTime.now().millisecondsSinceEpoch;
    final timeDiff = (now - lastAttempt) / (1000 * 60); // in minutes

    return timeDiff >= WAIT_TIME_MINUTES;
  }

  /// Records a new verification attempt
  ///
  /// Updates the timestamp of the last attempt.
  static Future<void> recordVerificationAttempt() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(LAST_ATTEMPT_KEY, DateTime.now().millisecondsSinceEpoch);
  }

  /// Gets the remaining wait time in minutes
  ///
  /// Returns the number of minutes remaining before a new verification email can be sent.
  /// Returns 0 if no wait time is required.
  static Future<int> getRemainingMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    final lastAttempt = prefs.getInt(LAST_ATTEMPT_KEY) ?? 0;

    final now = DateTime.now().millisecondsSinceEpoch;
    final timeDiff = (now - lastAttempt) / (1000 * 60); // in minutes

    final remaining = WAIT_TIME_MINUTES - timeDiff.floor();
    return remaining > 0 ? remaining : 0;
  }
}
