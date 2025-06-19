import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_event.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_state.dart';
import 'package:nemorixpay/features/onboarding/domain/usecases/check_onboarding_status_usecase.dart';

/// @file        splash_bloc.dart
/// @brief       Splash screen business logic implementation for NemorixPay.
/// @details     This file contains the main business logic for the splash screen,
///              handling state management and navigation flow.
/// @author      Miguel Fagundez
/// @date        2025-05-06
/// @version     1.1
/// @copyright   Apache 2.0 License
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckOnboardingStatusUsecase checkOnboardingStatus;

  SplashBloc({required this.checkOnboardingStatus})
      : super(const SplashInitial()) {
    on<SplashInitialized>(_onSplashInitialized);
  }

  Future<void> _onSplashInitialized(
    SplashInitialized event,
    Emitter<SplashState> emit,
  ) async {
    try {
      emit(const SplashLoading());

      // Simulate a 2-second loading time
      await Future.delayed(const Duration(seconds: 2));

      // Check onboarding status
      final onboardingResult = await checkOnboardingStatus();

      onboardingResult.fold(
        (failure) {
          // If there's an error checking onboarding, default to onboarding
          emit(SplashLoaded(RouteNames.onboarding));
        },
        (isCompleted) {
          if (isCompleted) {
            // Onboarding completed, go to SignIn page
            emit(SplashLoaded(RouteNames.signIn));
          } else {
            // Onboarding not completed, show onboarding
            emit(SplashLoaded(RouteNames.onboarding));
          }
        },
      );
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }
}
