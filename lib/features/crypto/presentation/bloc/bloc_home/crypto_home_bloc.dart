import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_state.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_all_available_assets/crypto_market_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_all_available_assets/crypto_market_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_all_available_assets/crypto_market_state.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_state.dart';

/// @file        crypto_home_bloc.dart
/// @brief       BLoC for coordinating All/Account assets blocs.
/// @details     Handles the state management for crypto market operations like
///             getting crypto account assets and all stellar assets.
/// @author      Miguel Fagundez
/// @date        06/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CryptoHomeBloc extends Bloc<CryptoHomeEvent, CryptoHomeState> {
  final CryptoMarketBloc marketBloc;
  final CryptoAccountBloc accountBloc;

  List<CryptoAssetWithMarketData>? _marketAssets;
  List<CryptoAssetWithMarketData>? _accountAssets;

  CryptoHomeBloc({required this.marketBloc, required this.accountBloc})
      : super(const CryptoHomeInitial()) {
    on<LoadAllCryptoData>(_onLoadAllCryptoData);
  }

  Future<void> _onLoadAllCryptoData(
    LoadAllCryptoData event,
    Emitter<CryptoHomeState> emit,
  ) async {
    emit(CryptoHomeLoading());

    try {
      // Fire first event: Get all available assets
      marketBloc.add(const GetCryptoAssets());

      // Create a Completer for this CryptoMarket BLoC
      final marketCompleter = Completer<void>();

      // Subscribe to the BLoC streams
      final marketSubscription = marketBloc.stream.listen((state) {
        if (state is CryptoAssetsLoaded) {
          _marketAssets = state.assets;
          marketCompleter.complete();
        }
      });

      // Wait for the Completer to complete
      await Future.wait([marketCompleter.future]);

      // Check current states
      final marketState = marketBloc.state;
      debugPrint('Market State (CryptoHomeBloc): $marketState');

      // Fire second event: Get crypto account assets
      accountBloc.add(const GetCryptoAccountAssets());

      // Create a Completer for this CryptoAccount BLoC
      final accountCompleter = Completer<void>();

      // Subscribe to the BLoC streams
      final accountSubscription = accountBloc.stream.listen((state) {
        if (state is CryptoAccountAssetsLoaded) {
          _accountAssets = state.accountAssets;
          accountCompleter.complete();
        }
      });

      // Wait for the Completer to complete
      await Future.wait([accountCompleter.future]);

      // Check current states
      final accountState = accountBloc.state;
      debugPrint('Account State (CryptoHomeBloc): $accountState');

      // Wait a moment to ensure states are propagated
      await Future.delayed(const Duration(milliseconds: 500));

      // Cancel subscriptions
      await marketSubscription.cancel();
      await accountSubscription.cancel();

      // Check states one more time before emitting
      final finalMarketState = marketBloc.state;
      final finalAccountState = accountBloc.state;

      debugPrint('Final Market State: $finalMarketState');
      debugPrint('Final Account State: $finalAccountState');

      emit(
        CryptoHomeLoaded(
          marketAssets: _marketAssets ?? [],
          accountAssets: _accountAssets ?? [],
        ),
      );
    } catch (e) {
      debugPrint('Llamando: CryptoHomeError(2)');
      emit(CryptoHomeError(AssetFailure.unknown(e.toString())));
    }
  }
}
