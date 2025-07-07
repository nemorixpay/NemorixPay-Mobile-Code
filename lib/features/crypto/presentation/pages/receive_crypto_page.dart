// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/crypto_logo_widget.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/key_to_qr_image.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/address_short_field.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/line_divider_with_text.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/copy_key_to_clipboard_button.dart';

/// @file        receive_crypto_page.dart
/// @brief       Page for receiving any supported cryptocurrency.
/// @details     Displays a QR code and public address for receiving crypto assets.
///              Designed to be reusable for any crypto by passing parameters.
/// @author      Miguel Fagundez
/// @date        06/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class ReceiveCryptoPage extends StatelessWidget {
  /// Name of the cryptocurrency (e.g., "XLM", "USDC")
  final String cryptoName;

  /// Path to the logo asset
  final String logoAsset;

  /// Public key/address to receive funds
  final String publicKey;

  const ReceiveCryptoPage({
    Key? key,
    required this.cryptoName,
    required this.logoAsset,
    required this.publicKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MainHeader(
                title: l10n!.receiveCryptoTitle(cryptoName),
                showSearchButton: false,
              ),
              const SizedBox(height: 20),
              Center(
                child: _ReceiveCard(
                  cryptoName: cryptoName,
                  logoAsset: logoAsset,
                  publicKey: publicKey,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12),
                child: RoundedElevatedButton(
                  text: l10n.shareAddressButton,
                  onPressed: () async {
                    await _shareAddress(context, publicKey);
                  },
                  backgroundColor: NemorixColors.primaryColor,
                  textColor: NemorixColors.greyLevel1,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Shares the public address using the system share dialog
  static Future<void> _shareAddress(
      BuildContext context, String address) async {
    // TODO: Integrate with share_plus or similar package
    // For now, just copy to clipboard and show feedback
    await Clipboard.setData(ClipboardData(text: address));
    NemorixSnackBar.show(
      context,
      message: AppLocalizations.of(context)!.featureNotImplemented,
      type: SnackBarType.info,
    );
  }
}

/// @brief Card widget displaying QR, address, and basic actions
class _ReceiveCard extends StatelessWidget {
  final String cryptoName;
  final String logoAsset;
  final String publicKey;
  const _ReceiveCard({
    required this.cryptoName,
    required this.logoAsset,
    required this.publicKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BaseCard(
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: Need to use logoAsset from database or API
            const CryptoLogoWidget(logo: 'assets/logos/xlm.png'),
            const SizedBox(height: 24),
            Text(
              l10n!.scanQrCodeText,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            KeyToQrImage(data: publicKey),
            const SizedBox(height: 24),
            LineDividerWithText(
              text: l10n.or,
            ),
            const SizedBox(height: 12),
            Text(l10n.yourCryptoAddress(cryptoName),
                style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            AddressShortField(address: publicKey),
            const SizedBox(height: 12),
            CopyKeyToClipboardButton(address: publicKey),
            const SizedBox(height: 12),
            Text(
              l10n.blockTimeInfo,
              style:
                  theme.textTheme.labelSmall?.copyWith(color: theme.hintColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
