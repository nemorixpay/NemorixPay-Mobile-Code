import 'package:flutter/material.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_entity.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'asset_stats_tile.dart';

/// @file        asset_stats_card.dart
/// @brief       Reusable widget to display a card with multiple asset statistics.
/// @details     This widget groups multiple CryptoStatsTile widgets in a card layout,
///             showing key metrics like market cap, volume, supply, etc.
/// @author      Miguel Fagundez
/// @date        04/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class AssetStatsCard extends StatelessWidget {
  final AssetEntity asset;

  const AssetStatsCard({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estadísticas',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          AssetStatsTile(
            label: 'Capitalización de Mercado',
            value: '\$${asset.marketCap.toStringAsFixed(2)}',
          ),
          AssetStatsTile(
            label: 'Volumen 24h',
            value: '\$${asset.volume.toStringAsFixed(2)}',
          ),
          AssetStatsTile(
            label: 'Suministro Circulante',
            value:
                '${asset.circulatingSupply.toStringAsFixed(2)} ${asset.symbol}',
          ),
          AssetStatsTile(
            label: 'Máximo Histórico',
            value: '\$${asset.ath.toStringAsFixed(2)}',
          ),
          AssetStatsTile(
            label: 'Cambio 24h',
            value: '${asset.priceChangePercentage.toStringAsFixed(2)}%',
          ),
        ],
      ),
    );
  }
}
