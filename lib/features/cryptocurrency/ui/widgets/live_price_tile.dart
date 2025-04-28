import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/crypto_entity.dart';

class LivePriceTile extends StatelessWidget {
  final CryptoEntity crypto;
  const LivePriceTile({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(crypto.logoPath, width: 32, height: 32),
      title: Text(
        crypto.name,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        crypto.symbol,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Text(
        crypto.currentPrice.toStringAsFixed(2),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: () {
        // TODO: Navigate to detail or show more info
        if (kDebugMode) {
          print('Tapped on ${crypto.name}');
        }
      },
    );
  }
}
