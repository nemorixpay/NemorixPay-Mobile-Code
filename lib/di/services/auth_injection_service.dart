import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:nemorixpay/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:nemorixpay/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/check_wallet_exists_usecase.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/terms/domain/usecases/check_terms_acceptance_usecase.dart';
import 'package:nemorixpay/core/services/navigation_service.dart';

/// @file        auth_injection_service.dart
/// @brief       Dependency injection container implementation for Auth feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the application.
///              Now includes terms acceptance and navigation service integration.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
///
/// @section     Auth Service Initialization
/// The auth service initialization follows this specific order:
/// 1. FirebaseAuthDataSource (Data Source)
/// 2. FirebaseAuthRepository (Repository)
/// 3. SignInUseCase (Use Case)
/// 4. AuthBloc (State Management)
///
/// @section     Dependencies
/// - FirebaseAuthDataSource: Handles direct Firebase Auth operations
/// - FirebaseAuthRepository: Implements AuthRepository interface
/// - SignInUseCase: Contains business logic for sign in
/// - AuthBloc: Manages authentication state
/// - CheckTermsAcceptanceUseCase: Verifies terms acceptance
/// - NavigationService: Handles post-auth navigation logic
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the auth bloc in your widgets:
/// ```dart
/// final authBloc = GetIt.instance.get<AuthBloc>();
/// ```

final di = GetIt.instance;
Future<void> authInjectionServices() async {
  // Defining Auth Datasources
  final FirebaseAuthDataSource firebaseAuthDataSource = di.registerSingleton(
    FirebaseAuthDataSource(),
  );

  // Defining Auth Repositories
  final FirebaseAuthRepository firebaseAuthRepository = di.registerSingleton(
    FirebaseAuthRepository(firebaseAuthDataSource: firebaseAuthDataSource),
  );

  // Defining Auth UseCases
  final SignInUseCase signInUseCase = di.registerSingleton(
    SignInUseCase(authRepository: firebaseAuthRepository),
  );

  final ForgotPasswordUseCase forgotPasswordUseCase = di.registerSingleton(
    ForgotPasswordUseCase(repository: firebaseAuthRepository),
  );

  final SignUpUseCase signUpUseCase = di.registerSingleton(
    SignUpUseCase(authRepository: firebaseAuthRepository),
  );

  final SendVerificationEmailUseCase sendVerificationEmailUseCase =
      di.registerSingleton(
    SendVerificationEmailUseCase(authRepository: firebaseAuthRepository),
  );

  final CheckWalletExistsUseCase checkWalletExistsUseCase = di.get();

  // Get CheckTermsAcceptanceUseCase from terms service
  final CheckTermsAcceptanceUseCase checkTermsAcceptanceUseCase = di.get();

  // Get NavigationService from terms service
  final NavigationService navigationService = di.get();

  // Define Auth Bloc
  di.registerFactory(
    () => AuthBloc(
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
      forgotPasswordUseCase: forgotPasswordUseCase,
      sendVerificationEmailUseCase: sendVerificationEmailUseCase,
      checkWalletExistsUseCase: checkWalletExistsUseCase,
      checkTermsAcceptanceUseCase: checkTermsAcceptanceUseCase,
      navigationService: navigationService,
    ),
  );
}
