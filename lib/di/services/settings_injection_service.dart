import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/settings/data/datasources/settings_local_datasource_impl.dart';
import 'package:nemorixpay/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:nemorixpay/features/settings/domain/usecases/get_dark_mode_preference.dart';
import 'package:nemorixpay/features/settings/domain/usecases/toggle_dark_mode_usecase.dart';
import 'package:nemorixpay/features/settings/presentation/bloc/settings_bloc.dart';

/// @file        settings_injection_service.dart
/// @brief       Dependency injection container implementation for Settings feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Settings feature.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the settings bloc in the widgets:
/// ```dart
/// final settingsBloc = GetIt.instance.get<SettingsBloc>();
/// ```

final di = GetIt.instance;
Future<void> settingsInjectionServices() async {
  // Defining Settings Datasources
  final SettingsLocalDatasourceImpl settingsLocalDatasourceImpl =
      di.registerSingleton(
    SettingsLocalDatasourceImpl(),
  );

  // Defining Settings Repositories
  final SettingsRepositoryImpl settingsRepositoryImpl = di.registerSingleton(
    SettingsRepositoryImpl(settingsLocalDatasourceImpl),
  );

  // Defining Settings UseCases
  final GetDarkModePreference getDarkModePreference = di.registerSingleton(
    GetDarkModePreference(settingsRepositoryImpl),
  );

  final ToggleDarkModeUseCase toggleDarkModeUseCase = di.registerSingleton(
    ToggleDarkModeUseCase(settingsRepositoryImpl),
  );

  // Define Settings Bloc
  di.registerFactory(
    () => SettingsBloc(
      getDarkModePreference: getDarkModePreference,
      toggleDarkModeUseCase: toggleDarkModeUseCase,
    ),
  );
}
