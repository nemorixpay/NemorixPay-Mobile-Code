import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        language_search_bar.dart
/// @brief       Search bar widget for language selection.
/// @details     Custom search bar with search icon and placeholder text for filtering languages.
/// @author      Miguel Fagundez
/// @date        07/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class LanguageSearchBar extends StatelessWidget {
  final Function(String) onSearchChanged;

  const LanguageSearchBar({
    super.key,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: NemorixColors.greyLevel2,
        ),
      ),
      child: TextField(
        onChanged: onSearchChanged,
        decoration: InputDecoration(
          hintText: '${appLocalizations.search}...',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          prefixIcon: const Icon(
            Icons.search_outlined,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
