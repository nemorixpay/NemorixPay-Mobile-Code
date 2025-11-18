import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/core/errors/auth/firebase_failure.dart';
import 'package:nemorixpay/core/services/navigation_service.dart';
import 'package:nemorixpay/core/utils/remember_me_helper.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/check_wallet_exists_usecase.dart';
import 'package:nemorixpay/features/terms/domain/usecases/check_terms_acceptance_usecase.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nemorixpay/features/auth/data/models/user_model.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nemorixpay/shared/analytics/data/datasources/users_analytics_datasource_impl.dart';
import 'package:nemorixpay/shared/analytics/services/users_analytics_service.dart';

/// @file        auth_bloc.dart
/// @brief       Authentication Bloc for managing auth state and events.
/// @details     Handles authentication state management and user interactions.
///              Now integrates NavigationService for post-auth navigation logic
///              and user analytics tracking for registration events.
///              Added CheckAuthStatus handler to verify persisted Firebase sessions.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.6
/// @copyright   Apache 2.0 License
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final SendVerificationEmailUseCase _sendVerificationEmailUseCase;
  final CheckWalletExistsUseCase _checkWalletExistsUseCase;
  final CheckTermsAcceptanceUseCase _checkTermsAcceptanceUseCase;
  final NavigationService _navigationService;

  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required SendVerificationEmailUseCase sendVerificationEmailUseCase,
    required CheckWalletExistsUseCase checkWalletExistsUseCase,
    required CheckTermsAcceptanceUseCase checkTermsAcceptanceUseCase,
    required NavigationService navigationService,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _sendVerificationEmailUseCase = sendVerificationEmailUseCase,
        _checkWalletExistsUseCase = checkWalletExistsUseCase,
        _checkTermsAcceptanceUseCase = checkTermsAcceptanceUseCase,
        _navigationService = navigationService,
        super(const AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<SendVerificationEmailRequested>(_onSendVerificationEmailRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<CheckEmailVerificationStatus>(_onCheckEmailVerificationStatus);
    on<CheckWalletExists>(_onCheckWalletExists);
    on<DeterminePostAuthNavigation>(_onDeterminePostAuthNavigation);
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
        (user) async {
          debugPrint(
            'AuthBloc - User authenticated successfully: ${user.email}',
          );

          // Save email if Remember Me is enabled
          if (event.rememberMe) {
            debugPrint('AuthBloc - Remember Me enabled, saving email');
            await RememberMeHelper.saveRememberedEmail(event.email);
          } else {
            debugPrint('AuthBloc - Remember Me disabled, clearing saved email');
            await RememberMeHelper.clearRememberedEmail();
          }

          // After successful authentication, determine post-auth navigation
          add(DeterminePostAuthNavigation(userId: user.id, user: user));
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

          // Track user registration for analytics
          try {
            debugPrint('AuthBloc - Tracking user registration for analytics');
            final httpClient = http.Client();
            final datasource =
                UsersAnalyticsDatasourceImpl(httpClient: httpClient);
            final analyticsService =
                UsersAnalyticsService(datasource: datasource);

            final now = DateTime.now();
            final registrationDate =
                '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
            final birthDate =
                '${event.birthDate.year.toString().padLeft(4, '0')}-${event.birthDate.month.toString().padLeft(2, '0')}-${event.birthDate.day.toString().padLeft(2, '0')}';

            await analyticsService.trackUserRegistration(
              userId: user.id,
              name: '${event.firstName} ${event.lastName}',
              country: event.countryCode,
              platform: Platform.isIOS ? 'ios' : 'android',
              registrationDate: registrationDate,
              birthDate: birthDate,
            );

            debugPrint('AuthBloc - User analytics tracked successfully');
            httpClient.close();
          } catch (e) {
            debugPrint('AuthBloc - Analytics tracking failed: $e');
            // Don't affect the main flow - analytics is optional
          }

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

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('AuthBloc - Checking authentication status');
    emit(const AuthLoading());

    try {
      final isRememberEnabled = await RememberMeHelper.isRememberMeEnabled();

      if (!isRememberEnabled) {
        debugPrint('AuthBloc - Remember is not enabled');
        await FirebaseAuth.instance.signOut();
      }

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        debugPrint('AuthBloc - User found, reloading to verify session');
        await user.reload();

        // Check if user is still valid after reload
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          debugPrint('AuthBloc - User session expired after reload');
          emit(const AuthUnauthenticated());
          return;
        }

        if (!currentUser.emailVerified) {
          debugPrint('AuthBloc - User authenticated but email not verified');
          emit(
            EmailNotVerified(
              UserModel(
                id: currentUser.uid,
                email: currentUser.email ?? '',
                isEmailVerified: false,
                createdAt: DateTime.now(),
              ).toUserEntity(),
            ),
          );
        } else {
          debugPrint('AuthBloc - User authenticated and email verified');
          final userEntity = UserModel(
            id: currentUser.uid,
            email: currentUser.email ?? '',
            isEmailVerified: true,
            createdAt: DateTime.now(),
          ).toUserEntity();

          // Determine post-auth navigation for verified user
          add(DeterminePostAuthNavigation(
            userId: currentUser.uid,
            user: userEntity,
          ));
        }
      } else {
        debugPrint('AuthBloc - No authenticated user found');
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      debugPrint('AuthBloc - Error checking auth status: $e');
      emit(const AuthUnauthenticated());
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
        final userEntity = UserModel(
          id: user.uid,
          email: user.email ?? '',
          isEmailVerified: true,
          createdAt: DateTime.now(),
        ).toUserEntity();

        // Determine post-auth navigation for verified user
        add(DeterminePostAuthNavigation(userId: user.uid, user: userEntity));
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

  Future<void> _onDeterminePostAuthNavigation(
    DeterminePostAuthNavigation event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint(
        'AuthBloc - Determining post-auth navigation for user: ${event.userId}');
    emit(const AuthLoading());

    try {
      // First, check if user has a wallet
      final hasWallet = await _checkWalletExistsUseCase(event.userId);

      if (hasWallet) {
        // User has wallet, go directly to home
        // (if they have wallet, they already accepted terms)
        debugPrint('AuthBloc - User has wallet, navigating to home');
        emit(PostAuthNavigationDetermined(
          route: RouteNames.home2,
          user: event.user,
        ));
      } else {
        // User doesn't have wallet, check terms acceptance
        final termsAccepted = await _checkTermsAcceptanceUseCase();

        if (termsAccepted) {
          // Terms accepted but no wallet, go to wallet setup
          debugPrint(
              'AuthBloc - Terms accepted but no wallet, navigating to wallet setup');
          emit(PostAuthNavigationDetermined(
            route: RouteNames.walletSetup,
            user: event.user,
          ));
        } else {
          // No wallet and no terms accepted, go to terms page
          debugPrint(
              'AuthBloc - No wallet and no terms accepted, navigating to terms');
          emit(PostAuthNavigationDetermined(
            route: RouteNames.termsAndConditions,
            user: event.user,
          ));
        }
      }
    } catch (e) {
      debugPrint('AuthBloc - Error determining navigation: $e');
      // If there's an error, default to terms page for safety
      emit(PostAuthNavigationDetermined(
        route: RouteNames.termsAndConditions,
        user: event.user,
      ));
    }
  }
}
