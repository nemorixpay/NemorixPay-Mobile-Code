// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import '../../features/terms/domain/usecases/check_terms_acceptance_usecase.dart';
import '../../features/auth/domain/usecases/check_wallet_exists_usecase.dart';

/// @file        navigation_service.dart
/// @brief       Service to handle post-authentication navigation logic.
/// @details     Determines the correct page to navigate to after authentication
///              based on wallet existence and terms acceptance status.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class NavigationService {
  final CheckTermsAcceptanceUseCase _checkTermsAcceptanceUseCase;
  final CheckWalletExistsUseCase _checkWalletExistsUseCase;

  NavigationService({
    required CheckTermsAcceptanceUseCase checkTermsAcceptanceUseCase,
    required CheckWalletExistsUseCase checkWalletExistsUseCase,
  })  : _checkTermsAcceptanceUseCase = checkTermsAcceptanceUseCase,
        _checkWalletExistsUseCase = checkWalletExistsUseCase;

  /// Determines the correct page to navigate to after authentication
  /// [userId] - The user ID to check for wallet existence
  /// Returns the route name based on wallet and terms status
  Future<String> getPostAuthNavigationRoute(String userId) async {
    try {
      // First, check if user has a wallet
      final hasWallet = await _checkWalletExistsUseCase(userId);

      if (hasWallet) {
        // User has wallet, go directly to home
        // (if they have wallet, they already accepted terms)
        return RouteNames.home2;
      } else {
        // User doesn't have wallet, check terms acceptance
        final termsAccepted = await _checkTermsAcceptanceUseCase();

        if (termsAccepted) {
          // Terms accepted but no wallet, go to wallet setup
          return RouteNames.walletSetup;
        } else {
          // No wallet and no terms accepted, go to terms page
          return RouteNames.termsAndConditions;
        }
      }
    } catch (e) {
      // If there's an error, default to terms page for safety
      return RouteNames.termsAndConditions;
    }
  }

  /// Navigates to the appropriate page after authentication
  /// [context] - The build context for navigation
  /// [userId] - The user ID to check for wallet existence
  /// [replace] - Whether to replace the current route (default: true)
  Future<void> navigateAfterAuth(
    BuildContext context,
    String userId, {
    bool replace = true,
  }) async {
    try {
      final route = await getPostAuthNavigationRoute(userId);

      if (replace) {
        Navigator.of(context).pushReplacementNamed(route);
      } else {
        Navigator.of(context).pushNamed(route);
      }
    } catch (e) {
      // Fallback navigation to terms page
      if (replace) {
        Navigator.of(context)
            .pushReplacementNamed(RouteNames.termsAndConditions);
      } else {
        Navigator.of(context).pushNamed(RouteNames.termsAndConditions);
      }
    }
  }
}
