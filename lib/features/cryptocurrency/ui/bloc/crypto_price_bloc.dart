import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/crypto_entity.dart';
import '../../domain/usecases/update_crypto_price_usecase.dart';

/// @file        crypto_price_bloc.dart
/// @brief       BLoC for managing cryptocurrency price state and events.
/// @details     Handles the state management for cryptocurrency price updates.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License

// Events
abstract class CryptoPriceEvent extends Equatable {
  const CryptoPriceEvent();

  @override
  List<Object> get props => [];
}

class UpdateCryptoPrice extends CryptoPriceEvent {
  final String symbol;

  const UpdateCryptoPrice(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class StartAutoUpdate extends CryptoPriceEvent {
  final String symbol;
  final Duration interval;

  const StartAutoUpdate(
    this.symbol, {
    this.interval = const Duration(seconds: 30),
  });

  @override
  List<Object> get props => [symbol, interval];
}

class StopAutoUpdate extends CryptoPriceEvent {}

// States
abstract class CryptoPriceState extends Equatable {
  const CryptoPriceState();

  @override
  List<Object> get props => [];
}

class CryptoPriceInitial extends CryptoPriceState {}

class CryptoPriceLoading extends CryptoPriceState {}

class CryptoPriceLoaded extends CryptoPriceState {
  final CryptoEntity crypto;

  const CryptoPriceLoaded(this.crypto);

  @override
  List<Object> get props => [crypto];
}

class CryptoPriceError extends CryptoPriceState {
  final String message;

  const CryptoPriceError(this.message);

  @override
  List<Object> get props => [message];
}

// BloC
class CryptoPriceBloc extends Bloc<CryptoPriceEvent, CryptoPriceState> {
  final UpdateCryptoPriceUseCase updateCryptoPrice;
  Timer? _autoUpdateTimer;

  CryptoPriceBloc({required this.updateCryptoPrice})
    : super(CryptoPriceInitial()) {
    on<UpdateCryptoPrice>(_onUpdateCryptoPrice);
    on<StartAutoUpdate>(_onStartAutoUpdate);
    on<StopAutoUpdate>(_onStopAutoUpdate);
  }

  Future<void> _onUpdateCryptoPrice(
    UpdateCryptoPrice event,
    Emitter<CryptoPriceState> emit,
  ) async {
    emit(CryptoPriceLoading());
    try {
      final crypto = await updateCryptoPrice(event.symbol);
      emit(CryptoPriceLoaded(crypto));
    } catch (e) {
      emit(CryptoPriceError(e.toString()));
    }
  }

  Future<void> _onStartAutoUpdate(
    StartAutoUpdate event,
    Emitter<CryptoPriceState> emit,
  ) async {
    // Cancelar cualquier temporizador existente
    _autoUpdateTimer?.cancel();

    // Iniciar nuevo temporizador
    _autoUpdateTimer = Timer.periodic(event.interval, (timer) {
      add(UpdateCryptoPrice(event.symbol));
    });

    // Actualizar inmediatamente
    add(UpdateCryptoPrice(event.symbol));
  }

  void _onStopAutoUpdate(StopAutoUpdate event, Emitter<CryptoPriceState> emit) {
    _autoUpdateTimer?.cancel();
    _autoUpdateTimer = null;
  }

  @override
  Future<void> close() {
    _autoUpdateTimer?.cancel();
    return super.close();
  }
}
