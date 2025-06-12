import 'package:flutter/material.dart';
import 'crypto_stats_tile.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';

/// @file        crypto_stats_card.dart
/// @brief       Reusable widget to display a card with multiple crypto statistics.
/// @details     This widget groups multiple CryptoStatsTile widgets in a card layout,
///             showing key metrics like market cap, volume, supply, etc.
/// @author      Miguel Fagundez
/// @date        04/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoStatsCard extends StatelessWidget {
  final CryptoAssetWithMarketData crypto;

  const CryptoStatsCard({super.key, required this.crypto});

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
          CryptoStatsTile(
            label: 'Capitalización de Mercado',
            value: '\$${crypto.marketData.marketCap.toStringAsFixed(2)}',
          ),
          CryptoStatsTile(
            label: 'Volumen 24h',
            value: '\$${crypto.marketData.volume.toStringAsFixed(2)}',
          ),
          CryptoStatsTile(
            label: 'Suministro Circulante',
            value:
                '${crypto.marketData.circulatingSupply.toStringAsFixed(2)} ${crypto.asset.assetCode}',
          ),
          CryptoStatsTile(
            label: 'Máximo Histórico',
            value: '\$${crypto.marketData.ath.toStringAsFixed(2)}',
          ),
          CryptoStatsTile(
            label: 'Cambio 24h',
            value:
                '${crypto.marketData.priceChangePercentage.toStringAsFixed(2)}%',
          ),
        ],
      ),
    );
  }
}
