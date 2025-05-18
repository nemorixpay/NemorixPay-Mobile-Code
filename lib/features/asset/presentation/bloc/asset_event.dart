// Events
import 'package:equatable/equatable.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

class UpdateAssetPrice extends AssetEvent {
  final String symbol;

  const UpdateAssetPrice(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class StartAutoUpdate extends AssetEvent {
  final String symbol;
  final Duration interval;

  const StartAutoUpdate(
    this.symbol, {
    this.interval = const Duration(seconds: 30),
  });

  @override
  List<Object> get props => [symbol, interval];
}

class StopAutoUpdate extends AssetEvent {}
