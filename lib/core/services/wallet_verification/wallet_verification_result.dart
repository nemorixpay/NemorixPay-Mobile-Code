import 'package:nemorixpay/config/routes/route_names.dart';

/// @file        wallet_verification_result.dart
/// @brief       Models for wallet verification results and status.
/// @details     This file contains the WalletVerificationResult model and
///              WalletVerificationStatus enum used by the WalletVerificationService
///              to determine the user's wallet state and navigation flow.
/// @author      Miguel Fagundez
/// @date        06/21/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

/// States of wallet verification
enum WalletVerificationStatus {
  /// User has wallet configured → go to Home
  hasWallet,

  /// User has no wallet → go to Wallet Setup (Create or Import)
  noWallet,
}

/// Result of wallet verification process
class WalletVerificationResult {
  /// Current verification status
  final WalletVerificationStatus status;

  /// Public key if wallet exists
  final String? publicKey;

  /// Route to navigate to
  final String route;

  /// Additional message for user
  final String? message;

  const WalletVerificationResult({
    required this.status,
    this.publicKey,
    required this.route,
    this.message,
  });

  /// Create result for user with wallet
  factory WalletVerificationResult.hasWallet({
    required String publicKey,
    String route = RouteNames.home2,
    String? message,
  }) {
    return WalletVerificationResult(
      status: WalletVerificationStatus.hasWallet,
      publicKey: publicKey,
      route: route,
      message: message,
    );
  }

  /// Create result for user without wallet
  factory WalletVerificationResult.noWallet({
    String route = RouteNames.walletSetup,
    String? message,
  }) {
    return WalletVerificationResult(
      status: WalletVerificationStatus.noWallet,
      publicKey: null,
      route: route,
      message: message,
    );
  }

  @override
  String toString() {
    return 'WalletVerificationResult(status: $status, publicKey: $publicKey, route: $route, message: $message)';
  }
}
