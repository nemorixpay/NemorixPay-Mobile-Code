import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/ui/widgets/rounded_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// @file        continue_button.dart
/// @brief       Widget for the continue button in cryptocurrency purchase.
/// @details     This widget implements a continue button that is enabled only when
///              a valid amount is entered for the transaction.
/// @author      Miguel Fagundez
/// @date        2025-04-29
/// @version     1.0
/// @copyright   Apache 2.0 License
class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RoundedElevatedButton(
        text: AppLocalizations.of(context)!.continueLabel,
        onPressed: isEnabled ? onPressed : null,
        backgroundColor: NemorixColors.primaryColor,
        textColor: Colors.black,
      ),
    );
  }
}
