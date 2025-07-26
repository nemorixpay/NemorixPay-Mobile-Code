import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

/// @file        language_list_item.dart
/// @brief       Individual language item widget for language selection.
/// @details     Displays language flag, name, and selection indicator with proper styling.
/// @author      Miguel Fagundez
/// @date        2025-07-23
/// @version     1.0
/// @copyright   Apache 2.0 License

class LanguageListItem extends StatelessWidget {
  final String languageName;
  final String flagAsset;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageListItem({
    super.key,
    required this.languageName,
    required this.flagAsset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            // Flag
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(flagAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Language Name
            Expanded(
              child: Text(
                languageName,
                style: (languageName == 'Portuguese')
                    ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.grey)
                    : Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
              ),
            ),

            // Selection Indicator
            if (isSelected)
              const Icon(
                Icons.check,
                color: NemorixColors.primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
