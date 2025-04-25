import 'package:equatable/equatable.dart';

/// @file        base_state.dart
/// @brief       Base state implementation for NemorixPay.
/// @details     This file contains the base state class that all other states will extend,
///              providing common functionality for error handling and loading states.
/// @author      Miguel Fagundez
/// @date        2024-04-24
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class BaseState extends Equatable {
  final String? error;
  final bool isLoading;

  const BaseState({this.error, this.isLoading = false});

  @override
  List<Object?> get props => [error, isLoading];
}
