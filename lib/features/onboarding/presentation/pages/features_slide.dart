import 'package:flutter/material.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/onboarding/presentation/widgets/onboarding_feature.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/custom_button.dart';

/// @file        features_slide.dart
/// @brief       Features slide for onboarding flow.
/// @details     Displays main features of the app with icons and descriptions.
/// @author      Miguel Fagundez
/// @date        06/17/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class FeaturesSlide extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const FeaturesSlide({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Imagen
                Center(
                  child: Image.asset(
                    ImageUrl.onboardingSlideFeatures,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                // Título
                Text(
                  l10n.onboarding_features_title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Subtítulo
                Text(
                  l10n.onboarding_features_subtitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Características
                OnboardingFeature(
                  icon: Icons.currency_exchange,
                  title: l10n.onboarding_features_trading_title,
                  description: l10n.onboarding_features_trading_desc,
                ),
                const SizedBox(height: 16),
                OnboardingFeature(
                  icon: Icons.trending_up,
                  title: l10n.onboarding_features_monitoring_title,
                  description: l10n.onboarding_features_monitoring_desc,
                ),
                const SizedBox(height: 16),
                OnboardingFeature(
                  icon: Icons.history,
                  title: l10n.onboarding_features_history_title,
                  description: l10n.onboarding_features_history_desc,
                ),
                const SizedBox(
                  height: 50,
                ),
                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      onTap: () {
                        debugPrint('Back pressed');
                        onBack();
                      },
                      label: l10n.onboarding_button_back,
                    ),
                    CustomButton(
                      onTap: () {
                        debugPrint('Next pressed');
                        onNext();
                      },
                      label: l10n.onboarding_button_next,
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
      ),
    );
  }
}
