/// @file        injection_container.dart
/// @brief       Dependency injection container implementation for NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the application.
/// @author      Miguel Fagundez
/// @date        2024-04-24
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Network
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Repositories
  // getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));

  // Use Cases
  // getIt.registerLazySingleton(() => LoginUseCase(getIt()));

  // Blocs
  // getIt.registerFactory(() => AuthBloc(getIt()));
}
