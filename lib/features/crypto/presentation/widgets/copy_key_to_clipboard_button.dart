import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';

/// @file        copy_key_to_clipboard_button.dart
/// @brief       Button to copy the address to clipboard
/// @details     Displays a special button to copy public address in the clipboard.
/// @author      Miguel Fagundez
/// @date        06/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CopyKeyToClipboardButton extends StatelessWidget {
  final String address;
  const CopyKeyToClipboardButton({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return OutlinedButton.icon(
      icon: const Icon(
        Icons.copy,
        size: 18,
        color: NemorixColors.primaryColor,
      ),
      label: Text(
        l10n!.copyAddressButton,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(width: 1.0, color: NemorixColors.primaryColor),
      ),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: address));
        NemorixSnackBar.show(
          // ignore: use_build_context_synchronously
          context,
          message: l10n.addressCopiedMessage,
          type: SnackBarType.info,
        );
      },
    );
  }
}
