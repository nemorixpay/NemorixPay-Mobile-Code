// Reusable Widget for My Assets
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_entity.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

class AssetCard extends StatelessWidget {
  final AssetEntity asset;
  const AssetCard({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('CryptoCard: ${asset.name}');
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset.logoPath, width: 30),
            const SizedBox(height: 8),
            Text(
              asset.symbol,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${asset.currentPrice.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        30,
                        (i) => FlSpot(
                          i.toDouble(),
                          asset.currentPrice * (1 + (i % 10) / 100),
                        ),
                      ),
                      isCurved: true,
                      color: NemorixColors.successColor,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
