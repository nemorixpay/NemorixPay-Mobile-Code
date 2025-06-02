// States
import 'package:equatable/equatable.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/asset_entity.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object> get props => [];
}

class CryptoPriceInitial extends CryptoState {}

class CryptoPriceLoading extends CryptoState {}

class CryptoPriceLoaded extends CryptoState {
  final AssetEntity asset;

  const CryptoPriceLoaded(this.asset);

  @override
  List<Object> get props => [asset];
}

class CryptoPriceError extends CryptoState {
  final Failure failure;

  const CryptoPriceError(this.failure);

  @override
  List<Object> get props => [failure];
}

// Asset List States
class CryptoListInitial extends CryptoState {}

class CryptoListLoading extends CryptoState {}

class CryptoListLoaded extends CryptoState {
  final List<AssetEntity> assets;

  const CryptoListLoaded(this.assets);

  @override
  List<Object> get props => [assets];
}

class CryptoListError extends CryptoState {
  final Failure failure;

  const CryptoListError(this.failure);

  @override
  List<Object> get props => [failure];
}
