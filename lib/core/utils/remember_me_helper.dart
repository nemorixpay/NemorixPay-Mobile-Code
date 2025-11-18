import 'package:nemorixpay/config/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @file        remember_me_helper.dart
/// @brief       Helper utility for Remember Me feature functionality.
/// @details     Provides functions to save, load, and clear remembered email
///              using SharedPreferences. This helper manages the Remember Me
///              feature that allows users to save their email for faster login.
/// @author      Miguel Fagundez
/// @date        11/17/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class RememberMeHelper {
  static const String _rememberMeEmailKey = AppConstants.rememberMeEmailKey;
  static const String _rememberMeEnabledKey = AppConstants.rememberMeEnabledKey;

  /// Saves the email address when Remember Me is enabled
  ///
  /// [email] - The email address to save
  ///
  /// Returns true if the email was saved successfully, false otherwise
  static Future<bool> saveRememberedEmail(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final emailSaved = await prefs.setString(_rememberMeEmailKey, email);
      final enabledSaved = await prefs.setBool(_rememberMeEnabledKey, true);
      return emailSaved && enabledSaved;
    } catch (e) {
      return false;
    }
  }

  /// Loads the remembered email address if it exists
  ///
  /// Returns the saved email address, or null if no email is saved
  static Future<String?> loadRememberedEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(_rememberMeEmailKey);
      final isEnabled = prefs.getBool(_rememberMeEnabledKey) ?? false;

      // Only return email if Remember Me was enabled
      if (email != null && isEnabled) {
        return email;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Clears the remembered email address
  ///
  /// Returns true if the email was cleared successfully, false otherwise
  static Future<bool> clearRememberedEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final emailRemoved = await prefs.remove(_rememberMeEmailKey);
      final enabledRemoved = await prefs.remove(_rememberMeEnabledKey);
      return emailRemoved && enabledRemoved;
    } catch (e) {
      return false;
    }
  }

  /// Checks if Remember Me is currently enabled
  ///
  /// Returns true if Remember Me is enabled and email is saved, false otherwise
  static Future<bool> isRememberMeEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(_rememberMeEmailKey);
      final isEnabled = prefs.getBool(_rememberMeEnabledKey) ?? false;
      return email != null && isEnabled;
    } catch (e) {
      return false;
    }
  }
}
