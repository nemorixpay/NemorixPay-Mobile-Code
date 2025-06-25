// ignore_for_file: unintended_html_in_doc_comment

import 'package:flutter/foundation.dart';
import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_transaction_model.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:dio/dio.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_error_codes.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';

/// @file        stellar_datasource_impl.dart
/// @brief       Service for Stellar network integration in NemorixPay.
/// @details     Provides methods for mnemonic generation, key derivation, account creation
///              and create/validate transactions on the Stellar testnet using the official Flutter SDK.
///              Now includes secure storage for private keys using biometric authentication.
/// @author      Miguel Fagundez
/// @date        06/20/2025
/// @version     1.3
/// @copyright   Apache 2.0 License

/// Service responsible for interacting with the Stellar network
class StellarDataSourceImpl implements StellarDataSource {
  late final StellarSDK _sdk;
  final _accountProvider = StellarAccountProvider();
  final _secureStorage = StellarSecureStorageDataSource();
  final bool isAppInProduction = false;

  StellarDataSourceImpl() {
    _sdk = StellarSDK.TESTNET;
  }

  /// Gets the current public key from the account provider
  @override
  String? getCurrentPublicKey() {
    final account = _accountProvider.currentAccount;
    if (account == null) {
      throw StellarFailure(
        stellarCode: StellarErrorCode.accountNotInitialized.code,
        stellarMessage: 'No Stellar account initialized',
      );
    }
    return account.publicKey;
  }

  /// Generates a mnemonic phrase (12 or 24 words)
  /// @param strength Strength of the mnemonic phrase (128 for 12 words, 256 for 24 words)
  /// @return List of mnemonic words
  @override
  Future<List<String>> generateMnemonic({int strength = 256}) async {
    debugPrint(
      'StellarDatasource: generateMnemonic - Starting mnemonic generation',
    );
    debugPrint('StellarDatasource: generateMnemonic - Strength: $strength');

    final mnemonic = bip39.generateMnemonic(strength: strength);
    debugPrint(
      'StellarDatasource: generateMnemonic - Mnemonic generated successfully',
    );
    debugPrint('StellarDatasource: generateMnemonic - Mnemonic: $mnemonic');

    return mnemonic.split(' ');
  }

  /// Creates a new Stellar account from a mnemonic phrase
  @override
  Future<StellarAccountModel> createAccount({
    required String mnemonic,
    String passphrase = "",
  }) async {
    debugPrint('StellarDatasource: createAccount - Starting account creation');
    debugPrint('StellarDatasource: createAccount - Mnemonic: $mnemonic');
    debugPrint('StellarDatasource: createAccount - Passphrase: $passphrase');

    final keyPair = await getKeyPairFromMnemonic(
      mnemonic,
      passphrase: passphrase,
    );
    debugPrint(
      'StellarDatasource: createAccount - KeyPair generated: ${keyPair.accountId}',
    );

    if (!isAppInProduction) {
      await createAccountInTestnet(keyPair.accountId);
      final balance = await getBalance(keyPair.accountId);
      debugPrint(
          'StellarDatasource: createAccount - Account created in testnet with balance = $balance');
    }

    debugPrint(
        'StellarDatasource: createAccount (accountId): ${keyPair.accountId}');
    debugPrint(
        'StellarDatasource: createAccount (publicKey): ${keyPair.publicKey}');
    debugPrint(
        'StellarDatasource: createAccount (secretSeed): ${keyPair.secretSeed}');
    debugPrint(
        'StellarDatasource: createAccount (privateKey): ${keyPair.privateKey}');

    // Save private key securely
    final saved = await _secureStorage.savePrivateKey(
      publicKey: keyPair.accountId,
      privateKey: keyPair.secretSeed,
    );

    if (!saved) {
      debugPrint(
          'StellarDatasource: createAccount - Failed to save private key securely');
      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error saving private key securely',
      );
    }
    debugPrint('StellarDatasource: createAccount - Private key saved securely');

    final balance = await getBalance(keyPair.accountId);

    final account = StellarAccountModel(
      publicKey: keyPair.accountId,
      secretKey: keyPair.secretSeed,
      balance: balance,
      mnemonic: mnemonic,
      createdAt: DateTime.now(),
    );
    debugPrint(
      'StellarDatasource: createAccount - Account model created successfully',
    );

