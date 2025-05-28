import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/asset/data/datasources/asset_datasource_impl.dart';
import 'package:nemorixpay/features/asset/data/repositories/asset_repository_impl.dart';
import 'package:nemorixpay/features/asset/domain/usecases/get_assets_list_usecase.dart';
import 'package:nemorixpay/features/asset/domain/usecases/update_asset_price_usecase.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';

/// @file        asset_injection_service.dart
/// @brief       Dependency injection container implementation for Asset feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Asset feature.
/// @author      Miguel Fagundez
/// @date        2025-05-27
/// @version     1.0
/// @copyright   Apache 2.0 License
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the asset bloc in your widgets:
/// ```dart
/// final assetBloc = GetIt.instance.get<AssetBloc>();
/// ```

final di = GetIt.instance;
Future<void> assetInjectionServices() async {
  // Defining Asset Datasources
  final AssetDataSourceImpl assetDataSourceImpl = di.registerSingleton(
    AssetDataSourceImpl(stellarDataSource: StellarDataSourceImpl()),
  );

  // Defining Asset Repositories
  final AssetRepositoryImpl assetRepositoryImpl = di.registerSingleton(
    AssetRepositoryImpl(assetDataSourceImpl),
  );

  // Defining Asset UseCases
  final GetAssetsListUseCase getAssetsListUseCase = di.registerSingleton(
    GetAssetsListUseCase(repository: assetRepositoryImpl),
  );

  final UpdateAssetPriceUseCase updateAssetPriceUseCase = di.registerSingleton(
    UpdateAssetPriceUseCase(repository: assetRepositoryImpl),
  );

  // Define Asset Bloc
  di.registerFactory(
    () => AssetBloc(
      updateAssetPriceUseCase: updateAssetPriceUseCase,
      getAssetsListUseCase: getAssetsListUseCase,
    ),
  );
}
