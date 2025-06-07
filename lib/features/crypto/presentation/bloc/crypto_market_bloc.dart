import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_assets_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_asset_details_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_market_data_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/update_market_data_usecase.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_market_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_market_state.dart';

/// @file        crypto_market_bloc.dart
/// @brief       BLoC for managing crypto market operations.
/// @details     Handles the state management for crypto market operations like
///             getting crypto assets, market data, and price updates.
/// @author      Miguel Fagundez
/// @date        2025-06-06
/// @version     1.0
/// @copyright   Apache 2.0 License

class CryptoMarketBloc extends Bloc<CryptoMarketEvent, CryptoMarketState> {
  final GetCryptoAssetsUseCase _getCryptoAssetsUseCase;
  final GetCryptoAssetDetailsUseCase _getCryptoAssetDetailsUseCase;
  final GetMarketDataUseCase _getMarketDataUseCase;
  final UpdateMarketDataUseCase _updateMarketDataUseCase;
  Timer? _autoUpdateTimer;

  CryptoMarketBloc({
    required GetCryptoAssetsUseCase getCryptoAssetsUseCase,
    required GetCryptoAssetDetailsUseCase getCryptoAssetDetailsUseCase,
    required GetMarketDataUseCase getMarketDataUseCase,
    required UpdateMarketDataUseCase updateMarketDataUseCase,
  }) : _getCryptoAssetsUseCase = getCryptoAssetsUseCase,
       _getCryptoAssetDetailsUseCase = getCryptoAssetDetailsUseCase,
       _getMarketDataUseCase = getMarketDataUseCase,
       _updateMarketDataUseCase = updateMarketDataUseCase,
       super(CryptoMarketInitial()) {
    on<GetCryptoAssets>(_onGetCryptoAssets);
    on<GetCryptoAssetDetails>(_onGetCryptoAssetDetails);
    on<GetMarketData>(_onGetMarketData);
    on<UpdateMarketData>(_onUpdateMarketData);
    on<StartAutoUpdate>(_onStartAutoUpdate);
    on<StopAutoUpdate>(_onStopAutoUpdate);
  }

  Future<void> _onGetCryptoAssets(
    GetCryptoAssets event,
    Emitter<CryptoMarketState> emit,
  ) async {
    try {
      debugPrint('CryptoMarketBloc -_onGetCryptoAssets- CryptoMarketLoading..');
      emit(CryptoMarketLoading());
      final result = await _getCryptoAssetsUseCase();
      result.fold(
        (failure) => emit(CryptoMarketError(failure)),
        (assets) => emit(CryptoAssetsLoaded(assets)),
      );
      debugPrint(
        'CryptoMarketBloc -_onGetCryptoAssets- result.fold(): ${result.toString()}',
      );
    } on AssetFailure catch (failure) {
      debugPrint(
        'CryptoMarketBloc -_onGetCryptoAssets- Error (AssetFailure): ${failure.assetMessage}',
      );
      emit(CryptoMarketError(failure));
    } catch (e) {
      debugPrint(
        'CryptoMarketBloc -_onGetCryptoAssets- Error (unknown): ${e.toString()}',
      );
      emit(CryptoMarketError(AssetFailure.unknown(e.toString())));
    }
  }

  Future<void> _onGetCryptoAssetDetails(
    GetCryptoAssetDetails event,
    Emitter<CryptoMarketState> emit,
  ) async {
    try {
      emit(CryptoMarketLoading());
      final result = await _getCryptoAssetDetailsUseCase(event.symbol);
      result.fold(
        (failure) => emit(CryptoMarketError(failure)),
        (asset) => emit(CryptoAssetDetailsLoaded(asset)),
      );
      debugPrint(
        'CryptoMarketBloc -_onGetCryptoAssetDetails- result.fold(): ${result.toString()}',
      );
    } on AssetFailure catch (failure) {
      debugPrint(
        'CryptoMarketBloc -_onGetCryptoAssetDetails- Error (AssetFailure): ${failure.assetMessage}',
      );
      emit(CryptoMarketError(failure));
    } catch (e) {
      debugPrint(
        'CryptoMarketBloc -_onGetCryptoAssetDetails- Error (unknown): ${e.toString()}',
      );
      emit(CryptoMarketError(AssetFailure.unknown(e.toString())));
    }
  }

