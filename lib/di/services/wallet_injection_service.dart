import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/wallet/data/datasources/wallet_datasource_impl.dart';
import 'package:nemorixpay/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/create_wallet.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/get_wallet_balance.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/import_wallet.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/seed_phrase_usecase.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';

/// @file        wallet_injection_service.dart
/// @brief       Dependency injection container implementation for Wallet feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Wallet feature.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.0
/// @copyright   Apache 2.0 License
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the wallet bloc in your widgets:
/// ```dart
/// final walletBloc = GetIt.instance.get<WalletBloc>();
/// ```

final di = GetIt.instance;
Future<void> walletInjectionServices() async {
  // Defining Wallet Datasources
  final WalletDataSourceImpl walletDataSourceImpl = di.registerSingleton(
    WalletDataSourceImpl(stellarDatasource: StellarDataSourceImpl()),
  );

  // Defining Wallet Repositories
  final WalletRepositoryImpl walletRepositoryImpl = di.registerSingleton(
    WalletRepositoryImpl(dataSource: walletDataSourceImpl),
  );

  // Defining Wallet UseCases

  final CreateSeedPhraseUseCase createSeedPhraseUseCase = di.registerSingleton(
    CreateSeedPhraseUseCase(repository: walletRepositoryImpl),
  );

  final CreateWalletUseCase createWalletUseCase = di.registerSingleton(
    CreateWalletUseCase(repository: walletRepositoryImpl),
  );

  final ImportWalletUseCase importWalletUseCase = di.registerSingleton(
    ImportWalletUseCase(repository: walletRepositoryImpl),
  );

  final GetWalletBalanceUseCase getAccountBalanceUseCase = di.registerSingleton(
    GetWalletBalanceUseCase(repository: walletRepositoryImpl),
  );

  // Define Wallet Bloc
  di.registerFactory(
    () => WalletBloc(
      createSeedPhraseUseCase: createSeedPhraseUseCase,
      createWalletUseCase: createWalletUseCase,
      importWalletUseCase: importWalletUseCase,
      getWalletBalanceUseCase: getAccountBalanceUseCase,
    ),
  );
}
