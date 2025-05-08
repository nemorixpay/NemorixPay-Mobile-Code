import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/firebase_failure.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  AuthBloc({required SignInUseCase signInUseCase})
    : _signInUseCase = signInUseCase,
      super(const AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('Bloc: Iniciando proceso de login');
    emit(const AuthLoading());
    try {
      debugPrint('Bloc: Llamando a signInUseCase');
      final resp = await _signInUseCase(event.email, event.password);

      resp.fold(
        (userAuthenticatedFailure) {
          debugPrint('User was not Authenticated - Try Again!');
          emit(
            AuthError(
              FirebaseFailure(
                firebaseCode: userAuthenticatedFailure.code,
                firebaseMessage: userAuthenticatedFailure.message,
              ),
            ),
          );
          emit(const AuthUnauthenticated());
        },
        (userAuthenticatedSuccess) {
          debugPrint(
            'User was Authenticated successfully, ${userAuthenticatedSuccess.email}',
          );
          // TODO : Save user data
          emit(AuthAuthenticated(userAuthenticatedSuccess));
        },
      );
    } catch (e) {
      debugPrint('Bloc: Error capturado: $e');

      emit(
        AuthError(
          FirebaseFailure(
            firebaseCode: 'unknown',
            firebaseMessage:
                'Ha ocurrido un error inesperado. Por favor, intenta nuevamente.',
          ),
        ),
      );

      emit(const AuthUnauthenticated());
    }
  }
}
