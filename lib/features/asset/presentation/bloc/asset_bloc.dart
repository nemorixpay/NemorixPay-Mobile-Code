import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_event.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_state.dart';
import '../../domain/usecases/update_asset_price_usecase.dart';

/// @file        asset_bloc.dart
/// @brief       BLoC for managing asset operations - state and events.
/// @details     Handles the state management for asset operations like prices updates.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License

// BloC
class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final UpdateAssetPriceUseCase updateAssetPrice;
  Timer? _autoUpdateTimer;

  AssetBloc({required this.updateAssetPrice}) : super(AssetPriceInitial()) {
    on<UpdateAssetPrice>(_onUpdateAssetPrice);
    on<StartAutoUpdate>(_onStartAutoUpdate);
    on<StopAutoUpdate>(_onStopAutoUpdate);
  }

  Future<void> _onUpdateAssetPrice(
    UpdateAssetPrice event,
    Emitter<AssetState> emit,
  ) async {
    emit(AssetPriceLoading());
    try {
      final asset = await updateAssetPrice(event.symbol);
      asset.fold(
        (failure) {
          debugPrint('WalletBloc - Wallet import failed: ${failure.message}');
          emit(AssetPriceError(failure));
        },
        (asset) {
          debugPrint('WalletBloc - Wallet imported successfully');
          emit(AssetPriceLoaded(asset));
        },
      );
    } catch (e) {
      final AssetFailure failure = AssetFailure.unknown(
        'Unknown Error. Try again!',
      );
      emit(AssetPriceError(failure));
    }
  }

  Future<void> _onStartAutoUpdate(
    StartAutoUpdate event,
    Emitter<AssetState> emit,
  ) async {
    // Cancelar cualquier temporizador existente
    _autoUpdateTimer?.cancel();

    // Iniciar nuevo temporizador
    _autoUpdateTimer = Timer.periodic(event.interval, (timer) {
      add(UpdateAssetPrice(event.symbol));
    });

    // Actualizar inmediatamente
    add(UpdateAssetPrice(event.symbol));
  }

  void _onStopAutoUpdate(StopAutoUpdate event, Emitter<AssetState> emit) {
    _autoUpdateTimer?.cancel();
    _autoUpdateTimer = null;
  }

  @override
  Future<void> close() {
    _autoUpdateTimer?.cancel();
    return super.close();
  }
}
