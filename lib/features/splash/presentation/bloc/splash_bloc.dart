import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_event.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_state.dart';

/// @file        splash_bloc.dart
/// @brief       Splash screen business logic implementation for NemorixPay.
/// @details     This file contains the main business logic for the splash screen,
///              handling state management and navigation flow.
/// @author      Miguel Fagundez
/// @date        2025-05-06
/// @version     1.0
/// @copyright   Apache 2.0 License
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<SplashInitialized>(_onSplashInitialized);
  }

  Future<void> _onSplashInitialized(
    SplashInitialized event,
    Emitter<SplashState> emit,
  ) async {
    try {
      emit(const SplashLoading());

      // Simulate a 4-second loading time
      await Future.delayed(const Duration(seconds: 4));

      // TODO: Authentication logic will be implemented here
      // For now, we always navigate to splash_test
      emit(SplashLoaded(RouteNames.splashTest));
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }
}
