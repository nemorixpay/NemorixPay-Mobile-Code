import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entity/crypto_entity.dart';

class LivePriceTile extends StatelessWidget {
  final Crypto crypto;
  const LivePriceTile({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(crypto.logoPath, width: 32, height: 32),
      title: Text(crypto.name),
      subtitle: Text(crypto.project),
      trailing: Text(
        crypto.currentPrice.toStringAsFixed(2),
        style: const TextStyle(fontWeight: FontWeight.bold),
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
