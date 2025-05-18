import 'package:flutter/material.dart';

/// @file        asset_stats_tile.dart
/// @brief       Reusable widget to display key statistics for a given cryptocurrency.
/// @details     This widget displays a label and corresponding value, and allows for an optional favorite toggle.
///             It is used within the CryptoDetailsScreen to show metrics like Market Cap, Volume, ATH, etc.
/// @author      Miguel Fagundez
/// @date        04/14/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class AssetStatsTile extends StatelessWidget {
  final String label;
  final String value;

  const AssetStatsTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
