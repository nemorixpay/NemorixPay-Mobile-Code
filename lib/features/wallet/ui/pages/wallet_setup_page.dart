/// @file        wallet_setup_page.dart
/// @brief       Wallet Setup screen for NemorixPay.
/// @details     This file contains the UI for the initial wallet setup, allowing users to import or create a new wallet.
/// @author      Miguel Fagundez
/// @date        2024-06-09
/// @version     1.0
/// @copyright   Apache 2.0 License
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

class WalletSetupPage extends StatelessWidget {
  const WalletSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Wallet Image
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  'https://cdn3d.iconscout.com/3d/premium/thumb/crypto-wallet-5324736-4445632.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                l10n.walletSetupTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Subtitle
              Text(
                l10n.walletSetupSubtitle,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Import Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement import wallet functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.cardColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10n.importUsingSeedPhrase,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Create New Account Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement create wallet functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NemorixColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10n.createNewAccount,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: NemorixColors.mainBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