  Future<void> _onGetMarketData(
    GetMarketData event,
    Emitter<CryptoMarketState> emit,
  ) async {
    try {
      emit(CryptoMarketLoading());
      final result = await _getMarketDataUseCase(event.symbol);
      result.fold(
        (failure) => emit(CryptoMarketError(failure)),
        (marketData) => emit(MarketDataLoaded(marketData)),
      );
      debugPrint(
        'CryptoMarketBloc -_onGetMarketData- result.fold(): ${result.toString()}',
      );
    } on AssetFailure catch (failure) {
      debugPrint(
        'CryptoMarketBloc -_onGetMarketData- Error (AssetFailure): ${failure.assetMessage}',
      );
      emit(CryptoMarketError(failure));
    } catch (e) {
      debugPrint(
        'CryptoMarketBloc -_onGetMarketData- Error (unknown): ${e.toString()}',
      );
      emit(CryptoMarketError(AssetFailure.unknown(e.toString())));
    }
  }

  Future<void> _onUpdateMarketData(
    UpdateMarketData event,
    Emitter<CryptoMarketState> emit,
  ) async {
    try {
      emit(CryptoMarketLoading());
      final result = await _updateMarketDataUseCase(event.symbol);
      result.fold(
        (failure) => emit(CryptoMarketError(failure)),
        (marketData) => emit(MarketDataUpdated(marketData)),
      );
      debugPrint(
        'CryptoMarketBloc -_onUpdateMarketData- result.fold(): ${result.toString()}',
      );
    } on AssetFailure catch (failure) {
      debugPrint(
        'CryptoMarketBloc -_onUpdateMarketData- Error (AssetFailure): ${failure.assetMessage}',
      );
      emit(CryptoMarketError(failure));
    } catch (e) {
      debugPrint(
        'CryptoMarketBloc -_onUpdateMarketData- Error (unknown): ${e.toString()}',
      );
      emit(CryptoMarketError(AssetFailure.unknown(e.toString())));
    }
  }

  Future<void> _onStartAutoUpdate(
    StartAutoUpdate event,
    Emitter<CryptoMarketState> emit,
  ) async {
    try {
      _autoUpdateTimer?.cancel();
      _autoUpdateTimer = Timer.periodic(event.interval, (timer) {
        add(UpdateMarketData(event.symbol));
      });
      add(UpdateMarketData(event.symbol));
      debugPrint('CryptoMarketBloc -_onStartAutoUpdate-}');
    } on AssetFailure catch (failure) {
      debugPrint(
        'CryptoMarketBloc -_onStartAutoUpdate- Error (AssetFailure): ${failure.assetMessage}',
      );
      emit(CryptoMarketError(failure));
    } catch (e) {
      debugPrint(
        'CryptoMarketBloc -_onStartAutoUpdate- Error (unknown): ${e.toString()}',
      );
      emit(CryptoMarketError(AssetFailure.unknown(e.toString())));
    }
  }

  void _onStopAutoUpdate(
    StopAutoUpdate event,
    Emitter<CryptoMarketState> emit,
  ) {
    try {
      _autoUpdateTimer?.cancel();
      _autoUpdateTimer = null;
      debugPrint('CryptoMarketBloc -_onStopAutoUpdate-}');
    } on AssetFailure catch (failure) {
      debugPrint(
        'CryptoMarketBloc -_onStopAutoUpdate- Error (AssetFailure): ${failure.assetMessage}',
      );
      emit(CryptoMarketError(failure));
    } catch (e) {
      debugPrint(
        'CryptoMarketBloc -_onStopAutoUpdate- Error (unknown): ${e.toString()}',
      );
      emit(CryptoMarketError(AssetFailure.unknown(e.toString())));
    }
  }

  @override
  Future<void> close() {
    _autoUpdateTimer?.cancel();
    return super.close();
  }
}
