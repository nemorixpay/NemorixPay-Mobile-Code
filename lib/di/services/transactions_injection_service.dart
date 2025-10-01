import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/transactions/data/datasources/transactions_datasource.dart';
import 'package:nemorixpay/features/transactions/data/datasources/transactions_datasource_impl.dart';
import 'package:nemorixpay/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:nemorixpay/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:nemorixpay/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:nemorixpay/features/transactions/domain/usecases/refresh_transactions_usecase.dart';
import 'package:nemorixpay/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:nemorixpay/shared/stellar/data/repositories/stellar_repository_impl.dart';
import 'package:nemorixpay/shared/stellar/domain/repositories/stellar_repository.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';

/// @file        transactions_injection_service.dart
/// @brief       Dependency injection service for Transactions feature
/// @details     Registers all dependencies needed for the Transactions feature
/// @author      Miguel Fagundez
/// @date        09/12/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

final di = GetIt.instance;

/// Registers all Transactions feature dependencies
Future<void> transactionsInjectionServices() async {
  // Defining Transactions Datasources
  final TransactionsDatasourceImpl transactionsDatasourceImpl =
      di.registerSingleton(
    TransactionsDatasourceImpl(
      stellarRepository: di<StellarRepositoryImpl>(),
      //accountProvider: di<StellarAccountProvider>(),
    ),
  );

  // Defining Transactions Repositories
  final TransactionsRepositoryImpl transactionsRepository =
      di.registerSingleton(
    TransactionsRepositoryImpl(datasource: transactionsDatasourceImpl),
  );

  // Defining Transactions UseCases
  final GetTransactionsUseCase getTransactionsUseCase = di.registerSingleton(
    GetTransactionsUseCase(transactionsRepository),
  );

  final RefreshTransactionsUseCase refreshTransactionsUseCase =
      di.registerSingleton(
    RefreshTransactionsUseCase(transactionsRepository),
  );

  // Register BLoC
  di.registerFactory<TransactionsBloc>(
    () => TransactionsBloc(
      getTransactionsUseCase: getTransactionsUseCase,
      refreshTransactionsUseCase: refreshTransactionsUseCase,
    ),
  );
}
