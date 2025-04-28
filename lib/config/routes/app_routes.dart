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
import 'package:nemorixpay/shared/ui/pages/test_page/test_home_page.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/pages/home_page.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/pages/crypto_details.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/crypto_entity.dart';

class AppRoutes {
  static const initialRoute = RouteNames.splash;

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

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
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (final option in routeOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

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
      default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }
}
