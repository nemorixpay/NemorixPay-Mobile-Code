import 'package:get_it/get_it.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart';
import 'package:nemorixpay/shared/stellar/data/repositories/stellar_repository_impl.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/create_account_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/generate_mnemonic_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/get_account_balance_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/import_account_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/send_payment_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/validate_transaction_usecase.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_bloc.dart';

/// @file        stellar_injection_service.dart
/// @brief       Dependency injection container implementation for Stellar feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Stellar feature.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License
///
/// @section     Stellar Service Initialization
/// The stellar service initialization follows this specific order:
/// 1. StellarDatasource (Data Source)
/// 2. StellarRepositoryImpl (Repository)
/// 3. Use Cases (GenerateMnemonic, CreateAccount, etc.)
/// 4. StellarBloc (State Management)
///
/// @section     Dependencies
/// - StellarDatasource: Handles direct Stellar operations
/// - StellarRepositoryImpl: Implements StellarRepository interface
/// - Use Cases: Contains business logic for Stellar operations
/// - StellarBloc: Manages Stellar state
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the stellar bloc in your widgets:
/// ```dart
/// final stellarBloc = GetIt.instance.get<StellarBloc>();
/// ```

final di = GetIt.instance;
Future<void> stellarInjectionServices() async {
  // Defining Stellar Datasources
  final StellarDatasource stellarDatasource = di.registerSingleton(
    StellarDatasource(),
  );

  // Defining Stellar Repositories
  final StellarRepositoryImpl stellarRepository = di.registerSingleton(
    StellarRepositoryImpl(datasource: stellarDatasource),
  );

  // Defining Stellar UseCases
  final GenerateMnemonicUseCase generateMnemonicUseCase = di.registerSingleton(
    GenerateMnemonicUseCase(repository: stellarRepository),
  );

  final CreateAccountUseCase createAccountUseCase = di.registerSingleton(
    CreateAccountUseCase(repository: stellarRepository),
  );

  final GetAccountBalanceUseCase getAccountBalanceUseCase = di
      .registerSingleton(
        GetAccountBalanceUseCase(repository: stellarRepository),
      );

  final SendPaymentUseCase sendPaymentUseCase = di.registerSingleton(
    SendPaymentUseCase(repository: stellarRepository),
  );

  final ValidateTransactionUseCase validateTransactionUseCase = di
      .registerSingleton(
        ValidateTransactionUseCase(repository: stellarRepository),
      );

  final ImportAccountUseCase importAccountUseCase = di.registerSingleton(
    ImportAccountUseCase(repository: stellarRepository),
  );

  // Define Stellar Bloc
  di.registerFactory(
    () => StellarBloc(
      generateMnemonicUseCase: generateMnemonicUseCase,
      createAccountUseCase: createAccountUseCase,
      getAccountBalanceUseCase: getAccountBalanceUseCase,
      sendPaymentUseCase: sendPaymentUseCase,
      validateTransactionUseCase: validateTransactionUseCase,
      importAccountUseCase: importAccountUseCase,
    ),
  );
}
