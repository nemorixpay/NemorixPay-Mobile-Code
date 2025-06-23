import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/auth/firebase_failure.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/check_wallet_exists_usecase.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nemorixpay/features/auth/data/models/user_model.dart';

/// @file        auth_bloc.dart
/// @brief       Authentication Bloc for managing auth state and events.
/// @details     Handles authentication state management and user interactions.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.2
/// @copyright   Apache 2.0 License
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final SendVerificationEmailUseCase _sendVerificationEmailUseCase;
  final CheckWalletExistsUseCase _checkWalletExistsUseCase;

  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required SendVerificationEmailUseCase sendVerificationEmailUseCase,
    required CheckWalletExistsUseCase checkWalletExistsUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _sendVerificationEmailUseCase = sendVerificationEmailUseCase,
        _checkWalletExistsUseCase = checkWalletExistsUseCase,
        super(const AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<SendVerificationEmailRequested>(_onSendVerificationEmailRequested);
    on<CheckEmailVerificationStatus>(_onCheckEmailVerificationStatus);
    on<CheckWalletExists>(_onCheckWalletExists);
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
          // After successful authentication, check if user has a wallet
          add(CheckWalletExists(userId: user.id, user: user));
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

      await result.fold(
        (failure) async {
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
        (user) async {
          debugPrint('AuthBloc - User registered successfully: ${user.email}');
          emit(AuthAuthenticated(user));

          // Send verification email automatically
          debugPrint('AuthBloc - Sending verification email');
          final verificationResult = await _sendVerificationEmailUseCase();

          verificationResult.fold(
            (failure) {
              debugPrint(
                'AuthBloc - Verification email failed: ${failure.message}',
              );
              emit(VerificationEmailError(failure.message));
            },
            (success) {
              debugPrint('AuthBloc - Verification email sent successfully');
              emit(const VerificationEmailSent());
            },
          );
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

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('AuthBloc - Begin forgot password process');
    emit(const ForgotPasswordLoading());

    try {
      debugPrint('AuthBloc - Calling forgot password use case');
      final result = await _forgotPasswordUseCase(event.email);

      result.fold(
        (failure) {
          if (failure is FirebaseFailure) {
            debugPrint(
              'AuthBloc - Password recovery failed (Code): ${failure.firebaseCode}',
            );
            debugPrint('AuthBloc - Error message: ${failure.firebaseMessage}');
          } else {
            debugPrint(
              'AuthBloc - Password recovery failed: ${failure.message}',
            );
          }
          emit(ForgotPasswordError(failure.message));
        },
        (success) {
          debugPrint('AuthBloc - Password recovery email sent successfully');
          emit(const ForgotPasswordSuccess());
        },
      );
    } on FirebaseFailure catch (failure) {
      debugPrint('AuthBloc - Firebase error: ${failure.firebaseCode}');
      debugPrint('AuthBloc - Error message: ${failure.firebaseMessage}');
      emit(ForgotPasswordError(failure.firebaseMessage));
    } catch (e) {
      debugPrint('AuthBloc - Unexpected error: $e');
      emit(
        ForgotPasswordError(
          FirebaseFailure(
            firebaseMessage: e.toString(),
            firebaseCode: e.runtimeType.toString(),
          ).firebaseMessage,
        ),
      );
    }
  }

  Future<void> _onSendVerificationEmailRequested(
    SendVerificationEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('AuthBloc - Begin sending verification email');
    emit(const VerificationEmailSending());

    try {
      debugPrint('AuthBloc - Calling send verification email use case');
      final result = await _sendVerificationEmailUseCase();

      result.fold(
        (failure) {
          if (failure is FirebaseFailure) {
            debugPrint(
              'AuthBloc - Verification email failed: ${failure.firebaseCode}',
            );
            debugPrint('AuthBloc - Error message: ${failure.firebaseMessage}');
          } else {
            debugPrint(
              'AuthBloc - Verification email failed: ${failure.message}',
            );
          }
          emit(VerificationEmailError(failure.message));
        },
        (success) {
          debugPrint('AuthBloc - Verification email sent successfully');
          emit(const VerificationEmailSent());
        },
      );
    } on FirebaseFailure catch (failure) {
      debugPrint('AuthBloc - Firebase error: ${failure.firebaseCode}');
      debugPrint('AuthBloc - Error message: ${failure.firebaseMessage}');
      emit(VerificationEmailError(failure.firebaseMessage));
    } catch (e) {
      debugPrint('AuthBloc - Unexpected error: $e');
      emit(
        VerificationEmailError(
          FirebaseFailure(
            firebaseMessage: e.toString(),
            firebaseCode: e.runtimeType.toString(),
          ).firebaseMessage,
        ),
      );
    }
  }

  Future<void> _onCheckEmailVerificationStatus(
    CheckEmailVerificationStatus event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('AuthBloc - Checking email verification status');
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
      if (!user.emailVerified) {
        debugPrint('AuthBloc - Email not verified');
        emit(
          EmailNotVerified(
            UserModel(
              id: user.uid,
              email: user.email ?? '',
              isEmailVerified: false,
              createdAt: DateTime.now(),
            ).toUserEntity(),
          ),
        );
      } else {
        debugPrint('AuthBloc - Email verified');
        emit(
          AuthAuthenticated(
            UserModel(
              id: user.uid,
              email: user.email ?? '',
              isEmailVerified: true,
              createdAt: DateTime.now(),
            ).toUserEntity(),
          ),
        );
      }
    } else {
      debugPrint('AuthBloc - No user found');
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onCheckWalletExists(
    CheckWalletExists event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint(
        'AuthBloc - Checking wallet existence for userId: ${event.userId}');
    emit(const AuthLoading());

    try {
      final hasWallet = await _checkWalletExistsUseCase(event.userId);

      if (hasWallet) {
        debugPrint(
            'AuthBloc - User has wallet, emitting AuthAuthenticatedWithWallet');
        emit(AuthAuthenticatedWithWallet(event.user));
      } else {
        debugPrint(
            'AuthBloc - User does not have wallet, emitting AuthAuthenticatedWithoutWallet');
        emit(AuthAuthenticatedWithoutWallet(event.user));
      }
    } catch (e) {
      debugPrint('AuthBloc - Error checking wallet: $e');
      // In case of error, emit AuthError instead of assuming no wallet
      emit(AuthError(FirebaseFailure.unknown(e.toString())));
    }
  }
}
