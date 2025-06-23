import 'package:flutter/foundation.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';

/// @file        save_public_key_usecase.dart
/// @brief       Use case for saving a public key for a user.
/// @details     This use case saves a public key securely for a specific user ID
///              using the secure storage service.
/// @author      Miguel Fagundez
/// @date        2025-01-18
/// @version     1.0
/// @copyright   Apache 2.0 License

class SavePublicKeyUseCase {
  final StellarSecureStorageDataSource _secureStorage;

  SavePublicKeyUseCase(this._secureStorage);

  /// Saves a public key for the given user ID
  ///
  /// [publicKey] The public key to save
  /// [userId] The user ID to associate with the public key
  /// Returns true if the key was saved successfully, false otherwise
  Future<bool> call(String publicKey, String userId) async {
    try {
      debugPrint('SavePublicKeyUseCase: Saving public key for userId: $userId');

      // TODO: Use WalletVerificationService — current implementation breaks the architecture.
      final saved = await _secureStorage.savePublicKey(
        publicKey: publicKey,
        userId: userId,
      );

      debugPrint('SavePublicKeyUseCase: Public key saved: $saved');
      return saved;
    } catch (e) {
      debugPrint('SavePublicKeyUseCase: Error saving public key: $e');
      return false;
    }
  }
}
