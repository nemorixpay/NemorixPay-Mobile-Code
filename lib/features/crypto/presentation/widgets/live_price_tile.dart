import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/features/crypto/domain/entities/asset_entity.dart';

class LivePriceTile extends StatelessWidget {
  final AssetEntity asset;
  const LivePriceTile({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(asset.logoPath, width: 32, height: 32),
      title: Text(
        asset.name,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        asset.symbol,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Text(
        asset.currentPrice.toStringAsFixed(2),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: () {
        // TODO: Navigate to detail or show more info
        if (kDebugMode) {
          print('Tapped on ${asset.name}');
        }
      },
    );
  }
}
