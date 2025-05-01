import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/crypto_entity.dart';
import '../../presentation/bloc/crypto_price_bloc.dart';

/// @file        crypto_price_display.dart
/// @brief       Widget for displaying cryptocurrency prices.
/// @details     Shows current price and price changes for a cryptocurrency.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoPriceDisplay extends StatelessWidget {
  final String symbol;
  final CryptoEntity initialCrypto;

  const CryptoPriceDisplay({
    Key? key,
    required this.symbol,
    required this.initialCrypto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoPriceBloc, CryptoPriceState>(
      builder: (context, state) {
        if (state is CryptoPriceLoading) {
          return _buildLoadingState();
        } else if (state is CryptoPriceLoaded) {
          return _buildLoadedState(context, state.crypto);
        } else if (state is CryptoPriceError) {
          return _buildErrorState(context, state.message);
        }
        return _buildInitialState(context, initialCrypto);
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoadedState(BuildContext context, CryptoEntity crypto) {
    return Column(
      children: [
        Text(
          '\$${crypto.currentPrice.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Última actualización: ${_formatDateTime(crypto.lastUpdated)}',
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

  Widget _buildInitialState(BuildContext context, CryptoEntity crypto) {
    return Column(
      children: [
        Text(
          '\$${crypto.currentPrice.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Última actualización: ${_formatDateTime(crypto.lastUpdated)}',
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

  void _updatePrice(BuildContext context) {
    context.read<CryptoPriceBloc>().add(UpdateCryptoPrice(symbol));
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }
}
