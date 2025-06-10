import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_account_assets_usecase.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_bloc.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_all_available_assets/crypto_market_bloc.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_market_data_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_assets_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/update_market_data_usecase.dart';
import 'package:nemorixpay/features/crypto/data/datasources/crypto_market_datasource_impl.dart';
import 'package:nemorixpay/features/crypto/data/repositories/crypto_market_repository_impl.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_asset_details_usecase.dart';

/// @file        crypto_market_injection_service.dart
/// @brief       Dependency injection container implementation for CryptoMarket feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Crypto feature.
/// @author      Miguel Fagundez
/// @date        2025-06-07
/// @version     1.0
/// @copyright   Apache 2.0 License
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the bloc:
/// ```dart
/// final cryptoMarketBloc = GetIt.instance.get<CryptoMarketBloc>();
/// ```

final di = GetIt.instance;
Future<void> cryptoMarketInjectionServices() async {
  // Defining CryptoMarket Datasources
  final CryptoMarketDataSourceImpl cryptoMarketDataSourceImpl = di
      .registerSingleton(
        CryptoMarketDataSourceImpl(assetCacheManager: AssetCacheManager()),
      );

  // Defining CryptoMarket Repositories
  final CryptoMarketRepositoryImpl cryptoMarketRepositoryImpl = di
      .registerSingleton(
        CryptoMarketRepositoryImpl(cryptoMarketDataSourceImpl),
      );

  // Defining CryptoMarket UseCases
  final GetCryptoAssetDetailsUseCase getCryptoAssetDetailsUseCase = di
      .registerSingleton(
        GetCryptoAssetDetailsUseCase(repository: cryptoMarketRepositoryImpl),
      );

  final GetCryptoAssetsUseCase getCryptoAssetsUseCase = di.registerSingleton(
    GetCryptoAssetsUseCase(repository: cryptoMarketRepositoryImpl),
  );

  final GetCryptoAccountAssetsUseCase getCryptoAccountAssetsUseCase = di
      .registerSingleton(
        GetCryptoAccountAssetsUseCase(repository: cryptoMarketRepositoryImpl),
      );

  final GetMarketDataUseCase getMarketDataUseCase = di.registerSingleton(
    GetMarketDataUseCase(repository: cryptoMarketRepositoryImpl),
  );

  final UpdateMarketDataUseCase updateMarketDataUseCase = di.registerSingleton(
    UpdateMarketDataUseCase(repository: cryptoMarketRepositoryImpl),
  );

  // Define CryptoMarket Bloc
  di.registerFactory(
    () => CryptoMarketBloc(
      getCryptoAssetsUseCase: getCryptoAssetsUseCase,
      getCryptoAssetDetailsUseCase: getCryptoAssetDetailsUseCase,
      getMarketDataUseCase: getMarketDataUseCase,
      updateMarketDataUseCase: updateMarketDataUseCase,
    ),
  );

  // Define CryptoAccount Bloc
  di.registerFactory(
    () => CryptoAccountBloc(
      getCryptoAssetDetailsUseCase: getCryptoAssetDetailsUseCase,
      getCryptoAccountAssetsUseCase: getCryptoAccountAssetsUseCase,
    ),
  );

  // Define CryptoHome Bloc
  di.registerFactory(
    () => CryptoHomeBloc(
      marketBloc: GetIt.instance.get<CryptoMarketBloc>(),
      accountBloc: GetIt.instance.get<CryptoAccountBloc>(),
    ),
  );
}
