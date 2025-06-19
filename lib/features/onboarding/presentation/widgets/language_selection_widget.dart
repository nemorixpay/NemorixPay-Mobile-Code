import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        language_selection_widget.dart
/// @brief       Language selection widget for onboarding.
/// @details     This widget allows users to select their preferred language
///              during the onboarding process.
/// @author      Miguel Fagundez
/// @date        01/18/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class LanguageSelectionWidget extends StatefulWidget {
  final String? currentLanguage;
  final Function(String) onLanguageSelected;

  const LanguageSelectionWidget({
    super.key,
    this.currentLanguage,
    required this.onLanguageSelected,
  });

  @override
  State<LanguageSelectionWidget> createState() =>
      _LanguageSelectionWidgetState();
}

class _LanguageSelectionWidgetState extends State<LanguageSelectionWidget> {
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLanguage ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Title
              Text(
                'Welcome to NemorixPay',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: NemorixColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Select your preferred language',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withOpacity(0.8),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Language options
              _buildLanguageOption(
                context,
                'English',
                'en',
                Icons.language,
              ),
              const SizedBox(height: 16),
              _buildLanguageOption(
                context,
                'Español',
                'es',
                Icons.language,
              ),
              const SizedBox(height: 48),

              // Continue button
              RoundedElevatedButton(
                text: _selectedLanguage == 'es' ? 'Continuar' : 'Continue',
                onPressed: () {
                  if (_selectedLanguage != null) {
                    widget.onLanguageSelected(_selectedLanguage!);
                  }
                },
                backgroundColor: NemorixColors.primaryColor,
                textColor: NemorixColors.greyLevel1,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String displayName,
    String languageCode,
    IconData icon,
  ) {
    final isSelected = _selectedLanguage == languageCode;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = languageCode;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? NemorixColors.primaryColor.withOpacity(0.1)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? NemorixColors.primaryColor
                : NemorixColors.greyLevel3,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? NemorixColors.primaryColor
                  : Theme.of(context).textTheme.bodyLarge?.color,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              displayName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? NemorixColors.primaryColor
                        : Theme.of(context).textTheme.titleMedium?.color,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: NemorixColors.primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
