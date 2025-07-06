import 'package:get_it/get_it.dart';
import 'package:nemorixpay/core/services/navigation_service.dart';
import 'package:nemorixpay/features/auth/domain/usecases/check_wallet_exists_usecase.dart';
import 'package:nemorixpay/features/terms/domain/usecases/check_terms_acceptance_usecase.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';

/// @file        navigationn_service.dart
/// @brief       Dependency injection container implementation for initial Navigation in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Initial navigation Service.
/// @author      Miguel Fagundez
/// @date        07/05/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

final di = GetIt.instance;
Future<void> navigationServices() async {
  // Datasources
  final StellarSecureStorageDataSource stellarSecureStorageDataSource =
      di.registerSingleton(
    StellarSecureStorageDataSource(),
  );

  // Defining Navigation Service UseCases
  final CheckTermsAcceptanceUseCase checkTermsAcceptanceUseCase = di.get();

  final CheckWalletExistsUseCase checkWalletExistsUseCase =
      di.registerSingleton(
    CheckWalletExistsUseCase(stellarSecureStorageDataSource),
  );

  // Define Navigation Service
  di.registerFactory(
    () => NavigationService(
      checkTermsAcceptanceUseCase: checkTermsAcceptanceUseCase,
      checkWalletExistsUseCase: checkWalletExistsUseCase,
    ),
  );
}
