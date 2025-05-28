// States
import 'package:equatable/equatable.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_entity.dart';

abstract class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object> get props => [];
}

class AssetPriceInitial extends AssetState {}

class AssetPriceLoading extends AssetState {}

class AssetPriceLoaded extends AssetState {
  final AssetEntity asset;

  const AssetPriceLoaded(this.asset);

  @override
  List<Object> get props => [asset];
}

class AssetPriceError extends AssetState {
  final Failure failure;

  const AssetPriceError(this.failure);

  @override
  List<Object> get props => [failure];
}

// Asset List States
class AssetListInitial extends AssetState {}

class AssetListLoading extends AssetState {}

class AssetListLoaded extends AssetState {
  final List<AssetEntity> assets;

  const AssetListLoaded(this.assets);

  @override
  List<Object> get props => [assets];
}

class AssetListError extends AssetState {
  final Failure failure;

  const AssetListError(this.failure);

  @override
  List<Object> get props => [failure];
}
