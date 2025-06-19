import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_event.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_state.dart';
import 'package:nemorixpay/features/onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'package:nemorixpay/features/onboarding/domain/usecases/get_language_usecase.dart';
import 'package:flutter/foundation.dart';

/// @file        splash_bloc.dart
/// @brief       Splash screen business logic implementation for NemorixPay.
/// @details     This file contains the main business logic for the splash screen,
///              handling state management and navigation flow.
/// @author      Miguel Fagundez
/// @date        2025-05-06
/// @version     1.2
/// @copyright   Apache 2.0 License
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckOnboardingStatusUsecase checkOnboardingStatus;
  final GetLanguageUsecase getLanguage;

  SplashBloc({
    required this.checkOnboardingStatus,
    required this.getLanguage,
  }) : super(const SplashInitial()) {
    on<SplashInitialized>(_onSplashInitialized);
  }

  Future<void> _onSplashInitialized(
    SplashInitialized event,
    Emitter<SplashState> emit,
  ) async {
    try {
      debugPrint('SplashBloc: Starting splash initialization');
      emit(const SplashLoading());

      // Simulate a 2-second loading time
      await Future.delayed(const Duration(seconds: 2));

      debugPrint('SplashBloc: Checking onboarding status');
      // Check onboarding status
      final onboardingResult = await checkOnboardingStatus();

      onboardingResult.fold(
        (failure) {
          debugPrint(
              'SplashBloc: Error checking onboarding - ${failure.message}');
          // If there's an error checking onboarding, default to onboarding
          emit(SplashLoaded(RouteNames.onboarding));
        },
        (isCompleted) {
          debugPrint('SplashBloc: Onboarding completed status - $isCompleted');
          if (isCompleted) {
            debugPrint(
                'SplashBloc: Onboarding already completed, going to sign_in');
            // Onboarding completed, go to SignIn page
            emit(SplashLoaded(RouteNames.signIn));
          } else {
            debugPrint(
                'SplashBloc: Onboarding not completed, going to onboarding');
            // Onboarding not completed, show onboarding
            emit(SplashLoaded(RouteNames.onboarding));
          }
        },
      );
    } catch (e) {
      debugPrint('SplashBloc: Error during splash initialization - $e');
      emit(SplashError(e.toString()));
    }
  }
}
