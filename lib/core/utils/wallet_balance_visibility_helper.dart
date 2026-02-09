import 'package:nemorixpay/config/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @file        wallet_balance_visibility_helper.dart
/// @brief       Helper utility for wallet balance visibility toggle functionality.
/// @details     Provides functions to save, load, and toggle wallet balance visibility
///              using SharedPreferences. This helper manages the visibility state of the
///              wallet balance, allowing users to hide or show their balance for privacy.
/// @author      Miguel Fagundez
/// @date        02/01/2026
/// @version     1.0
/// @copyright   Apache 2.0 License

class WalletBalanceVisibilityHelper {
  static const String _visibilityKey = AppConstants.walletBalanceVisibilityKey;

  /// Saves the wallet balance visibility preference
  ///
  /// [isVisible] - Whether the balance should be visible (true) or hidden (false)
  ///
  /// Returns true if the preference was saved successfully, false otherwise
  static Future<bool> saveWalletBalanceVisibility(bool isVisible) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(_visibilityKey, isVisible);
    } catch (e) {
      return false;
    }
  }

  /// Loads the wallet balance visibility preference
  ///
  /// Returns true if balance should be visible, false if hidden.
  /// Defaults to true (visible) if no preference is set.
  static Future<bool> loadWalletBalanceVisibility() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Default to visible (true) if no preference is set
      return prefs.getBool(_visibilityKey) ?? true;
    } catch (e) {
      // Return visible as default if there's an error
      return true;
    }
  }

  /// Toggles the wallet balance visibility preference
  ///
  /// Returns the new visibility state (true if visible, false if hidden)
  static Future<bool> toggleWalletBalanceVisibility() async {
    try {
      final currentVisibility = await loadWalletBalanceVisibility();
      final newVisibility = !currentVisibility;
      await saveWalletBalanceVisibility(newVisibility);
      return newVisibility;
    } catch (e) {
      // Return current state if toggle fails
      return await loadWalletBalanceVisibility();
    }
  }
}
