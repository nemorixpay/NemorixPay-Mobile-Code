import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:nemorixpay/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:nemorixpay/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:nemorixpay/features/auth/domain/usecases/check_wallet_exists_usecase.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';

/// @file        auth_injection_service.dart
/// @brief       Dependency injection container implementation for Auth feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the application.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.0
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

  final CheckWalletExistsUseCase checkWalletExistsUseCase =
      di.registerSingleton(
    CheckWalletExistsUseCase(
      StellarSecureStorageDataSource(),
    ),
  );

  // Define Auth Bloc
  di.registerFactory(
    () => AuthBloc(
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
      forgotPasswordUseCase: forgotPasswordUseCase,
      sendVerificationEmailUseCase: sendVerificationEmailUseCase,
      checkWalletExistsUseCase: checkWalletExistsUseCase,
    ),
  );
}
