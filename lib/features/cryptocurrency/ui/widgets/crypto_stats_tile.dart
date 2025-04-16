import 'package:flutter/material.dart';

/// @file        crypto_stats_tile.dart
/// @brief       Reusable widget to display key statistics for a given cryptocurrency.
/// @details     This widget displays a label and corresponding value, and allows for an optional favorite toggle.
///             It is used within the CryptoDetailsScreen to show metrics like Market Cap, Volume, ATH, etc.
/// @author      Miguel Fagundez
/// @date        04/14/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoStatsTile extends StatefulWidget {
  final String label;
  final String value;

  const CryptoStatsTile({super.key, required this.label, required this.value});

  @override
  State<CryptoStatsTile> createState() => _CryptoStatsTileState();
}

class _CryptoStatsTileState extends State<CryptoStatsTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              widget.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
