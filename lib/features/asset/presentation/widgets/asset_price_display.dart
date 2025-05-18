import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_event.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_state.dart';
import '../../domain/entities/asset_entity.dart';
import '../bloc/asset_bloc.dart';

/// @file        asset_price_display.dart
/// @brief       Widget for displaying asset prices.
/// @details     Shows current price and price changes for an asset.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class AssetPriceDisplay extends StatelessWidget {
  final String symbol;
  final AssetEntity initialAsset;

  const AssetPriceDisplay({
    super.key,
    required this.symbol,
    required this.initialAsset,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetBloc, AssetState>(
      builder: (context, state) {
        if (state is AssetPriceLoading) {
          return _buildLoadingState();
        } else if (state is AssetPriceLoaded) {
          return _buildLoadedState(context, state.asset);
        } else if (state is AssetPriceError) {
          return _buildErrorState(context, state.message);
        }
        return _buildInitialState(context, initialAsset);
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
    context.read<AssetBloc>().add(UpdateAssetPrice(symbol));
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }
}
