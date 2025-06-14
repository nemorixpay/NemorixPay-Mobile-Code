import 'package:flutter/material.dart';

/// @file        terms_section.dart
/// @brief       Widget for displaying a section of Terms and Conditions.
/// @details     Renders a section title and body with proper styling and spacing.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class TermsSection extends StatelessWidget {
  final String sectionTitle;
  final String sectionBody;

  const TermsSection({
    super.key,
    required this.sectionTitle,
    required this.sectionBody,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(sectionBody, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
