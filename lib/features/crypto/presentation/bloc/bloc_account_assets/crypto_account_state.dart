import 'package:equatable/equatable.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';

/// @file        crypto_account_state.dart
/// @brief       States for the CryptoAccountBloc.
/// @details     Defines all possible states that can be emitted by the crypto market feature (account assets only).
/// @author      Miguel Fagundez
/// @date        06/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class CryptoAccountState extends Equatable {
  const CryptoAccountState();

  @override
  List<Object?> get props => [];
}

class CryptoAccountInitial extends CryptoAccountState {
  const CryptoAccountInitial();
}

class CryptoAccountLoading extends CryptoAccountState {
  const CryptoAccountLoading();
}

class CryptoAccountError extends CryptoAccountState {
  final Failure failure;

  const CryptoAccountError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class CryptoAccountAssetsLoaded extends CryptoAccountState {
  final List<CryptoAssetWithMarketData> accountAssets;

  const CryptoAccountAssetsLoaded(this.accountAssets);

  @override
  List<Object?> get props => [accountAssets];
}

class CryptoAccountAssetDetailsLoaded extends CryptoAccountState {
  final CryptoAssetWithMarketData asset;

  const CryptoAccountAssetDetailsLoaded(this.asset);

  @override
  List<Object?> get props => [asset];
}

class CryptoTransactionSent extends CryptoAccountState {
  final String hash;

  const CryptoTransactionSent(this.hash);

  @override
  List<Object?> get props => [hash];
}

class CryptoTransactionLoading extends CryptoAccountState {
  const CryptoTransactionLoading();
}

class CryptoTransactionError extends CryptoAccountState {
  final Failure failure;

  const CryptoTransactionError(this.failure);

  @override
  List<Object?> get props => [failure];
}
