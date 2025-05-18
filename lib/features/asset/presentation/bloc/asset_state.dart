// States
import 'package:equatable/equatable.dart';
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
  final String message;

  const AssetPriceError(this.message);

  @override
  List<Object> get props => [message];
}
