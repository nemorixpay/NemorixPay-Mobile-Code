import 'package:nemorixpay/di/services/auth_injection_service.dart';
import 'package:nemorixpay/di/services/crypto_market_injection_service.dart';
import 'package:nemorixpay/di/services/stellar_injection_service.dart';
import 'package:nemorixpay/di/services/wallet_injection_service.dart';
import 'package:nemorixpay/di/services/onboarding_injection_service.dart';

/// @file        injection_container.dart
/// @brief       Dependency injection container implementation for NemorixPay.
/// @details     This file contains the dependency injection setup using get_it,
///              registering all app services, such as Auth, UI, and other services.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.0
/// @copyright   Apache 2.0 License
///
/// @section     Initialization Order
/// The initialization order is crucial for proper dependency injection:
/// 1. Data Sources (Firebase, APIs, etc.)
/// 2. Repositories (Implementation of domain interfaces)
/// 3. Use Cases (Business logic)
/// 4. BLoCs (State management)
///
/// @section     Service Registration
/// Services are registered in the following order:
/// 1. External Services (Firebase, Analytics, etc.)
/// 2. Data Sources
/// 3. Repositories
/// 4. Use Cases
/// 5. BLoCs
///
/// @section     Usage
/// ```dart
/// void main() async {
///   await initInjectionDependencies();
///   runApp(MyApp());
/// }
/// ```
Future<void> initInjectionDependencies() async {
  // Define all services
  // Authentication
  await authInjectionServices();
  // Stellar
  await stellarInjectionServices();
  // Wallet
  await walletInjectionServices();
  // CryptoMarket
  await cryptoMarketInjectionServices();
  // Onboarding
  await onboardingInjectionServices();
}
