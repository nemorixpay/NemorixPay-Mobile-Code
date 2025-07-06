import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/auth/firebase_failure.dart';
import 'package:nemorixpay/features/auth/domain/entities/user_entity.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/check_wallet_exists_usecase.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:nemorixpay/features/terms/domain/usecases/check_terms_acceptance_usecase.dart';
import 'package:nemorixpay/core/services/navigation_service.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([
  SignInUseCase,
  SignUpUseCase,
  ForgotPasswordUseCase,
  SendVerificationEmailUseCase,
  CheckWalletExistsUseCase,
  CheckTermsAcceptanceUseCase,
  NavigationService,
])

/// @file        auth_bloc_test.dart
/// @brief       Tests for the Auth Bloc implementation
/// @details     Verifies the behavior of the Auth Bloc, including authentication,
///              wallet verification, terms acceptance, and error handling.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

void main() {
  late AuthBloc authBloc;
  late MockSignInUseCase mockSignInUseCase;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockForgotPasswordUseCase mockForgotPasswordUseCase;
  late MockSendVerificationEmailUseCase mockSendVerificationEmailUseCase;
  late MockCheckWalletExistsUseCase mockCheckWalletExistsUseCase;
  late MockCheckTermsAcceptanceUseCase mockCheckTermsAcceptanceUseCase;
  late MockNavigationService mockNavigationService;

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    mockForgotPasswordUseCase = MockForgotPasswordUseCase();
    mockSendVerificationEmailUseCase = MockSendVerificationEmailUseCase();
    mockCheckWalletExistsUseCase = MockCheckWalletExistsUseCase();
    mockCheckTermsAcceptanceUseCase = MockCheckTermsAcceptanceUseCase();
    mockNavigationService = MockNavigationService();

    authBloc = AuthBloc(
      signInUseCase: mockSignInUseCase,
      signUpUseCase: mockSignUpUseCase,
      forgotPasswordUseCase: mockForgotPasswordUseCase,
      sendVerificationEmailUseCase: mockSendVerificationEmailUseCase,
      checkWalletExistsUseCase: mockCheckWalletExistsUseCase,
      checkTermsAcceptanceUseCase: mockCheckTermsAcceptanceUseCase,
      navigationService: mockNavigationService,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  test('initial state should be AuthInitial', () {
    expect(authBloc.state, equals(const AuthInitial()));
  });

  group('CheckWalletExists', () {
    const tUserId = 'test_user_id';
    final tUser = UserEntity(
      id: tUserId,
      email: 'test@example.com',
      isEmailVerified: true,
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 2),
    );

    test(
      'should emit [AuthLoading, AuthAuthenticatedWithWallet] when wallet exists',
      () async {
        // arrange
        when(mockCheckWalletExistsUseCase(tUserId))
            .thenAnswer((_) async => true);

        // assert later
        final expected = [
          const AuthLoading(),
          AuthAuthenticatedWithWallet(tUser),
        ];
        expectLater(authBloc.stream, emitsInOrder(expected));

        // act
        authBloc.add(CheckWalletExists(userId: tUserId, user: tUser));
      },
    );

    test(
      'should emit [AuthLoading, AuthAuthenticatedWithoutWallet] when wallet does not exist',
      () async {
        // arrange
        when(mockCheckWalletExistsUseCase(tUserId))
            .thenAnswer((_) async => false);

        // assert later
        final expected = [
          const AuthLoading(),
          AuthAuthenticatedWithoutWallet(tUser),
        ];
        expectLater(authBloc.stream, emitsInOrder(expected));

        // act
        authBloc.add(CheckWalletExists(userId: tUserId, user: tUser));
      },
    );

    test(
      'should emit [AuthLoading, AuthError] when check wallet fails',
      () async {
        // arrange
        when(mockCheckWalletExistsUseCase(tUserId))
            .thenThrow(Exception('Check wallet error'));

        // assert later
        expectLater(
          authBloc.stream,
          emitsInOrder([
            const AuthLoading(),
            predicate<AuthError>((state) =>
                state.error is FirebaseFailure &&
                state.error.message.contains('Check wallet error')),
          ]),
        );

        // act
        authBloc.add(CheckWalletExists(userId: tUserId, user: tUser));
      },
    );
  });

  group('SignInRequested with wallet verification', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tUserId = 'test_user_id';
    final tUser = UserEntity(
      id: tUserId,
      email: tEmail,
      isEmailVerified: true,
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 2),
    );

    test(
      'should emit [AuthLoading, AuthAuthenticatedWithWallet] when sign in succeeds and wallet exists',
      () async {
        // arrange
        when(mockSignInUseCase(tEmail, tPassword))
            .thenAnswer((_) async => Right(tUser));
        when(mockCheckWalletExistsUseCase(tUserId))
            .thenAnswer((_) async => true);

        // assert later
        final expected = [
          const AuthLoading(),
          AuthAuthenticatedWithWallet(tUser),
        ];
        expectLater(authBloc.stream, emitsInOrder(expected));

        // act
        authBloc.add(const SignInRequested(email: tEmail, password: tPassword));
      },
    );

    test(
      'should emit [AuthLoading, AuthAuthenticatedWithoutWallet] when sign in succeeds but wallet does not exist',
      () async {
        // arrange
        when(mockSignInUseCase(tEmail, tPassword))
            .thenAnswer((_) async => Right(tUser));
        when(mockCheckWalletExistsUseCase(tUserId))
            .thenAnswer((_) async => false);

        // assert later
        final expected = [
          const AuthLoading(),
          AuthAuthenticatedWithoutWallet(tUser),
        ];
        expectLater(authBloc.stream, emitsInOrder(expected));

        // act
        authBloc.add(const SignInRequested(email: tEmail, password: tPassword));
      },
    );

    test(
      'should emit [AuthLoading, AuthError, AuthUnauthenticated] when sign in fails',
      () async {
        // arrange
        when(mockSignInUseCase(tEmail, tPassword)).thenAnswer(
            (_) async => Left(FirebaseFailure.invalidEmail('Invalid email')));

        // assert later
        expectLater(
          authBloc.stream,
          emitsInOrder([
            const AuthLoading(),
            predicate<AuthError>((state) =>
                state.error is FirebaseFailure &&
                (state.error as FirebaseFailure).firebaseCode ==
                    'invalid-email'),
            const AuthUnauthenticated(),
          ]),
        );

        // act
        authBloc.add(const SignInRequested(email: tEmail, password: tPassword));
      },
    );

    test(
      'should emit [AuthLoading, AuthError] when sign in succeeds but wallet check fails',
      () async {
        // arrange
        when(mockSignInUseCase(tEmail, tPassword))
            .thenAnswer((_) async => Right(tUser));
        when(mockCheckWalletExistsUseCase(tUserId))
            .thenThrow(Exception('Wallet check error'));

        // assert later
        expectLater(
          authBloc.stream,
          emitsInOrder([
            const AuthLoading(),
            predicate<AuthError>((state) =>
                state.error is FirebaseFailure &&
                state.error.message.contains('Wallet check error')),
          ]),
        );

        // act
        authBloc.add(const SignInRequested(email: tEmail, password: tPassword));
      },
    );
  });
}
