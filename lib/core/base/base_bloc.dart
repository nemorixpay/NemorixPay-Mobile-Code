import 'package:flutter_bloc/flutter_bloc.dart';

/// @file        base_bloc.dart
/// @brief       Base BLoC implementation for NemorixPay.
/// @details     This file contains the base BLoC class that all other BLoCs will extend,
///              providing common functionality for event handling and error management.
/// @author      Miguel Fagundez
/// @date        2024-04-24
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState) {
    on<Event>((event, emit) async {
      try {
        await handleEvent(event, emit);
      } catch (error) {
        emit(handleError(error));
      }
    });
  }

  Future<void> handleEvent(Event event, Emitter<State> emit);
  State handleError(Object error);
}
