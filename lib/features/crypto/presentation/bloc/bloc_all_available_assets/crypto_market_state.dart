import 'package:equatable/equatable.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';

/// @file        crypto_market_state.dart
/// @brief       States for the CryptoMarketBloc.
/// @details     Defines all possible states that can be emitted by the crypto market feature.
/// @author      Miguel Fagundez
/// @date        06/06/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class CryptoMarketState extends Equatable {
  const CryptoMarketState();

  @override
  List<Object?> get props => [];
}

class CryptoMarketInitial extends CryptoMarketState {
  const CryptoMarketInitial();
}

class CryptoMarketLoading extends CryptoMarketState {
  const CryptoMarketLoading();
}

class CryptoMarketError extends CryptoMarketState {
  final Failure failure;

  const CryptoMarketError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class CryptoAssetsLoaded extends CryptoMarketState {
  final List<CryptoAssetWithMarketData> assets;

  const CryptoAssetsLoaded(this.assets);

  @override
  List<Object?> get props => [assets];
}

class CryptoAssetDetailsLoaded extends CryptoMarketState {
  final CryptoAssetWithMarketData asset;

  const CryptoAssetDetailsLoaded(this.asset);

  @override
  List<Object?> get props => [asset];
}

class MarketDataLoaded extends CryptoMarketState {
  final MarketDataEntity marketData;

  const MarketDataLoaded(this.marketData);

  @override
  List<Object?> get props => [marketData];
}

class MarketDataUpdated extends CryptoMarketState {
  final MarketDataEntity marketData;

  const MarketDataUpdated(this.marketData);

  @override
  List<Object?> get props => [marketData];
}
