/// @file        splash_state.dart
/// @brief       Splash screen states implementation for NemorixPay.
/// @details     This file contains all possible states for the splash screen,
///              including initial, loading, loaded and error states.
/// @author      Miguel Fagundez
/// @date        2025-05-06
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashLoaded extends SplashState {
  final String route;

  const SplashLoaded(this.route);

  @override
  List<Object?> get props => [route];
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object?> get props => [message];
}
