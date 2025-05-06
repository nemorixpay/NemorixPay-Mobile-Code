/// @file        splash_event.dart
/// @brief       Splash screen events implementation for NemorixPay.
/// @details     This file contains all possible events for the splash screen,
///              including initialization and any other user interactions.
/// @author      Miguel Fagundez
/// @date        2025-05-06
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashInitialized extends SplashEvent {
  const SplashInitialized();
}
