import 'package:equatable/equatable.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';

/// @file        crypto_home_state.dart
/// @brief       States for the CryptoHomeBloc.
/// @details     Defines all possible states that can be emitted by the crypto market feature (Home page only).
/// @author      Miguel Fagundez
/// @date        06/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class CryptoHomeState extends Equatable {
  const CryptoHomeState();

  @override
  List<Object?> get props => [];
}

class CryptoHomeInitial extends CryptoHomeState {
  const CryptoHomeInitial();
}

class CryptoHomeLoading extends CryptoHomeState {
  const CryptoHomeLoading();
}

class CryptoHomeError extends CryptoHomeState {
  final Failure failure;

  const CryptoHomeError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class CryptoHomeLoaded extends CryptoHomeState {
  final List<CryptoAssetWithMarketData> marketAssets;
  final List<CryptoAssetWithMarketData> accountAssets;

  const CryptoHomeLoaded({
    required this.marketAssets,
    required this.accountAssets,
  });
}
