import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/shared/presentation/widgets/single_action_dialog.dart';

/// @file        seed_phrase_success_dialog.dart
/// @brief       Implementation of seed phrase verification success dialog.
/// @details     This dialog is shown after user successfully verifies their seed phrase
///             to remind them about the importance of keeping their seed phrase safe
///             and to proceed with wallet creation.
/// @author      Miguel Fagundez
/// @date        2025-05-13
/// @version     1.0
/// @copyright   Apache 2.0 License
class SeedPhraseSuccessDialog extends StatelessWidget {
  final VoidCallback onContinue;

  const SeedPhraseSuccessDialog({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SingleActionDialog(
      title: AppLocalizations.of(context)!.seedPhraseVerifiedTitle,
      buttonText: AppLocalizations.of(context)!.iUnderstand,
      onPressed: () {
        Navigator.of(context).pop(); // Close dialog
        Navigator.of(context).pop(); // Close page
        onContinue(); // Proceed with wallet creation
      },
      child: Text(AppLocalizations.of(context)!.seedPhraseVerifiedMessage),
    );
  }
}
