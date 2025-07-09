import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nemorixpay/config/constants/app_constants.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';

/// @file        stellar_secure_storage_datasource.dart
/// @brief       Secure storage data source for Stellar private keys.
/// @details     This data source provides secure storage and retrieval of Stellar private keys
///             using flutter_secure_storage with biometric authentication. Each wallet
///             is identified by its public key to prevent conflicts when users create
///             multiple wallets or reinstall the app.
/// @author      Miguel Fagundez
/// @date        06/20/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

/// Data source responsible for secure storage of Stellar private keys locally
class StellarSecureStorageDataSource {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _baseKey = AppConstants.baseStellarKey;
  static const String _baseUserKey = AppConstants.baseUserKey;

  /// Saves a Stellar private key securely
  ///
  /// [publicKey] The public key that identifies the wallet
  /// [privateKey] The private key to be stored securely
  /// Returns true if the key was saved successfully, false otherwise
  Future<bool> savePrivateKey({
    required String publicKey,
    required String privateKey,
  }) async {
    try {
      final String storageKey = '$_baseKey$publicKey';

      await _storage.write(
        key: storageKey,
        value: privateKey,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      debugPrint(
          'Stellar private key saved successfully for public key: $publicKey');
      return true;
    } catch (e) {
      debugPrint('Error saving Stellar private key: $e');
      return false;
    }
  }

  /// Saves a Stellar public key securely
  ///
  /// [publicKey] The public key that identifies the wallet
  /// [userId] The userId that identify every user
  /// Returns true if the key was saved successfully, false otherwise
  Future<bool> savePublicKey({
    required String publicKey,
    required String userId,
  }) async {
    try {
      final String storagePublicKey = '$_baseUserKey$userId';

      await _storage.write(
        key: storagePublicKey,
        value: publicKey,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      debugPrint(
          'Stellar public key saved successfully for userId: $publicKey');
      return true;
    } catch (e) {
      debugPrint('Error saving Stellar public key: $e');
      return false;
    }
  }

  /// Retrieves a Stellar private key securely
  ///
  /// [publicKey] The public key that identifies the wallet
  /// Returns the private key if found, null otherwise
  Future<String?> getPrivateKey({
    required String publicKey,
  }) async {
    try {
      final String storageKey = '$_baseKey$publicKey';

      final String? privateKey = await _storage.read(
        key: storageKey,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      if (privateKey != null) {
        debugPrint(
            'Stellar private key retrieved successfully for public key: $publicKey');
      } else {
        debugPrint('No Stellar private key found for public key: $publicKey');
      }

      return privateKey;
    } catch (e) {
      debugPrint('Error retrieving Stellar private key: $e');
      return null;
    }
  }

  /// Retrieves a Stellar public key securely
  ///
  /// [userId] The userId that identify every user
  /// Returns the public key if found, null otherwise
  Future<String?> getPublicKey({
    required String userId,
  }) async {
    try {
      final String storageKey = '$_baseUserKey$userId';

      final String? publicKey = await _storage.read(
        key: storageKey,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      if (publicKey != null) {
        debugPrint(
            'Stellar public key retrieved successfully for this userId: $publicKey');
      } else {
        debugPrint('No Stellar public key found for this userId.');
      }

      return publicKey;
    } catch (e) {
      debugPrint('Error retrieving Stellar public key: $e');
      return null;
    }
  }

  /// Checks if a private key exists for a given public key
  ///
  /// [publicKey] The public key to check
  /// Returns true if a private key exists, false otherwise
  Future<bool> hasPrivateKey({
    required String publicKey,
  }) async {
    try {
      final String storageKey = '$_baseKey$publicKey';
      final bool exists = await _storage.containsKey(
        key: storageKey,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      debugPrint('Private key exists for public key $publicKey: $exists');
      return exists;
    } catch (e) {
      debugPrint('Error checking if private key exists: $e');
      return false;
    }
  }

  /// Checks if a public key exists for a given public key
  ///
  /// [userId] The userId that identify every user
  /// Returns true if a public key exists, false otherwise
  Future<bool> hasPublicKey({
    required String userId,
  }) async {
    try {
      final String storageKey = '$_baseUserKey$userId';
      final bool exists = await _storage.containsKey(
        key: storageKey,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      debugPrint('Public key exists for this userId ($userId): $exists');
      if (exists) {
        StellarAccountProvider stellarAccountProvider =
            StellarAccountProvider();
        stellarAccountProvider.userId = userId;
        final publicKey = await getPublicKey(userId: userId);
        if (publicKey != null) {
          // --------------------------------------------------
          // TODO: This need to be re-checked in production
          // --------------------------------------------------
          stellarAccountProvider.updatePublicKey(publicKey);
          debugPrint('Public key exists for public key: $publicKey');
          final privateKey = await getPrivateKey(publicKey: publicKey);
          if (privateKey != null) {
            debugPrint('Private key exists: $privateKey');
            stellarAccountProvider.updateSecretKey(privateKey);
          }
        }
      }
      return exists;
    } catch (e) {
      debugPrint('Error checking if public key exists: $e');
      return false;
    }
  }

  /// Deletes all Stellar private keys
  /// Returns true if all keys were deleted successfully, false otherwise
  Future<bool> deleteAllKeys() async {
    try {
      await _storage.deleteAll(
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      debugPrint('All Stellar private/public keys deleted successfully');
      return true;
    } catch (e) {
      debugPrint('Error deleting all Stellar private keys: $e');
      return false;
    }
  }

  /// Deletes a Stellar private key
  ///
  /// [publicKey] The public key that identifies the wallet to delete
  ///
  /// Returns true if the key was deleted successfully, false otherwise
  /// If the given [publicKey] does not exist, nothing will happen.
  Future<bool> deletePrivateKey({
    required String publicKey,
  }) async {
    try {
      final String storageKey = '$_baseKey$publicKey';

      await _storage.delete(
        key: storageKey,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      debugPrint(
          'Stellar private key deleted successfully for public key: $publicKey');
      return true;
    } catch (e) {
      debugPrint('Error deleting Stellar private key: $e');
      return false;
    }
  }

  /// Gets all stored public keys
  /// Returns a list of public keys that have associated private keys
  Future<List<String>> getAllPublicKeys() async {
    try {
      final Map<String, String> allKeys = await _storage.readAll(
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      final List<String> publicKeys = allKeys.keys
          .where((key) => key.startsWith(_baseKey))
          .map((key) => key.substring(_baseKey.length))
          .toList();

      debugPrint('Found ${publicKeys.length} stored public keys');
      return publicKeys;
    } catch (e) {
      debugPrint('Error getting all public keys: $e');
      return [];
    }
  }
}
