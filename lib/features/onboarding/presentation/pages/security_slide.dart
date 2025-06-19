import 'package:flutter/material.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/onboarding/presentation/widgets/onboarding_feature.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/custom_button.dart';

/// @file        security_slide.dart
/// @brief       First slide of onboarding focused on security features.
/// @details     Displays security information and features of the app.
/// @author      Miguel Fagundez
/// @date        06/16/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class SecuritySlide extends StatelessWidget {
  final VoidCallback onNext;

  const SecuritySlide({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Security Illustration
              Image.asset(
                ImageUrl.onboardingSlideSecurity,
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 48),
              // Title
              Text(
                l10n.onboarding_security_title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                l10n.onboarding_security_subtitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Security Features
              OnboardingFeature(
                icon: Icons.fingerprint,
                title: l10n.onboarding_security_feature_biometric_title,
                description: l10n.onboarding_security_feature_biometric_desc,
              ),
              const SizedBox(height: 16),
              OnboardingFeature(
                icon: Icons.lock,
                title: l10n.onboarding_security_feature_encryption_title,
                description: l10n.onboarding_security_feature_encryption_desc,
              ),
              const SizedBox(height: 16),
              OnboardingFeature(
                icon: Icons.security,
                title: l10n.onboarding_security_feature_monitoring_title,
                description: l10n.onboarding_security_feature_monitoring_desc,
              ),
              const Spacer(),
              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(),
                  CustomButton(
                    label: l10n.onboarding_button_next,
                    onTap: () {
                      debugPrint('Next pressed');
                      onNext();
                    },
                    backgroundColor: NemorixColors.primaryColor,
                    textColor: NemorixColors.greyLevel1,
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