    _accountProvider.setCurrentAccount(account);
    debugPrint('StellarDatasource: createAccount - Account set as current');

    return account;
  }

  // Private helper methods
  @override
  Future<KeyPair> getKeyPairFromMnemonic(
    String mnemonic, {
    String passphrase = "",
  }) async {
    final seed = bip39.mnemonicToSeed(mnemonic, passphrase: passphrase);
    final stellarSeed = seed.sublist(0, 32);
    final secretSeed = StrKey.encodeStellarSecretSeed(stellarSeed);
    return KeyPair.fromSecretSeed(secretSeed);
  }

  Future<void> createAccountInTestnet(String publicKey) async {
    debugPrint(
      'StellarDatasource: createAccountInTestnet - Intentando crear cuenta: $publicKey',
    );
    final url = 'https://friendbot.stellar.org/?addr=$publicKey';
    final response = await Dio().get(url);
    if (response.statusCode != 200) {
      debugPrint(
        'StellarDatasource: createAccountInTestnet - Error: ${response.statusCode}',
      );
      debugPrint(
        'StellarDatasource: createAccountInTestnet - Response: ${response.data}',
      );
      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error creating stellar account. Try again!',
      );
    }
    debugPrint(
      'StellarDatasource: createAccountInTestnet - Account created successfully',
    );
  }

  /// Gets the current balance of a Stellar account
  @override
  Future<double> getAccountBalance(String publicKey) async {
    try {
      debugPrint(
        'StellarDatasource: getAccountBalance - Starting balance retrieval',
      );
      debugPrint(
        'StellarDatasource: getAccountBalance - Public key: $publicKey',
      );

      // Validate public key format
      if (!publicKey.startsWith('G') || publicKey.length != 56) {
        debugPrint(
          'StellarDatasource: getAccountBalance - Invalid public key format',
        );
        throw StellarFailure(
          stellarCode: StellarErrorCode.invalidPublicKey.code,
          stellarMessage: 'Invalid public key',
        );
      }

      // Only XLM
      // TODO Check with other assets
      final balance = await getBalance(publicKey);
      debugPrint(
        'StellarDatasource: getAccountBalance - Balance retrieved successfully: $balance',
      );

      return balance;
    } catch (e) {
      debugPrint('StellarDatasource: getAccountBalance - Error: $e');
      if (e is StellarFailure) {
        debugPrint(
          'StellarDatasource: getAccountBalance - Re-throwing StellarFailure',
        );
        rethrow;
      }

      debugPrint(
        'StellarDatasource: getAccountBalance - Converting to StellarFailure',
      );
      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error getting balance: $e',
      );
    }
  }

  /// Sends XLM from source account to destination account
  @override
  Future<StellarTransactionModel> sendPayment({
    required String sourceSecretKey,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  }) async {
    try {
      debugPrint('StellarDatasource: sendPayment - Starting payment');
      debugPrint(
        'StellarDatasource: sendPayment - Destination: $destinationPublicKey',
      );
      debugPrint('StellarDatasource: sendPayment - Amount: $amount');
      debugPrint('StellarDatasource: sendPayment - Memo: $memo');

      // Validate memo length if provided
      if (memo != null && memo.length > 28) {
        debugPrint('StellarDatasource: sendPayment - Invalid memo length');
        throw StellarFailure(
          stellarCode: StellarErrorCode.invalidMemo.code,
          stellarMessage: 'Memo cannot be longer than 28 characters',
        );
      }

      // Validate amount
      if (amount <= 0) {
        debugPrint('StellarDatasource: sendPayment - Invalid amount');
        throw StellarFailure(
          stellarCode: StellarErrorCode.invalidAmount.code,
          stellarMessage: 'Amount must be greater than 0',
        );
      }

      final transactionHash = await sendTransaction(
        sourceSecretSeed: sourceSecretKey,
        destinationPublicKey: destinationPublicKey,
        amount: amount,
        memo: memo,
      );
      debugPrint(
        'StellarDatasource: sendPayment - Transaction sent successfully',
      );

      final details = await _validateTransaction(transactionHash);
      debugPrint(
        'StellarDatasource: sendPayment - Transaction validated successfully',
      );

      final transaction = StellarTransactionModel(
        hash: transactionHash,
        sourceAccount: details['sourceAccount'] as String,
        destinationAccount: destinationPublicKey,
        amount: amount,
        memo: memo,
        successful: details['successful'] as bool,
        ledger: details['ledger'] as int?,
        createdAt: DateTime.parse(details['createdAt'] as String),
        feeCharged: details['feeCharged'].toString(),
      );
      debugPrint(
        'StellarDatasource: sendPayment - Transaction model created successfully',
      );

      return transaction;
    } catch (e) {
      debugPrint('StellarDatasource: sendPayment - Error: $e');
      if (e is StellarFailure) {
        debugPrint(
          'StellarDatasource: sendPayment - Re-throwing StellarFailure',
        );
        rethrow;
      }

      debugPrint(
        'StellarDatasource: sendPayment - Converting to StellarFailure',
      );
      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error sending payment: $e',
      );
    }
  }

  /// Validates a transaction by its hash
  @override
  Future<StellarTransactionModel> validateTransaction(
    String transactionHash,
  ) async {
    final details = await _validateTransaction(transactionHash);
    return StellarTransactionModel(
      hash: transactionHash,
      sourceAccount: details['sourceAccount'] as String,
      destinationAccount: '', // No disponible en la validación
      amount: 0.0, // No disponible en la validación
      successful: details['successful'] as bool,
      ledger: details['ledger'] as int?,
      createdAt: DateTime.parse(details['createdAt'] as String),
      feeCharged: details['feeCharged'].toString(),
    );
  }

  /// Imports an existing Stellar account using a mnemonic phrase
  /// @param mnemonic The mnemonic phrase to import (12 or 24 words)
  /// @param passphrase Optional passphrase for the mnemonic
  /// @return StellarAccount with the imported account details
  /// @throws StellarFailure if the import fails
  @override
  Future<StellarAccountModel> importAccount({
    required String mnemonic,
    String passphrase = "",
  }) async {
    try {
      debugPrint('StellarDatasource: importAccount - Iniciando importación');
      debugPrint('StellarDatasource: importAccount - Mnemonic: $mnemonic');

      // Validate mnemonic format
      if (!bip39.validateMnemonic(mnemonic)) {
        debugPrint('StellarDatasource: importAccount - Mnemonic inválido');
        throw StellarFailure(
          stellarCode: StellarErrorCode.invalidMnemonic.code,
          stellarMessage: 'Invalid Seed Phrase. Please, try again!',
        );
      }

      // Get key pair from mnemonic
      final keyPair = await getKeyPairFromMnemonic(
        mnemonic,
        passphrase: passphrase,
      );
      debugPrint(
        'StellarDatasource: importAccount - KeyPair generado: ${keyPair.accountId}',
      );
      debugPrint(
        'StellarDatasource: importAccount - SecrteSeed generado: ${keyPair.secretSeed}',
      );

      // Check if account exists in Stellar
      try {
        final balance = await getBalance(keyPair.accountId);

        debugPrint('StellarDatasource: importAccount - Account found');

        // Save private key securely
        final saved = await _secureStorage.savePrivateKey(
          publicKey: keyPair.accountId,
          privateKey: keyPair.secretSeed,
        );

        if (!saved) {
          debugPrint(
              'StellarDatasource: importAccount - Failed to save private key securely');
          throw StellarFailure(
            stellarCode: StellarErrorCode.unknown.code,
            stellarMessage: 'Error saving private key securely',
          );
        }
        debugPrint(
            'StellarDatasource: importAccount - Private key saved securely');

        final account = StellarAccountModel(
          publicKey: keyPair.accountId,
          secretKey: keyPair.secretSeed,
          balance: balance,
          mnemonic: mnemonic,
          createdAt: DateTime.now(),
        );

        _accountProvider.setCurrentAccount(account);
        debugPrint('StellarDatasource: createAccount - Account set as current');

        return account;
      } catch (e) {
        debugPrint('StellarDatasource: importAccount - Account not found');
        throw StellarFailure(
          stellarCode: StellarErrorCode.accountNotFound.code,
          stellarMessage: 'La cuenta no existe en la red Stellar',
        );
      }
    } catch (e) {
      debugPrint('StellarDatasource: importAccount - Error: $e');
      if (e is StellarFailure) rethrow;

      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error importing account: $e',
      );
    }
  }

  /// Gets the transaction history for the current account
  /// @return List<StellarTransaction> The list of transactions
  /// @throws StellarFailure if the account is not initialized or if there's an error
  Future<List<StellarTransactionModel>> getTransactions() async {
    try {
      final publicKey = getCurrentPublicKey();
      debugPrint(
        'StellarDatasource: getTransactions - Obteniendo transacciones para: $publicKey',
      );
      if (publicKey == null) {
        throw StellarFailure(
          stellarCode: StellarErrorCode.unknown.code,
          stellarMessage: 'Public key is Null. Try again!',
        );
      }

      final response = await _sdk.transactions.forAccount(publicKey).execute();
      final transactions = response.records;

      final List<StellarTransactionModel> result = [];
      for (final tx in transactions) {
        try {
          // Obtener las operaciones de la transacción
          final operations =
              await _sdk.operations.forTransaction(tx.hash).execute();

          // Buscar operación de pago
          PaymentOperationResponse? paymentOp;
          try {
            paymentOp = operations.records.firstWhere(
              (op) => op is PaymentOperationResponse,
            ) as PaymentOperationResponse;
          } catch (_) {
            // Si no hay operación de pago, continuamos con valores por defecto
          }

          // Si no hay operación de pago, usar valores por defecto
          result.add(
            StellarTransactionModel(
              hash: tx.hash,
              sourceAccount: tx.sourceAccount,
              destinationAccount: paymentOp?.to ?? 'Desconocido',
              amount: paymentOp != null
                  ? double.tryParse(paymentOp.amount) ?? 0.0
                  : 0.0,
              memo: tx.memo?.toString(),
              successful: tx.successful,
              ledger: tx.ledger,
              createdAt: DateTime.parse(tx.createdAt),
              feeCharged: tx.feeCharged.toString(),
            ),
          );
        } catch (e) {
          debugPrint(
            'StellarDatasource: getTransactions - Error processing transaction ${tx.hash}: $e',
          );
          // Si hay error al procesar una transacción, la omitimos y continuamos con la siguiente
          continue;
        }
      }

      return result;
    } catch (e) {
      debugPrint('StellarDatasource: getTransactions - Error: $e');
      if (e is StellarFailure) rethrow;

      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error getting transactions: $e',
      );
    }
  }

  // -----------------------------------------------------------------------------------
  // Multiple Balances Handling
  // -----------------------------------------------------------------------------------
  /// Future implementation for handling multiple digital assets in a Stellar account.
  /// This method retrieves all balances associated with a Stellar account, including:
  /// - XLM (native asset)
  /// - Custom tokens (credit_alphanum4)
  /// - Long-named tokens (credit_alphanum12)
  ///
  /// Each balance contains:
  /// - assetType: The type of asset ('native', 'credit_alphanum4', 'credit_alphanum12')
  /// - assetCode: The code of the asset (null for XLM, e.g., 'USDC' for USD Coin)
  /// - assetIssuer: The issuer of the asset (null for XLM, public key for other assets)
  /// - balance: The current balance of the asset
  /// - limit: The maximum balance allowed (for credit assets)
  ///
  /// Example usage:
  /// ```dart
  /// final balances = await getBalances(publicKey);
  /// for (var balance in balances) {
  ///   print('Asset: ${balance.assetCode ?? 'XLM'}');
  ///   print('Balance: ${balance.balance}');
  /// }
  /// ```
  ///
  /// Possible data type:
  ///
  /// class StellarBalance {
  ///   final String assetType;  // 'native' o 'credit_alphanum4' o 'credit_alphanum12'
  ///   final String? assetCode; // null para XLM, código para otros activos
  ///   final String? assetIssuer; // null para XLM, emisor para otros activos
  ///   final double balance;
  ///   final double? limit;     // para activos de crédito
  /// }
  ///
  /// StellarAccount would be modified like:
  ///
  /// class StellarAccount {
  ///   final String publicKey;
  ///   final String? secretKey;
  ///   final List<StellarBalance> balances;  // Lista de balances
  ///   final String? mnemonic;
  ///   final DateTime createdAt;
  ///   // ...
  /// }
  ///
  /// ----------------------------------------------------------------------
  ///
  /// Note: This is a future implementation. Current implementation only handles XLM balance.
  /// To implement this, you'll need to:
  /// 1. Create a StellarBalance entity
  /// 2. Update StellarAccount to handle multiple balances
  /// 3. Modify the UI to display different assets
  /// 4. Update transaction handling to support different assets
  ///
  /// Future<List<StellarBalance>> getBalances(String publicKey) async {
  ///   final account = await _sdk.accounts.account(publicKey);
  ///   return account.balances.map((b) => StellarBalance(
  ///     assetType: b.assetType,
  ///     assetCode: b.assetCode,
  ///     assetIssuer: b.assetIssuer,
  ///     balance: double.tryParse(b.balance) ?? 0.0,
  ///     limit: b.limit != null ? double.tryParse(b.limit!) : null,
  ///   )).toList();
  /// }
  ///

  /// Gets the XLM balance for a given public key
  /// @param publicKey The public key of the account
  /// @return The XLM balance as a double
  /// @throws Exception if no XLM balance is found
  @override
  Future<double> getBalance(String publicKey) async {
    try {
      final account = await _sdk.accounts.account(publicKey);
      final xlmBalance = account.balances.firstWhere(
        (b) => b.assetType == 'native',
        orElse: () => throw Exception('No XLM balance found'),
      );
      return double.tryParse(xlmBalance.balance) ?? 0.0;
    } catch (e) {
      debugPrint(
        'StellarDatasource: getBalanceError - Intentando devolver el balance de la cuenta: $publicKey',
      );
      return 0.0;
    }
  }
  // -----------------------------------------------------------------------------------

  @override
  Future<String> sendTransaction({
    required String sourceSecretSeed,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  }) async {
    try {
      debugPrint('StellarDatasource: sendTransaction - Iniciando transacción');
      debugPrint(
        'StellarDatasource: sendTransaction - Destino: $destinationPublicKey',
      );
      debugPrint('StellarDatasource: sendTransaction - Monto: $amount');

      final sourceKeyPair = KeyPair.fromSecretSeed(sourceSecretSeed);
      final balance = await getBalance(sourceKeyPair.accountId);
      debugPrint(
        'StellarDatasource: sendTransaction - Balance actual: $balance',
      );

      if (balance < amount) {
        debugPrint(
          'StellarDatasource: sendTransaction - Error: Insufficient balance',
        );
        throw Exception(
          'Insufficient balance. Current balance: $balance XLM, Amount to send: $amount XLM',
        );
      }

      final sourceAccount = await _sdk.accounts.account(
        sourceKeyPair.accountId,
      );
      debugPrint('StellarDatasource: sendTransaction - Cuenta fuente cargada');

      final transaction = TransactionBuilder(sourceAccount)
          .addOperation(
            PaymentOperationBuilder(
              destinationPublicKey,
              Asset.NATIVE,
              amount.toString(),
            ).build(),
          )
          .addMemo(Memo.text("NemorixPay Transfer: $memo"))
          .build();

      transaction.sign(sourceKeyPair, Network.TESTNET);
      debugPrint('StellarDatasource: sendTransaction - Transacción firmada');

      final response = await _sdk.submitTransaction(transaction);
      debugPrint(
        'StellarDatasource: sendTransaction - Respuesta: ${response.success}',
      );

      final String transactionHash = response.hash ?? '';
      if (response.success && transactionHash.isNotEmpty) {
        debugPrint(
          'StellarDatasource: sendTransaction - Transacción exitosa: $transactionHash',
        );
        return transactionHash;
      } else {
        debugPrint(
          'StellarDatasource: sendTransaction - Error: ${response.extras?.resultCodes?.transactionResultCode}',
        );
        throw Exception(
          'Error sending transaction: ${response.extras?.resultCodes?.transactionResultCode}',
        );
      }
    } catch (e) {
      debugPrint('StellarDatasource: sendTransaction - Excepción: $e');
      throw Exception('Error sending transaction: $e');
    }
  }

  Future<Map<String, dynamic>> _validateTransaction(
    String transactionHash,
  ) async {
    try {
      final normalizedHash = transactionHash.toLowerCase().trim();
      final transaction = await _sdk.transactions.transaction(normalizedHash);
      return {
        'successful': transaction.successful,
        'ledger': transaction.ledger,
        'createdAt': transaction.createdAt,
        'sourceAccount': transaction.sourceAccount,
        'feeCharged': transaction.feeCharged,
      };
    } catch (e) {
      throw Exception('Error validating transaction: $e');
    }
  }

  /// Gets all available assets in the Stellar network
  @override
  Future<List<AssetModel>> getAvailableAssets() async {
    try {
      debugPrint(
        'StellarDatasource: getAvailableAssets - Obteniendo assets disponibles',
      );

      // Obtener todos los assets de la red
      final response = await _sdk.assets
          .order(RequestBuilderOrder.DESC)
          .limit(200)
          .execute();
      final assets = response.records;

      // Convertir a StellarAssetInfoModel
      return assets.map((asset) {
        return AssetModel(
          id: '',
          assetCode: asset.assetCode ?? 'XLM',
          name: _getAssetName(asset.assetCode ?? 'XLM'),
          description: _getAssetDescription(asset.assetCode ?? 'XLM'),
          assetIssuer: asset.assetIssuer ?? '',
          issuerName: _getIssuerName(asset.assetIssuer ?? ''),
          isVerified: _isAssetVerified(
            asset.assetCode ?? 'XLM',
            asset.assetIssuer ?? '',
          ),
          logoUrl: _getAssetLogoUrl(asset.assetCode ?? 'XLM'),
          decimals:
              7, // Por defecto, debería obtenerse de la información del asset
          assetType: asset.assetType,
          network: '',
        );
      }).toList();
    } catch (e) {
      debugPrint('StellarDatasource: getAvailableAssets - Error: $e');
      if (e is StellarFailure) rethrow;

      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error getting available assets: $e',
      );
    }
  }

  /// Gets all assets and their balances for a given Stellar account
  @override
  Future<List<AssetModel>> getAccountAssets(String publicKey) async {
    try {
      debugPrint(
        'StellarDatasource: getAccountAssets - Obteniendo account assets disponibles',
      );
      debugPrint(
        'StellarDatasource: getAccountAssets - Public Key: $publicKey',
      );
      final account = await _sdk.accounts.account(publicKey);
      return account.balances.map((balance) {
        return AssetModel(
          id: '',
          assetCode: balance.assetCode ?? 'XLM',
          balance: double.tryParse(balance.balance) ?? 0.0,
          assetType: balance.assetType,
          assetIssuer: balance.assetIssuer,
          limit: balance.limit != null ? double.tryParse(balance.limit!) : null,
          isAuthorized: balance.isAuthorized ?? true,
          decimals: 7,
          name: _getAssetName(balance.assetCode ?? 'XLM'),
          network: '', // Default for XLM, should be fetched from asset info
        );
      }).toList();
    } catch (e) {
      debugPrint('StellarDatasource: getAccountAssets - Error: $e');
      if (e is StellarFailure) rethrow;

      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error getting account assets in datasource: $e',
      );
    }
  }

  // Métodos auxiliares para obtener información adicional de los assets
  String _getAssetName(String code) {
    // TODO: Implementar lógica para obtener el nombre del asset
    // Por ahora retornamos el código como nombre
    return code;
  }

  String _getAssetDescription(String code) {
    // TODO: Implementar lógica para obtener la descripción del asset
    // Por ahora retornamos una descripción genérica
    return '$code on Stellar';
  }

  String _getIssuerName(String issuer) {
    // TODO: Implementar lógica para obtener el nombre del emisor
    // Por ahora retornamos el issuer como nombre
    return issuer;
  }

  bool _isAssetVerified(String code, String issuer) {
    // TODO: Implementar lógica para verificar si el asset está verificado
    // Por ahora retornamos true para XLM y false para otros
    return code == 'XLM';
  }

  String? _getAssetLogoUrl(String code) {
    // TODO: Implementar lógica para obtener la URL del logo
    // Por ahora retornamos null
    return null;
  }

  // -----------------------------------------------------------------------------------
  // Secure Key Management Methods
  // -----------------------------------------------------------------------------------

  /// Retrieves a private key securely from storage
  ///
  /// [publicKey] The public key that identifies the wallet
  /// Returns the private key if found, null otherwise
  @override
  Future<String?> getSecurePrivateKey({
    required String publicKey,
  }) async {
    try {
      debugPrint(
          'StellarDatasource: getSecurePrivateKey - Retrieving private key for: $publicKey');

      final privateKey =
          await _secureStorage.getPrivateKey(publicKey: publicKey);

      if (privateKey != null) {
        debugPrint(
            'StellarDatasource: getSecurePrivateKey - Private key retrieved successfully');
      } else {
        debugPrint(
            'StellarDatasource: getSecurePrivateKey - No private key found');
      }

      return privateKey;
    } catch (e) {
      debugPrint('StellarDatasource: getSecurePrivateKey - Error: $e');
      return null;
    }
  }

  /// Checks if a private key exists securely for a given public key
  ///
  /// [publicKey] The public key to check
  /// Returns true if a private key exists, false otherwise
  @override
  Future<bool> hasSecurePrivateKey({
    required String publicKey,
  }) async {
    try {
      debugPrint(
          'StellarDatasource: hasSecurePrivateKey - Checking for public key: $publicKey');

      final exists = await _secureStorage.hasPrivateKey(publicKey: publicKey);

      debugPrint('StellarDatasource: hasSecurePrivateKey - Result: $exists');
      return exists;
    } catch (e) {
      debugPrint('StellarDatasource: hasSecurePrivateKey - Error: $e');
      return false;
    }
  }

  /// Deletes a private key securely from storage
  ///
  /// [publicKey] The public key that identifies the wallet to delete
  /// Returns true if the key was deleted successfully, false otherwise
  @override
  Future<bool> deleteSecurePrivateKey({
    required String publicKey,
  }) async {
    try {
      debugPrint(
          'StellarDatasource: deleteSecurePrivateKey - Deleting private key for: $publicKey');

      final deleted =
          await _secureStorage.deletePrivateKey(publicKey: publicKey);

      if (deleted) {
        debugPrint(
            'StellarDatasource: deleteSecurePrivateKey - Private key deleted successfully');
      } else {
        debugPrint(
            'StellarDatasource: deleteSecurePrivateKey - Failed to delete private key');
      }

      return deleted;
    } catch (e) {
      debugPrint('StellarDatasource: deleteSecurePrivateKey - Error: $e');
      return false;
    }
  }

  /// Deletes all private keys securely from storage
  /// Returns true if all keys were deleted successfully, false otherwise
  @override
  Future<bool> deleteAllSecurePrivateKeys() async {
    try {
      debugPrint(
          'StellarDatasource: deleteAllSecurePrivateKeys - Deleting all private keys');

      final deleted = await _secureStorage.deleteAllPrivateKeys();

      if (deleted) {
        debugPrint(
            'StellarDatasource: deleteAllSecurePrivateKeys - All private keys deleted successfully');
      } else {
        debugPrint(
            'StellarDatasource: deleteAllSecurePrivateKeys - Failed to delete all private keys');
      }

      return deleted;
    } catch (e) {
      debugPrint('StellarDatasource: deleteAllSecurePrivateKeys - Error: $e');
      return false;
    }
  }

  /// Gets all stored public keys that have associated private keys
  /// Returns a list of public keys
  @override
  Future<List<String>> getAllStoredPublicKeys() async {
    try {
      debugPrint(
          'StellarDatasource: getAllStoredPublicKeys - Getting all stored public keys');

      final publicKeys = await _secureStorage.getAllPublicKeys();

      debugPrint(
          'StellarDatasource: getAllStoredPublicKeys - Found ${publicKeys.length} public keys');
      return publicKeys;
    } catch (e) {
      debugPrint('StellarDatasource: getAllStoredPublicKeys - Error: $e');
      return [];
    }
  }
}
