import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';
import 'package:nemorixpay/core/services/wallet_verification/wallet_verification_result.dart';

/// @file        wallet_verification_service.dart
/// @brief       Service for verifying wallet status using hybrid approach.
/// @details     This service implements the hybrid verification logic that checks
///              both memory (StellarAccountProvider) and secure storage to determine
///              the user's wallet status and provide appropriate navigation routes.
/// @author      Miguel Fagundez
/// @date        06/21/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class WalletVerificationService {
  final StellarAccountProvider _accountProvider;
  final StellarSecureStorageDataSource _secureStorage;

  WalletVerificationService({
    StellarAccountProvider? accountProvider,
    StellarSecureStorageDataSource? secureStorage,
  })  : _accountProvider = accountProvider ?? StellarAccountProvider(),
        _secureStorage = secureStorage ?? StellarSecureStorageDataSource();

  /// Verify wallet status using hybrid approach (memory + secure storage)
  Future<WalletVerificationResult> verifyWalletStatus(String userId) async {
    try {
      // 1. Check StellarAccountProvider (memory)
      if (_accountProvider.currentAccount != null) {
        final publicKey = _accountProvider.getPublicKey();
        if (publicKey != null) {
          return WalletVerificationResult.hasWallet(
            publicKey: publicKey,
            message: 'Wallet found in memory',
          );
        }
      }

      // 2. Check secure storage (local)
      final publicKeys = await _secureStorage.getAllPublicKeys();
      if (publicKeys.isNotEmpty) {
        // Retrieve the primary account and set it in the provider
        final primaryKey = publicKeys.first;
        final privateKey = await _secureStorage.getPrivateKey(
          publicKey: primaryKey,
        );

        if (privateKey != null) {
          // TODO: Set in provider using StellarDataSource
          // For now, we only verify that it exists
          return WalletVerificationResult.hasWallet(
            publicKey: primaryKey,
            message: 'Wallet found in secure storage',
          );
        }
      }

      // 3. No wallet configured
      return WalletVerificationResult.noWallet(
        message: 'No wallet configured',
      );
    } catch (e) {
      // In case of error, assume no wallet
      return WalletVerificationResult.noWallet(
        message: 'Error verifying wallet: $e',
      );
    }
  }

  /// Check if user has wallet configured
  Future<bool> hasWalletConfigured(String userId) async {
    try {
      // 1. Check memory first
      if (_accountProvider.currentAccount != null) {
        return true;
      }

      // 2. Check secure storage
      final publicKeys = await _secureStorage.getAllPublicKeys();
      if (publicKeys.isNotEmpty) {
        // Verify at least one key has a private key
        for (final publicKey in publicKeys) {
          final hasKey = await _secureStorage.hasPrivateKey(
            publicKey: publicKey,
          );
          if (hasKey) {
            return true;
          }
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  /// Get stored public key for user
  Future<String?> getStoredPublicKey(String userId) async {
    try {
      // 1. Check memory first
      final memoryKey = _accountProvider.getPublicKey();
      if (memoryKey != null) {
        return memoryKey;
      }

      // 2. Check secure storage
      final publicKeys = await _secureStorage.getAllPublicKeys();
      if (publicKeys.isNotEmpty) {
        // Return the first key that has a private key
        for (final publicKey in publicKeys) {
          final hasKey = await _secureStorage.hasPrivateKey(
            publicKey: publicKey,
          );
          if (hasKey) {
            return publicKey;
          }
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
