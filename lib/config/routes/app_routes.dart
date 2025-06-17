// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:nemorixpay/config/routes/route_model.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/auth/presentation/pages/sign_in_page.dart';
import 'package:nemorixpay/features/auth/presentation/pages/sign_up_page.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/presentation/pages/buy_crypto_page.dart';
import 'package:nemorixpay/features/crypto/presentation/pages/home_page.dart';
import 'package:nemorixpay/features/crypto/presentation/pages/payment_method_page.dart';
import 'package:nemorixpay/features/onboarding/presentation/pages/features_slide.dart';
import 'package:nemorixpay/features/onboarding/presentation/pages/security_slide.dart';
import 'package:nemorixpay/features/splash/presentation/pages/splash_native_page.dart';
import 'package:nemorixpay/features/splash/presentation/pages/splash_test_page.dart';
import 'package:nemorixpay/features/terms/presentation/pages/terms_page.dart';
import 'package:nemorixpay/features/wallet/presentation/pages/confirm_seed_phrase_page.dart';
import 'package:nemorixpay/features/wallet/presentation/pages/import_seed_phrase_page.dart';
import 'package:nemorixpay/features/wallet/presentation/pages/show_seed_phrase_page.dart';
import 'package:nemorixpay/features/wallet/presentation/pages/stellar_service_test_page.dart';
import 'package:nemorixpay/features/wallet/presentation/pages/wallet_setup_page.dart';
import 'package:nemorixpay/features/crypto/presentation/pages/crypto_details.dart';
import 'package:nemorixpay/features/wallet/presentation/pages/wallet_success_page.dart';
import 'package:nemorixpay/shared/stellar/presentation/pages/test_transactions_page.dart';

/// @file        app_routes.dart
/// @brief       Centralized route management for NemorixPay.
/// @details     This class handles all navigation logic, route generation,
///             and analytics tracking for the application.
/// @author      Miguel Fagundez
/// @date        2025-04-28
/// @version     1.0
/// @copyright   Apache 2.0 License
class AppRoutes {
  /// The initial route when the app starts
  static const initialRoute = RouteNames.splashNative;

  // /// Firebase Analytics instance for tracking navigation events
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // /// Firebase Analytics Observer to automatically track screen views
  // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
  //   analytics: analytics,
  // );

  /// List of all available routes in the application
  /// Each route is defined with its name, screen, and icon
  static final routeOptions = <RouteModel>[
    RouteModel(
      route: RouteNames.splashTest,
      name: 'Splash',
      screen: const SplashTestPage(),
      icon: Icons.account_balance_wallet_outlined,
    ),
    RouteModel(
      route: RouteNames.splashNative,
      name: 'Splash Native',
      screen: const SplashNativePage(),
      icon: Icons.account_balance_wallet_outlined,
    ),
    RouteModel(
      route: RouteNames.signIn,
      name: 'Sign In',
      screen: const LoginPage(),
      icon: Icons.login_outlined,
    ),
    RouteModel(
      route: RouteNames.signUp,
      name: 'Sign Up',
      screen: const SignUpPage(),
      icon: Icons.app_registration,
    ),
    RouteModel(
      route: RouteNames.home2,
      name: 'Home2',
      screen: const HomePage(),
      icon: Icons.home,
    ),
    RouteModel(
      route: RouteNames.buyAsset,
      name: 'Buy',
      screen: BuyCryptoPage(),
      icon: Icons.credit_card_rounded,
    ),
    RouteModel(
      route: RouteNames.walletSetup,
      name: 'Wallet Setup',
      screen: WalletSetupPage(),
      icon: Icons.wallet_outlined,
    ),
    RouteModel(
      route: RouteNames.importSeedPhrase,
      name: 'ImportSeed Phrase',
      screen: ImportSeedPhrasePage(),
      icon: Icons.import_export,
    ),
    RouteModel(
      route: RouteNames.testingPage,
      name: 'Testing Page',
      screen: StellarServiceTestPage(),
      icon: Icons.import_export,
    ),
    RouteModel(
      route: RouteNames.testTransactions,
      name: 'Test Transactions',
      screen: const TestTransactionsPage(),
      icon: Icons.list_alt,
    ),
    RouteModel(
      route: RouteNames.termsAndConditions,
      name: 'Test Terms and Conditions',
      screen: const TermsPage(),
      icon: Icons.list_alt,
    ),
    RouteModel(
      route: RouteNames.onboardingPageSecurity,
      name: 'Onboarding Security',
      screen: SecuritySlide(
        onNext: () {},
        onSkip: () {},
      ),
      icon: Icons.lock,
    ),
    RouteModel(
      route: RouteNames.onboardingPageFeatures,
      name: 'Onboarding Features',
      screen: FeaturesSlide(
        onNext: () {},
        onSkip: () {},
      ),
      icon: Icons.lock,
    ),
  ];

  /// Generates a map of all available routes for the MaterialApp
  ///
  /// This method converts the [routeOptions] list into a map that can be used
  /// by the MaterialApp's routes parameter. Each route is mapped to its
  /// corresponding screen widget.
  ///
  /// @return A map of route names to their corresponding screen builders
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (final option in routeOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  /// Handles dynamic route generation with arguments
  ///
  /// This method is called when a named route is requested with arguments.
  /// It handles special cases like [assetDetails] and [paymentMethod] routes
  /// that require specific arguments to be passed.
  ///
  /// @param settings The route settings containing the route name and arguments
  /// @return A MaterialPageRoute for the requested screen
  /// @throws TypeError if the arguments are not of the expected type
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.assetDetails:
        final cryptoArg = settings.arguments as CryptoAssetWithMarketData;
        return MaterialPageRoute(
          builder: (context) => CryptoDetailsPage(crypto: cryptoArg),
        );
      case RouteNames.paymentMethod:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => PaymentMethodPage(
            cryptoName: args['assetName'] as String,
            amount: args['amount'] as double,
            currency: args['currency'] as String,
          ),
        );
      case RouteNames.showSeedPhrase:
        final args = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (context) => ShowSeedPhrasePage(seedPhrase: args),
        );
      case RouteNames.successWalletCreation:
        final title = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => WalletSuccessPage(titleSuccess: title),
        );
      case RouteNames.confirmSeedPhrase:
        final args = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (context) => ConfirmSeedPhrasePage(seedPhrase: args),
        );
      //   ConfirmSeedPhrasePage(
      //      seedPhrase: mySeedPhrase,
      //      onSuccess: () {
      //       // Navegar a la pantalla principal
      //        Navigator.pushReplacementNamed(context, '/walletHome');
      //      },
      //      onFail: () {
      //        // Mostrar alerta
      //        showDialog(...);
      //      },
      //    )
      default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }
}
