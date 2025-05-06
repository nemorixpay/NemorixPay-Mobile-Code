import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// @file        terms_and_conditions_section.dart
/// @brief       Widget for the terms and conditions section.
/// @details     This widget displays the transaction terms and conditions,
///              including a clickable link and a message about applied fees.
/// @author      Miguel Fagundez
/// @date        2025-04-29
/// @version     1.0
/// @copyright   Apache 2.0 License
class TermsAndConditionsSection extends StatelessWidget {
  final VoidCallback onTermsTap;

  const TermsAndConditionsSection({super.key, required this.onTermsTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.clickHereFor,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              GestureDetector(
                onTap: onTermsTap,
                child: Text(
                  AppLocalizations.of(context)!.termsAndConditions,
                  style: const TextStyle(color: NemorixColors.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.transactionFeeTaken,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
