// Reusable Widget for My Assets
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entity/crypto_entity.dart';

class AssetCard extends StatelessWidget {
  final Crypto crypto;
  const AssetCard({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('CryptoCard: ${crypto.name}');
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // color: Colors.grey[900],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(crypto.logoPath, width: 30),
            const SizedBox(height: 8),
            Text(crypto.abbreviation),
            const SizedBox(height: 4),
            Text('\$${crypto.currentPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        crypto.priceHistory['1M']!.length,
                        (i) =>
                            FlSpot(i.toDouble(), crypto.priceHistory['1M']![i]),
                      ),
                      isCurved: true,
                      color: Colors.greenAccent,
                      dotData: FlDotData(show: false),
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
