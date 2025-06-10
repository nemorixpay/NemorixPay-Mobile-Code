import 'package:equatable/equatable.dart';

/// @file        crypto_market_event.dart
/// @brief       Events for the CryptoMarketBloc.
/// @details     Defines all possible events that can be triggered in the crypto market feature.
/// @author      Miguel Fagundez
/// @date        06/06/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class CryptoMarketEvent extends Equatable {
  const CryptoMarketEvent();

  @override
  List<Object?> get props => [];
}

class GetCryptoAssets extends CryptoMarketEvent {
  const GetCryptoAssets();
}

class GetCryptoAssetDetails extends CryptoMarketEvent {
  final String symbol;

  const GetCryptoAssetDetails(this.symbol);

  @override
  List<Object?> get props => [symbol];
}

class GetMarketData extends CryptoMarketEvent {
  final String symbol;

  const GetMarketData(this.symbol);

  @override
  List<Object?> get props => [symbol];
}

class UpdateMarketData extends CryptoMarketEvent {
  final String symbol;

  const UpdateMarketData(this.symbol);

  @override
  List<Object?> get props => [symbol];
}

class StartAutoUpdate extends CryptoMarketEvent {
  final String symbol;
  final Duration interval;

  const StartAutoUpdate({
    required this.symbol,
    this.interval = const Duration(minutes: 1),
  });

  @override
  List<Object?> get props => [symbol, interval];
}

class StopAutoUpdate extends CryptoMarketEvent {
  const StopAutoUpdate();
}
