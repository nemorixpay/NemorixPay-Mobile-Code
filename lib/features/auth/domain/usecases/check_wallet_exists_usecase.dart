import 'package:flutter/foundation.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';

/// @file        check_wallet_exists_usecase.dart
/// @brief       Use case for checking if a wallet exists for a user.
/// @details     This use case verifies if a user has a wallet configured by checking
///              the secure storage for a public key associated with the user ID.
/// @author      Miguel Fagundez
/// @date        2025-01-18
/// @version     1.0
/// @copyright   Apache 2.0 License

class CheckWalletExistsUseCase {
  final StellarSecureStorageDataSource _secureStorage;

  CheckWalletExistsUseCase(this._secureStorage);

  /// Checks if a wallet exists for the given user ID
  ///
  /// [userId] The user ID to check for wallet existence
  /// Returns true if a wallet exists, false otherwise
  Future<bool> call(String userId) async {
    try {
      debugPrint(
          'CheckWalletExistsUseCase: Checking wallet for userId: $userId');

      // TODO: Use WalletVerificationService — current implementation breaks the architecture.
      final hasWallet = await _secureStorage.hasPublicKey(userId: userId);

      debugPrint('CheckWalletExistsUseCase: Wallet exists: $hasWallet');
      return hasWallet;
    } catch (e) {
      debugPrint('CheckWalletExistsUseCase: Error checking wallet: $e');
      return false;
    }
  }
}
