import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/crypto/data/datasources/crypto_datasource_impl.dart';
import 'package:nemorixpay/features/crypto/data/repositories/crypto_repository_impl.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_list_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/update_crypto_price_usecase.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_bloc.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';

/// @file        crypto_injection_service.dart
/// @brief       Dependency injection container implementation for Crypto feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Crypto feature.
/// @author      Miguel Fagundez
/// @date        2025-05-27
/// @version     1.0
/// @copyright   Apache 2.0 License
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the asset bloc in your widgets:
/// ```dart
/// final cryptoBloc = GetIt.instance.get<CryptoBloc>();
/// ```

final di = GetIt.instance;
Future<void> cryptoInjectionServices() async {
  // Defining Asset Datasources
  final CryptoDataSourceImpl cryptoDataSourceImpl = di.registerSingleton(
    CryptoDataSourceImpl(stellarDataSource: StellarDataSourceImpl()),
  );

  // Defining Crypto Repositories
  final CryptoRepositoryImpl cryptoRepositoryImpl = di.registerSingleton(
    CryptoRepositoryImpl(cryptoDataSourceImpl),
  );

  // Defining Crypto UseCases
  final GetCryptoListUseCase getCryptoListUseCase = di.registerSingleton(
    GetCryptoListUseCase(repository: cryptoRepositoryImpl),
  );

  final UpdateCryptoPriceUseCase updateCryptoPriceUseCase = di
      .registerSingleton(
        UpdateCryptoPriceUseCase(repository: cryptoRepositoryImpl),
      );

  // Define Crypto Bloc
  di.registerFactory(
    () => CryptoBloc(
      updateCryptoPriceUseCase: updateCryptoPriceUseCase,
      getCryptoListUseCase: getCryptoListUseCase,
    ),
  );
}
