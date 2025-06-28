// Copyright 2025 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/routes/app_routes.dart';
import 'package:nemorixpay/config/theme/nemorix_theme.dart';
import 'package:nemorixpay/di/injection_container.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_bloc.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_all_available_assets/crypto_market_bloc.dart';
import 'package:nemorixpay/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_state.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_bloc.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:nemorixpay/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'firebase_options.dart';

/// Global key for accessing the ScaffoldMessenger from anywhere in the app
final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Remover la splash nativa cuando la app esté lista
  FlutterNativeSplash.remove();

  // Init Bloc dependencies
  await initInjectionDependencies();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _currentLanguage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.instance.get<SplashBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<AuthBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<StellarBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<WalletBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<CryptoMarketBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<CryptoAccountBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<CryptoHomeBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<OnboardingBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashLoaded) {
                debugPrint('MyApp: Splash loaded, triggering onboarding check');
                // Trigger onboarding check when splash is loaded
                context.read<OnboardingBloc>().add(CheckOnboardingStatus());
              }
            },
          ),
          BlocListener<OnboardingBloc, OnboardingState>(
            listener: (context, state) {
              if (state is LanguageSelection) {
                setState(() {
                  _currentLanguage = state.currentLanguage;
                });
                debugPrint(
                    'LanguageSelection (main.dart): ${state.currentLanguage}');
              } else if (state is OnboardingInProgress) {
                setState(() {
                  _currentLanguage = state.currentLanguage;
                });
                debugPrint(
                    'OnboardingInProgress (main.dart): ${state.currentLanguage}');
              } else if (state is OnboardingCompleted) {
                setState(() {
                  _currentLanguage = state.selectedLanguage;
                });
                debugPrint(
                    'OnboardingCompleted (main.dart): ${state.selectedLanguage}');
              } else if (state is OnboardingAlreadyCompleted) {
                if (state.selectedLanguage != null) {
                  setState(() {
                    _currentLanguage = state.selectedLanguage;
                  });
                  debugPrint(
                      'OnboardingAlreadyCompleted (main.dart): ${state.selectedLanguage}');
                } else {
                  debugPrint(
                      'OnboardingAlreadyCompleted (main.dart): no language saved');
                }
              } else {
                debugPrint('Another state (main.dart): ${state.toString()}');
              }
            },
          ),
        ],
        child: MaterialApp(
          title: 'NemorixPay',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldKey,
          theme: NemorixTheme.darkThemeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(_currentLanguage ?? 'en'),
          initialRoute: RouteNames.splashNative,
          routes: AppRoutes.getAppRoutes(),
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
