import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';

class LivePriceTile extends StatelessWidget {
  final CryptoAssetWithMarketData crypto;
  const LivePriceTile({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        // TODO - Check general image
        //asset.asset.logoUrl ?? ImageUrl.temporalCryptoLogo,
        crypto.asset.isNative()
            ? ImageUrl.xlmLogo
            : crypto.asset.logoUrl ?? ImageUrl.temporalCryptoLogo,
        width: 32,
        height: 32,
      ),
      title: Text(
        crypto.asset.name,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        crypto.asset.assetCode,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Text(
        '\$${crypto.marketData.currentPrice.toStringAsFixed(2)}',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: () {
        // TODO: Navigate to detail or show more info
        if (kDebugMode) {
          print('Tapped on ${crypto.asset.name}');
        }
        Navigator.pushNamed(context, RouteNames.assetDetails,
            arguments: crypto);
      },
    );
  }
}
