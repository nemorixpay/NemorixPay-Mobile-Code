// Events
import 'package:equatable/equatable.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

class UpdateCryptoPrice extends CryptoEvent {
  final String symbol;

  const UpdateCryptoPrice(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class StartAutoUpdate extends CryptoEvent {
  final String symbol;
  final Duration interval;

  const StartAutoUpdate(
    this.symbol, {
    this.interval = const Duration(seconds: 30),
  });

  @override
  List<Object> get props => [symbol, interval];
}

class StopAutoUpdate extends CryptoEvent {}

class GetCryptoList extends CryptoEvent {}
