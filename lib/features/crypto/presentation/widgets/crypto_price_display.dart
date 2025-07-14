import 'package:flutter/material.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        crypto_price_display.dart
/// @brief       Widget for displaying crypto prices.
/// @details     Shows current price and price changes for a crypto.
/// @author      Miguel Fagundez
/// @date        06/12/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class CryptoPriceDisplay extends StatelessWidget {
  final String symbol;
  final CryptoAssetWithMarketData initialCrypto;

  const CryptoPriceDisplay({
    super.key,
    required this.symbol,
    required this.initialCrypto,
  });

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<CryptoBloc, CryptoState>(
    //   builder: (context, state) {
    //     if (state is CryptoPriceLoading) {
    //       return _buildLoadingState();
    //     } else if (state is CryptoPriceLoaded) {
    //       return _buildLoadedState(context, state.asset);
    //     } else if (state is CryptoPriceError) {
    //       return _buildErrorState(context, state.failure.message);
    //     }
    return _buildInitialState(context, initialCrypto);
    //   },
    // );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoadedState(
    BuildContext context,
    CryptoAssetWithMarketData asset,
  ) {
    return Column(
      children: [
        Text(
          '\$${asset.marketData.currentPrice.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '${AppLocalizations.of(context)!.lastUpdateOnly}: ${_formatDateTime(asset.marketData.lastUpdated)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        // ElevatedButton(
        //   onPressed: () => _updatePrice(context),
        //   child: const Text('Actualizar Precio'),
        // ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Column(
      children: [
        Text(
          'Error: $message',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
        const SizedBox(height: 8),
        // ElevatedButton(
        //   onPressed: () => _updatePrice(context),
        //   child: const Text('Reintentar'),
        // ),
      ],
    );
  }

  Widget _buildInitialState(
    BuildContext context,
    CryptoAssetWithMarketData asset,
  ) {
    return Column(
      children: [
        Text(
          '\$${asset.marketData.currentPrice.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '${AppLocalizations.of(context)!.lastUpdateOnly}: ${_formatDateTime(asset.marketData.lastUpdated)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        // ElevatedButton(
        //   onPressed: () => _updatePrice(context),
        //   child: const Text('Actualizar Precio'),
        // ),
      ],
    );
  }

  // TODO this bloc uses is temporal
  // Need to be moved
  void _updatePrice(BuildContext context) {
    debugPrint('Update Asset price');
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }
}
