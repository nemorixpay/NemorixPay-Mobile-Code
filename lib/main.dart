// Copyright 2025 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/routes/app_routes.dart';
import 'package:nemorixpay/config/theme/nemorix_theme.dart';
import 'package:nemorixpay/di/injection_container.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/splash/presentation/bloc/splash_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Remover la splash nativa cuando la app esté lista
  FlutterNativeSplash.remove();

  // Init Bloc dependencies
  await initInjectionDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
  //   analytics: analytics,
  // );

  @override
  Widget build(BuildContext context) {
    // ---------------------------------------------------
    // Inicializar las dependencias de autenticación
    // final authDataSource = FirebaseAuthDataSource();
    // final authRepository = FirebaseAuthRepository(
    //   firebaseAuthDataSource: authDataSource,
    // );
    // final signInUseCase = SignInUseCase(authRepository: authRepository);
    // Inicializar las dependencias de autenticación
    // ---------------------------------------------------

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (_) => GetIt.instance.get<AuthBloc>()),
        // BlocProvider(
        //   create: (context) => AuthBloc(signInUseCase: signInUseCase),
        // ),
      ],
      child: MaterialApp(
        title: 'NemorixPay',
        debugShowCheckedModeBanner: false,
        theme: NemorixTheme.darkThemeMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        initialRoute: RouteNames.splashNative,
        routes: AppRoutes.getAppRoutes(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        // navigatorObservers: <NavigatorObserver>[observer],
      ),
    );
  }
}
