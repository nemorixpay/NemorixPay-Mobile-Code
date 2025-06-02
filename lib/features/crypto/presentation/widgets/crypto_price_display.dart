import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_state.dart';
import '../../domain/entities/asset_entity.dart';
import '../bloc/crypto_bloc.dart';

/// @file        crypto_price_display.dart
/// @brief       Widget for displaying crypto prices.
/// @details     Shows current price and price changes for a crypto.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoPriceDisplay extends StatelessWidget {
  final String symbol;
  final AssetEntity initialCrypto;

  const CryptoPriceDisplay({
    super.key,
    required this.symbol,
    required this.initialCrypto,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoBloc, CryptoState>(
      builder: (context, state) {
        if (state is CryptoPriceLoading) {
          return _buildLoadingState();
        } else if (state is CryptoPriceLoaded) {
          return _buildLoadedState(context, state.asset);
        } else if (state is CryptoPriceError) {
          return _buildErrorState(context, state.failure.message);
        }
        return _buildInitialState(context, initialCrypto);
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoadedState(BuildContext context, AssetEntity asset) {
    return Column(
      children: [
        Text(
          '\$${asset.currentPrice.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Última actualización: ${_formatDateTime(asset.lastUpdated)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _updatePrice(context),
          child: const Text('Actualizar Precio'),
        ),
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
        ElevatedButton(
          onPressed: () => _updatePrice(context),
          child: const Text('Reintentar'),
        ),
      ],
    );
  }

  Widget _buildInitialState(BuildContext context, AssetEntity asset) {
    return Column(
      children: [
        Text(
          '\$${asset.currentPrice.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Última actualización: ${_formatDateTime(asset.lastUpdated)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _updatePrice(context),
          child: const Text('Actualizar Precio'),
        ),
      ],
    );
  }

  // TODO this bloc uses is temporal
  // Need to be moved
  void _updatePrice(BuildContext context) {
    context.read<CryptoBloc>().add(UpdateCryptoPrice(symbol));
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }
}
