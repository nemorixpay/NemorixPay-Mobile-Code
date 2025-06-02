import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_list_usecase.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_state.dart';
import '../../domain/usecases/update_crypto_price_usecase.dart';

/// @file        crypto_bloc.dart
/// @brief       BLoC for managing crypto operations - state and events.
/// @details     Handles the state management for asset operations like prices updates.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License

// BloC
class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final UpdateCryptoPriceUseCase _updateAssetPriceUseCase;
  final GetCryptoListUseCase _getCryptoListUseCase;
  Timer? _autoUpdateTimer;

  CryptoBloc({
    required UpdateCryptoPriceUseCase updateCryptoPriceUseCase,
    required GetCryptoListUseCase getCryptoListUseCase,
  }) : _updateAssetPriceUseCase = updateCryptoPriceUseCase,
       _getCryptoListUseCase = getCryptoListUseCase,
       super(CryptoPriceInitial()) {
    on<UpdateCryptoPrice>(_onUpdateAssetPrice);
    on<StartAutoUpdate>(_onStartAutoUpdate);
    on<StopAutoUpdate>(_onStopAutoUpdate);
    on<GetCryptoList>(_onGetCryptoList);
  }

  Future<void> _onUpdateAssetPrice(
    UpdateCryptoPrice event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoPriceLoading());
    try {
      final asset = await _updateAssetPriceUseCase(event.symbol);
      asset.fold(
        (failure) {
          debugPrint('WalletBloc - Wallet import failed: ${failure.message}');
          emit(CryptoPriceError(failure));
        },
        (asset) {
          debugPrint('WalletBloc - Wallet imported successfully');
          emit(CryptoPriceLoaded(asset));
        },
      );
    } catch (e) {
      final AssetFailure failure = AssetFailure.unknown(
        'Unknown Error. Try again!',
      );
      emit(CryptoPriceError(failure));
    }
  }

  Future<void> _onStartAutoUpdate(
    StartAutoUpdate event,
    Emitter<CryptoState> emit,
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

  void _onStopAutoUpdate(StopAutoUpdate event, Emitter<CryptoState> emit) {
    _autoUpdateTimer?.cancel();
    _autoUpdateTimer = null;
  }

  Future<void> _onGetCryptoList(
    GetCryptoList event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoListLoading());
    final result = await _getCryptoListUseCase();
    result.fold(
      (failure) => emit(CryptoListError(failure)),
      (assets) => emit(CryptoListLoaded(assets)),
    );
  }

  @override
  Future<void> close() {
    _autoUpdateTimer?.cancel();
    return super.close();
  }
}
