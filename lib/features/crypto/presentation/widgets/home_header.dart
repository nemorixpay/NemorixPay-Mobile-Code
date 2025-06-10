import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/deposit_withdraw_buttons.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/wallet_balance.dart';

/// @file        home_header.dart
/// @brief       Header widget for the home page.
/// @details     This widget contains the search bar, notifications, wallet balance,
///              and deposit/withdraw buttons for the home page.
/// @author      Miguel Fagundez
/// @date        04/05/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class HomeHeader extends StatefulWidget {
  /// Callback when search is toggled
  final VoidCallback onSearchToggle;

  /// Callback when search text changes
  final ValueChanged<String> onSearchChanged;

  /// Current search state
  final bool isSearching;

  const HomeHeader({
    super.key,
    required this.onSearchToggle,
    required this.onSearchChanged,
    required this.isSearching,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: NemorixColors.primaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (!widget.isSearching)
                IconButton(
                  icon: Icon(
                    widget.isSearching ? Icons.close : Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    widget.onSearchToggle();
                  },
                ),
              widget.isSearching
                  ? Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: widget.onSearchChanged,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.search,
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                      autofocus: true,
                    ),
                  )
                  : Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.appName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
              const SizedBox(width: 8),
              if (widget.isSearching)
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    _searchController.clear();
                    widget.onSearchToggle();
                  },
                ),
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          const WalletBalance(balance: '\$12,345.67'),
          const DepositWithdrawButtons(),
        ],
      ),
    );
  }
}
