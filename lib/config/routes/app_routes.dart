// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:nemorixpay/config/routes/route_model.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/auth/ui/pages/sign_in_page.dart';
import 'package:nemorixpay/features/auth/ui/pages/sign_up_page.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/pages/buy_crypto_page.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/pages/payment_method_page.dart';
import 'package:nemorixpay/features/splash/ui/pages/splash_page.dart';
import 'package:nemorixpay/features/wallet/ui/pages/confirm_seed_phrase_page.dart';
import 'package:nemorixpay/features/wallet/ui/pages/import_seed_phrase_page.dart';
import 'package:nemorixpay/features/wallet/ui/pages/show_seed_phrase_page.dart';
import 'package:nemorixpay/features/wallet/ui/pages/wallet_setup_page.dart';
import 'package:nemorixpay/shared/ui/pages/test_page/test_home_page.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/pages/home_page.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/pages/crypto_details.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/crypto_entity.dart';
import 'package:nemorixpay/shared/ui/widgets/nemorix_snackbar.dart';

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
  static const initialRoute = RouteNames.splash;

  /// Firebase Analytics instance for tracking navigation events
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  /// Firebase Analytics Observer to automatically track screen views
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  /// List of all available routes in the application
  /// Each route is defined with its name, screen, and icon
  static final routeOptions = <RouteModel>[
    RouteModel(
      route: RouteNames.splash,
      name: 'Splash',
      screen: const SplashPage(),
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
      route: RouteNames.home,
      name: 'Home',
      screen: const HomePage(),
      icon: Icons.home,
    ),
    RouteModel(
      route: RouteNames.homeAnalytics,
      name: 'Analytics',
      screen: MyHomePage(
        title: 'Firebase Analytics Demo',
        analytics: analytics,
        observer: observer,
      ),
      icon: Icons.account_balance_wallet_outlined,
    ),
    RouteModel(
      route: RouteNames.buyCrypto,
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
  /// It handles special cases like [cryptoDetails] and [paymentMethod] routes
  /// that require specific arguments to be passed.
  ///
  /// @param settings The route settings containing the route name and arguments
  /// @return A MaterialPageRoute for the requested screen
  /// @throws TypeError if the arguments are not of the expected type
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.cryptoDetails:
        final crypto = settings.arguments as CryptoEntity;
        return MaterialPageRoute(
          builder: (context) => CryptoDetailsPage(crypto: crypto),
        );
      case RouteNames.paymentMethod:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (context) => PaymentMethodPage(
                cryptoName: args['cryptoName'] as String,
                amount: args['amount'] as double,
                currency: args['currency'] as String,
              ),
        );
      case RouteNames.showSeedPhrase:
        final args = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (context) => ShowSeedPhrasePage(seedPhrase: args),
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
