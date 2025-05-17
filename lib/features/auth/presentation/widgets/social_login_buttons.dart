import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

/// @file        social_login_buttons.dart
/// @brief       Widget for social login buttons.
/// @details     This widget handles social login buttons for providers like Google and Apple.
///              Each button has a consistent style with NemorixPay's visual identity
///              and handles its own callback.
/// @author      Miguel Fagundez
/// @date        04/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class SocialLoginButtons extends StatelessWidget {
  /// Callback for Google button
  final VoidCallback? onGooglePressed;

  /// Callback for Apple button
  final VoidCallback? onApplePressed;

  /// Button width as a percentage of screen width (0.0 to 1.0)
  final double widthFactor;

  /// Spacing between buttons
  final double spacing;

  const SocialLoginButtons({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
    this.widthFactor = 0.9,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSocialButton(
          context: context,
          text: AppLocalizations.of(context)!.continueWithGoogle,
          icon: ImageUrl.googleLogo,
          onPressed: onGooglePressed,
        ),
        SizedBox(height: spacing),
        _buildSocialButton(
          context: context,
          text: AppLocalizations.of(context)!.continueWithApple,
          icon: ImageUrl.appleLogo,
          onPressed: onApplePressed,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required String text,
    required String icon,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: NemorixColors.greyLevel6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: NemorixColors.greyLevel5, width: 1),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 20, width: 20),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: NemorixColors.mainBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
