import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/presentation/widgets/rounded_elevated_button.dart';

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
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.seedPhraseVerifiedTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.seedPhraseVerifiedMessage),
          const SizedBox(height: 20),
          RoundedElevatedButton(
            text: AppLocalizations.of(context)!.iUnderstand,
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close page
              onContinue(); // Proceed with wallet creation
            },
            backgroundColor: NemorixColors.primaryColor,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
