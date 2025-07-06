import 'package:get_it/get_it.dart';
import 'package:nemorixpay/features/terms/data/datasources/terms_local_datasource_impl.dart';
import 'package:nemorixpay/features/terms/data/repositories/terms_repository_impl.dart';
import 'package:nemorixpay/features/terms/domain/usecases/accept_terms.dart';
import 'package:nemorixpay/features/terms/domain/usecases/check_terms_acceptance_usecase.dart'
    show CheckTermsAcceptanceUseCase;
import 'package:nemorixpay/features/terms/domain/usecases/get_terms_content.dart';
import 'package:nemorixpay/features/terms/presentation/bloc/terms_bloc.dart';

/// @file        terms_injection_service.dart
/// @brief       Dependency injection container implementation for Terms and Conditions feature in NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all services, repositories, and use cases for the Terms feature.
/// @author      Miguel Fagundez
/// @date        07/05/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
///
/// @section     Usage
/// This service is automatically initialized by the main injection container.
/// To use the terms bloc in your widgets:
/// ```dart
/// final termsBloc = GetIt.instance.get<TermsBloc>();
/// ```

final di = GetIt.instance;
Future<void> termsInjectionServices() async {
  // Defining Terms Datasources
  final TermsLocalDatasourceImpl termsLocalDatasourceImpl =
      di.registerSingleton(
    TermsLocalDatasourceImpl(),
  );

  // Defining Terms Repositories
  final TermsRepositoryImpl termsRepositoryImpl = di.registerSingleton(
    TermsRepositoryImpl(termsLocalDatasourceImpl),
  );

  // Defining Terms UseCases

  final AcceptTerms acceptTerms = di.registerSingleton(
    AcceptTerms(termsRepositoryImpl),
  );

  di.registerSingleton(
    CheckTermsAcceptanceUseCase(termsLocalDatasourceImpl),
  );

  final GetTermsContent getTermsContent = di.registerSingleton(
    GetTermsContent(termsRepositoryImpl),
  );

  // Define Terms Bloc
  di.registerFactory(
    () => TermsBloc(
      getTermsContent: getTermsContent,
      acceptTerms: acceptTerms,
    ),
  );
}
