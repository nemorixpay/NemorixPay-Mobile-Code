import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// KYC Data Layer
import '../../features/kyc/data/datasources/kyc_datasource.dart';
import '../../features/kyc/data/datasources/kyc_datasource_impl.dart';
import '../../features/kyc/data/repositories/kyc_repository_impl.dart';

// KYC Domain Layer
import '../../features/kyc/domain/repositories/kyc_repository.dart';
import '../../features/kyc/domain/usecases/create_kyc_session.dart';
import '../../features/kyc/domain/usecases/get_kyc_status.dart';
import '../../features/kyc/domain/usecases/save_kyc_session.dart';

// KYC Presentation Layer
import '../../features/kyc/presentation/bloc/kyc_bloc.dart';

/// @file        kyc_injection_service.dart
/// @brief       Dependency injection service for KYC feature
/// @details     Registers all KYC-related dependencies with GetIt
/// @author      Miguel Fagundez
/// @date        08/08/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

final di = GetIt.instance;

Future<void> kycInjectionServices() async {
  /// Register data sources
  // HTTP Client
  final http.Client httpClient = di.registerSingleton<http.Client>(
    http.Client(),
  );

  // Secure Storage
  final FlutterSecureStorage secureStorage =
      di.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );

  // KYC DataSource
  final KYCDatasource kycDatasource = di.registerSingleton<KYCDatasource>(
    KYCDatasourceImpl(
      httpClient: httpClient,
      secureStorage: secureStorage,
    ),
  );

  /// Register repositories
  // KYC Repository
  final KYCRepository kycRepository = di.registerSingleton<KYCRepository>(
    KYCRepositoryImpl(
      datasource: kycDatasource,
    ),
  );

  /// Register use cases
  // Create KYC Session
  final CreateKYCSession createKYCSession =
      di.registerSingleton<CreateKYCSession>(
    CreateKYCSession(
      kycRepository,
    ),
  );

  // Get KYC Status
  final GetKYCStatus getKYCStatus = di.registerSingleton<GetKYCStatus>(
    GetKYCStatus(
      kycRepository,
    ),
  );

  // Save KYC Session
  final SaveKYCSession saveKYCSession = di.registerSingleton<SaveKYCSession>(
    SaveKYCSession(
      kycRepository,
    ),
  );

  /// Register BLoCs
  // KYC BLoC
  di.registerFactory<KYCBloc>(
    () => KYCBloc(
      createSession: createKYCSession,
      getStatus: getKYCStatus,
      saveSession: saveKYCSession,
      repository: kycRepository,
    ),
  );
}

/// Unregister all KYC dependencies (for testing)
void unregister() {
  // BLoCs
  di.unregister<KYCBloc>();

  // Use Cases
  di.unregister<CreateKYCSession>();
  di.unregister<GetKYCStatus>();
  di.unregister<SaveKYCSession>();

  // Repositories
  di.unregister<KYCRepository>();

  // DataSources
  di.unregister<KYCDatasource>();
  di.unregister<http.Client>();
  di.unregister<FlutterSecureStorage>();
}
