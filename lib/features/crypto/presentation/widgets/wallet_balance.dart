import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/core/utils/wallet_balance_visibility_helper.dart';

/// @file        wallet_balance.dart
/// @brief       Widget for displaying wallet balance with visibility toggle.
/// @details     Displays the current wallet balance with an option to hide/show
///              the balance for privacy. The visibility preference is persisted
///              using SharedPreferences.
/// @author      Miguel Fagundez
/// @date        02/04/2026
/// @version     1.1
/// @copyright   Apache 2.0 License

class WalletBalance extends StatefulWidget {
  final String balance;

  const WalletBalance({super.key, required this.balance});

  @override
  State<WalletBalance> createState() => _WalletBalanceState();
}

class _WalletBalanceState extends State<WalletBalance> {
  bool _isBalanceVisible = true;

  @override
  void initState() {
    super.initState();
    _loadVisibilityPreference();
  }

  /// Loads the wallet balance visibility preference from SharedPreferences
  Future<void> _loadVisibilityPreference() async {
    final isVisible =
        await WalletBalanceVisibilityHelper.loadWalletBalanceVisibility();
    if (mounted) {
      setState(() {
        _isBalanceVisible = isVisible;
      });
    }
  }

  /// Toggles the wallet balance visibility and saves the preference
  Future<void> _toggleVisibility() async {
    final newVisibility =
        await WalletBalanceVisibilityHelper.toggleWalletBalanceVisibility();
    if (mounted) {
      setState(() {
        _isBalanceVisible = newVisibility;
      });
    }
  }

  /// Returns the display text based on visibility state
  String _getDisplayText() {
    if (_isBalanceVisible) {
      return widget.balance;
    } else {
      // Show circles to hide the balance
      return '*****';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.currentWalletBalance,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: Icon(
                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: _toggleVisibility,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          // const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _getDisplayText(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
