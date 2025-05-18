import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_bloc.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_event.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_state.dart';

/// @file        wallet_setup_page.dart
/// @brief       Wallet Setup screen for NemorixPay.
/// @details     This file contains the UI for the initial wallet setup, allowing users to import or create a new wallet.
/// @author      Miguel Fagundez
/// @date        2025-05-02
/// @version     1.0
/// @copyright   Apache 2.0 License

class WalletSetupPage extends StatelessWidget {
  const WalletSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<StellarBloc, StellarState>(
      listener: (context, state) {
        if (state is MnemonicGenerated) {
          Navigator.pushNamed(
            context,
            RouteNames.showSeedPhrase,
            arguments: state.mnemonic,
          );
        }
      },
      child: Scaffold(
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
                  child: Image.asset(
                    ImageUrl.walletSetupImage,
                    fit: BoxFit.scaleDown,
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
                      Navigator.pushNamed(context, RouteNames.importSeedPhrase);
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
                      // 12 words
                      // context.read<StellarBloc>().add(GenerateMnemonicEvent(strength: 128));
                      // 24 words
                      context.read<StellarBloc>().add(GenerateMnemonicEvent());
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
      ),
    );
  }
}
