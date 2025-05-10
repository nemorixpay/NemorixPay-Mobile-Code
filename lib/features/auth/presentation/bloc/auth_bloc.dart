import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/firebase_failure.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';

/// @file        auth_bloc.dart
/// @brief       Authentication Bloc for managing auth state and events.
/// @details     Handles authentication state management and user interactions.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.1
/// @copyright   Apache 2.0 License
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;

  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       super(const AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('AuthBloc - Begin sign in process');
    emit(const AuthLoading());

    try {
      debugPrint('AuthBloc - Calling sign in use case');
      final result = await _signInUseCase(event.email, event.password);

      result.fold(
        (failure) {
          if (failure is FirebaseFailure) {
            debugPrint(
              'AuthBloc - Authentication failed: ${failure.firebaseCode}',
            );
            debugPrint('AuthBloc - Error message: ${failure.firebaseMessage}');
          } else {
            debugPrint('AuthBloc - Authentication failed: ${failure.message}');
          }
          emit(AuthError(failure));
          emit(const AuthUnauthenticated());
        },
        (user) {
          debugPrint(
            'AuthBloc - User authenticated successfully: ${user.email}',
          );
          emit(AuthAuthenticated(user));
        },
      );
    } on FirebaseFailure catch (failure) {
      debugPrint('AuthBloc - Firebase error: ${failure.firebaseCode}');
      debugPrint('AuthBloc - Error message: ${failure.firebaseMessage}');
      emit(AuthError(failure));
      emit(const AuthUnauthenticated());
    } catch (e) {
      debugPrint('AuthBloc - Unexpected error: $e');
      emit(
        AuthError(
          FirebaseFailure(
            firebaseMessage: e.toString(),
            firebaseCode: e.runtimeType.toString(),
          ),
        ),
      );
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('AuthBloc - Begin sign up process');
    emit(const AuthLoading());

    try {
      debugPrint('AuthBloc - Calling sign up use case');
      final result = await _signUpUseCase(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        birthDate: event.birthDate,
        securityWord: event.securityWord,
      );

      result.fold(
        (failure) {
          if (failure is FirebaseFailure) {
            debugPrint(
              'AuthBloc - Registration failed: ${failure.firebaseCode}',
            );
            debugPrint('AuthBloc - Error message: ${failure.firebaseMessage}');
          } else {
            debugPrint('AuthBloc - Registration failed: ${failure.message}');
          }
          emit(AuthError(failure));
          emit(const AuthUnauthenticated());
        },
        (user) {
          debugPrint('AuthBloc - User registered successfully: ${user.email}');
          emit(AuthAuthenticated(user));
        },
      );
    } on FirebaseFailure catch (failure) {
      debugPrint('AuthBloc - Firebase error: ${failure.firebaseCode}');
      debugPrint('AuthBloc - Error message: ${failure.firebaseMessage}');
      emit(AuthError(failure));
      emit(const AuthUnauthenticated());
    } catch (e) {
      debugPrint('AuthBloc - Unexpected error: $e');
      emit(
        AuthError(
          FirebaseFailure(
            firebaseMessage: e.toString(),
            firebaseCode: e.runtimeType.toString(),
          ),
        ),
      );
      emit(const AuthUnauthenticated());
    }
  }
}
