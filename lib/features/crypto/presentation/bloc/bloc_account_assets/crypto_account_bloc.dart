import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_asset_details_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_account_assets_usecase.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_state.dart';

/// @file        crypto_account_bloc.dart
/// @brief       BLoC for managing crypto account operations.
/// @details     Handles the state management for crypto market operations like
///             getting crypto account assets.
/// @author      Miguel Fagundez
/// @date        06/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CryptoAccountBloc extends Bloc<CryptoAccountEvent, CryptoAccountState> {
  final GetCryptoAccountAssetsUseCase _getCryptoAccountAssetsUseCase;
  final GetCryptoAssetDetailsUseCase _getCryptoAssetDetailsUseCase;

  CryptoAccountBloc({
    required GetCryptoAccountAssetsUseCase getCryptoAccountAssetsUseCase,
    required GetCryptoAssetDetailsUseCase getCryptoAssetDetailsUseCase,
  }) : _getCryptoAccountAssetsUseCase = getCryptoAccountAssetsUseCase,
       _getCryptoAssetDetailsUseCase = getCryptoAssetDetailsUseCase,
       super(CryptoAccountInitial()) {
    on<GetCryptoAccountAssets>(_onGetCryptoAccountAssets);
    on<GetCryptoAccountAssetDetails>(_onGetCryptoAssetDetails);
  }

  Future<void> _onGetCryptoAccountAssets(
    GetCryptoAccountAssets event,
    Emitter<CryptoAccountState> emit,
  ) async {
    try {
      debugPrint(
        'CryptoAccountBloc -_onGetCryptoAccountAssets- CryptoAccountLoading..',
      );
      emit(CryptoAccountLoading());
      final result = await _getCryptoAccountAssetsUseCase();
      result.fold(
        (failure) => emit(CryptoAccountError(failure)),
        (assets) => emit(CryptoAccountAssetsLoaded(assets)),
      );
    } on AssetFailure catch (failure) {
      debugPrint(
        'CryptoAccountBloc -_onGetCryptoAccountAssets- Error (AssetFailure): ${failure.assetMessage}',
      );
      emit(CryptoAccountError(failure));
    } catch (e) {
      debugPrint(
        'CryptoAccountBloc -_onGetCryptoAccountAssets- Error (unknown): ${e.toString()}',
      );
      emit(CryptoAccountError(AssetFailure.unknown(e.toString())));
    }
  }

  Future<void> _onGetCryptoAssetDetails(
    GetCryptoAccountAssetDetails event,
    Emitter<CryptoAccountState> emit,
  ) async {
    try {
      emit(CryptoAccountLoading());
      final result = await _getCryptoAssetDetailsUseCase(event.symbol);
      result.fold(
        (failure) => emit(CryptoAccountError(failure)),
        (asset) => emit(CryptoAccountAssetDetailsLoaded(asset)),
      );
    } on AssetFailure catch (failure) {
      debugPrint(
        'CryptoAccountBloc -_onGetCryptoAssetDetails- Error (AssetFailure): ${failure.assetMessage}',
      );
      emit(CryptoAccountError(failure));
    } catch (e) {
      debugPrint(
        'CryptoAccountBloc -_onGetCryptoAssetDetails- Error (unknown): ${e.toString()}',
      );
      emit(CryptoAccountError(AssetFailure.unknown(e.toString())));
    }
  }
}
