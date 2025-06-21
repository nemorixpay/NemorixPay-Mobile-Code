import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_transaction_model.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

/// @file        stellar_datasource.dart
/// @brief       Stellar network data source interface for NemorixPay.
/// @details     This interface defines the contract for Stellar network operations.
///              It provides methods for account management, transactions, and network interactions.
/// @author      Miguel Fagundez
/// @date        2025-05-20
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class StellarDataSource {
  /// Gets the current public key from the account provider
  ///
  /// Returns [String] with the current public key
  /// Throws [StellarFailure] if there is no account initialized
  String getCurrentPublicKey();

  /// Generates a mnemonic phrase for a new Stellar account
  ///
  /// Returns [List<String>] with the mnemonic words
  /// Throws [StellarFailure] if generation fails
  Future<List<String>> generateMnemonic({int strength = 256});

  /// Creates a new Stellar account from a mnemonic phrase
  ///
  /// Returns [StellarAccountModel] with the new account details
  /// Throws [StellarFailure] if account creation fails
  Future<StellarAccountModel> createAccount({
    required String mnemonic,
    String passphrase = "",
  });

  /// Gets the current balance of a Stellar account
  ///
  /// Returns [StellarAccountModel] with updated balance
  /// Throws [StellarFailure] if balance check fails
  Future<double> getAccountBalance(String publicKey);

  /// Sends XLM from source account to destination account
  ///
  /// Returns [StellarTransaction] with transaction details
  /// Throws [StellarFailure] if transaction fails
  Future<StellarTransactionModel> sendPayment({
    required String sourceSecretKey,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  });

  /// Validates a transaction by its hash
  ///
  /// Returns [StellarTransaction] with validation details
  /// Throws [StellarFailure] if validation fails
  Future<StellarTransactionModel> validateTransaction(String transactionHash);

  /// Imports an existing Stellar account using a mnemonic phrase
  ///
  /// Returns [StellarAccount] with the imported account details
  /// Throws [StellarFailure] if import fails
  Future<StellarAccountModel> importAccount({
    required String mnemonic,
    String passphrase = "",
  });

  /// Gets a Stellar KeyPair from a mnemonic phrase
  ///
  /// Returns [KeyPair] with the generated key pair
  /// Throws [StellarFailure] if key pair generation fails
  Future<KeyPair> getKeyPairFromMnemonic(
    String mnemonic, {
    String passphrase = "",
  });

  /// Gets the current balance of a Stellar account
  ///
  /// Returns [double] with the current balance in XLM
  /// Throws [StellarFailure] if balance check fails
  Future<double> getBalance(String publicKey);

  /// Sends a transaction to the Stellar network
  ///
  /// Returns [String] with the transaction hash
  /// Throws [StellarFailure] if transaction fails
  Future<String> sendTransaction({
    required String sourceSecretSeed,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  });

  /// Gets all assets and their balances for a given Stellar account
  ///
  /// Returns [List<AssetModel>] with all assets and their balances
  /// Throws [StellarFailure] if the operation fails
  Future<List<AssetModel>> getAccountAssets(String publicKey);

  /// Gets all available assets in the Stellar network
  ///
  /// Returns [List<AssetModel>] with all available assets and their details
  /// Throws [StellarFailure] if the operation fails
  Future<List<AssetModel>> getAvailableAssets();

  // -----------------------------------------------------------------------------------
  // Secure Key Management Methods
  // -----------------------------------------------------------------------------------

  /// Retrieves a private key securely from storage
  ///
  /// [publicKey] The public key that identifies the wallet
  /// Returns the private key if found, null otherwise
  Future<String?> getSecurePrivateKey({
    required String publicKey,
  });

  /// Checks if a private key exists securely for a given public key
  ///
  /// [publicKey] The public key to check
  /// Returns true if a private key exists, false otherwise
  Future<bool> hasSecurePrivateKey({
    required String publicKey,
  });

  /// Deletes a private key securely from storage
  ///
  /// [publicKey] The public key that identifies the wallet to delete
  /// Returns true if the key was deleted successfully, false otherwise
  Future<bool> deleteSecurePrivateKey({
    required String publicKey,
  });

  /// Deletes all private keys securely from storage
  /// Returns true if all keys were deleted successfully, false otherwise
  /// Return false, if the operation fails
  Future<bool> deleteAllSecurePrivateKeys();

  /// Gets all stored public keys that have associated private keys
  /// Returns a list of public keys
  /// Throws [StellarFailure] if the operation fails
  Future<List<String>> getAllStoredPublicKeys();
}
