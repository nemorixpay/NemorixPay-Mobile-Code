/// @file        splash_native_page.dart
/// @brief       Native splash screen implementation for NemorixPay.
/// @details     This file contains the UI implementation of the splash screen,
///              including animations, logo display and navigation logic.
/// @author      Miguel Fagundez
/// @date        2025-05-06
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nemorixpay/config/constants/animations_url.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/features/splash/ui/bloc/splash_bloc.dart';
import 'package:nemorixpay/features/splash/ui/bloc/splash_event.dart';
import 'package:nemorixpay/features/splash/ui/bloc/splash_state.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

class SplashNativePage extends StatefulWidget {
  const SplashNativePage({super.key});

  @override
  State<SplashNativePage> createState() => _SplashNativePageState();
}

class _SplashNativePageState extends State<SplashNativePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      context.read<SplashBloc>().add(const SplashInitialized());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        print('SplashState: $state'); // Debug log
        if (state is SplashLoaded) {
          print('Navigating to: ${state.route}'); // Debug log
          Navigator.pushReplacementNamed(context, state.route);
        } else if (state is SplashError) {
          print('Error: ${state.message}'); // Debug log
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Application logo
                Image.asset(ImageUrl.logoMobileImage, width: 150, height: 150),
                const SizedBox(height: 24),
                // Loading animation
                Lottie.asset(AnimationsUrl.loading, width: 150, height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
