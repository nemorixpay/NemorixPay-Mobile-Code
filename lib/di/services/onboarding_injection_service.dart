import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nemorixpay/features/onboarding/data/datasources/onboarding_local_datasource_impl.dart';
import 'package:nemorixpay/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:nemorixpay/features/onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'package:nemorixpay/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:nemorixpay/features/onboarding/domain/usecases/get_language_usecase.dart';
import 'package:nemorixpay/features/onboarding/domain/usecases/save_language_usecase.dart';
import 'package:nemorixpay/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_bloc.dart';

/// @file        onboarding_injection_service.dart
/// @brief       Dependency injection container implementation for Onboarding feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Onboarding feature.
/// @author      Miguel Fagundez
/// @date        01/18/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the onboarding bloc in the widgets:
/// ```dart
/// final onboardingBloc = GetIt.instance.get<OnboardingBloc>();
/// ```

final di = GetIt.instance;
Future<void> onboardingInjectionServices() async {
  // SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();

  // Defining Onboarding Datasources
  final OnboardingLocalDatasourceImpl onboardingLocalDatasourceImpl =
      di.registerSingleton(
    OnboardingLocalDatasourceImpl(prefs),
  );

  // Defining Onboarding Repositories
  final OnboardingRepositoryImpl onboardingRepositoryImpl =
      di.registerSingleton(
    OnboardingRepositoryImpl(onboardingLocalDatasourceImpl),
  );

  // Defining Onboarding UseCases
  final SaveLanguageUsecase saveLanguageUsecase = di.registerSingleton(
    SaveLanguageUsecase(onboardingRepositoryImpl),
  );

  final GetLanguageUsecase getLanguageUsecase = di.registerSingleton(
    GetLanguageUsecase(onboardingRepositoryImpl),
  );

  final CompleteOnboardingUsecase completeOnboardingUsecase =
      di.registerSingleton(
    CompleteOnboardingUsecase(onboardingRepositoryImpl),
  );

  final CheckOnboardingStatusUsecase checkOnboardingStatusUsecase =
      di.registerSingleton(
    CheckOnboardingStatusUsecase(onboardingRepositoryImpl),
  );

  // Define Onboarding Bloc
  di.registerFactory(
    () => OnboardingBloc(
      saveLanguage: saveLanguageUsecase,
      getLanguage: getLanguageUsecase,
      completeOnboarding: completeOnboardingUsecase,
      checkOnboardingStatus: checkOnboardingStatusUsecase,
    ),
  );

  // Define Splash Bloc
  di.registerFactory(
    () => SplashBloc(
      checkOnboardingStatus: checkOnboardingStatusUsecase,
    ),
  );
}
