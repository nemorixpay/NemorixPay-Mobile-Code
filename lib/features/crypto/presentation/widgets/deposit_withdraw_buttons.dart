import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/action_button.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';

class DepositWithdrawButtons extends StatelessWidget {
  const DepositWithdrawButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionButton(
            icon: LucideIcons.download,
            label: AppLocalizations.of(context)!.deposit,
            onTap: () {
              debugPrint('Deposit pressed');
              NemorixSnackBar.show(
                context,
                message: AppLocalizations.of(context)!.featureNotImplemented,
                type: SnackBarType.info,
              );
            },
            color: NemorixColors.greyLevel1,
          ),
          ActionButton(
            icon: LucideIcons.upload,
            label: AppLocalizations.of(context)!.withdraw,
            onTap: () {
              debugPrint('Withdraw pressed');
              NemorixSnackBar.show(
                context,
                message: AppLocalizations.of(context)!.featureNotImplemented,
                type: SnackBarType.info,
              );
            },
            color: NemorixColors.greyLevel1,
          ),
        ],
      ),
    );
  }
}
