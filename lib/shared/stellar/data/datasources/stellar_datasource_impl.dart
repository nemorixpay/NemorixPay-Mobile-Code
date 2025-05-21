// ignore_for_file: unintended_html_in_doc_comment

import 'package:flutter/foundation.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_transaction_model.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:dio/dio.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_error_codes.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_asset_model.dart';

/// @file        stellar_datasource_impl.dart
/// @brief       Service for Stellar network integration in NemorixPay.
/// @details     Provides methods for mnemonic generation, key derivation, account creation
///              and create/validate transactions on the Stellar testnet using the official Flutter SDK.
/// @author      Miguel Fagundez
/// @date        2025-05-20
/// @version     1.2
/// @copyright   Apache 2.0 License

/// Service responsible for interacting with the Stellar network
class StellarDataSourceImpl implements StellarDataSource {
  late final StellarSDK _sdk;
  final _accountProvider = StellarAccountProvider();

  StellarDataSourceImpl() {
    _sdk = StellarSDK.TESTNET;
  }

  /// Gets the current public key from the account provider
  @override
  String getCurrentPublicKey() {
    final account = _accountProvider.currentAccount;
    if (account == null) {
      throw StellarFailure(
        stellarCode: StellarErrorCode.accountNotInitialized.code,
        stellarMessage: 'No hay una cuenta Stellar inicializada',
      );
    }
    return account.publicKey;
  }

  /// Generates a mnemonic phrase (12 or 24 words)
  /// @param strength Strength of the mnemonic phrase (128 for 12 words, 256 for 24 words)
  /// @return List of mnemonic words
  @override
  Future<List<String>> generateMnemonic({int strength = 256}) async {
    final mnemonic = bip39.generateMnemonic(strength: strength);
    debugPrint('StellarDatasource: generateMnemonic');
    debugPrint(mnemonic);
    return mnemonic.split(' ');
  }

  /// Creates a new Stellar account from a mnemonic phrase
  @override
  Future<StellarAccountModel> createAccount({
    required String mnemonic,
    String passphrase = "",
  }) async {
    debugPrint(
      'StellarDatasource: createAccount - Iniciando creación de cuenta',
    );
    debugPrint('StellarDatasource: createAccount - Mnemonic: $mnemonic');

    final keyPair = await getKeyPairFromMnemonic(
      mnemonic,
      passphrase: passphrase,
    );
    debugPrint(
      'StellarDatasource: createAccount - KeyPair generado: ${keyPair.accountId}',
    );

    await createAccountInTestnet(keyPair.accountId);
    debugPrint('StellarDatasource: createAccount - Cuenta creada en testnet');

    final account = StellarAccountModel(
      publicKey: keyPair.accountId,
      secretKey: keyPair.secretSeed,
      balance: 0.0,
      mnemonic: mnemonic,
      createdAt: DateTime.now(),
    );

    _accountProvider.setCurrentAccount(account);
    return account;
  }

  /// Gets the current balance of a Stellar account
  @override
  Future<StellarAccountModel> getAccountBalance(String publicKey) async {
    try {
      // Validate public key format
      if (!publicKey.startsWith('G') || publicKey.length != 56) {
        throw StellarFailure(
          stellarCode: StellarErrorCode.invalidPublicKey.code,
          stellarMessage: 'La clave pública no es válida',
        );
      }

      final balance = await getBalance(publicKey);
      final account = StellarAccountModel(
        publicKey: publicKey,
        secretKey: _accountProvider.currentAccount?.secretKey ?? '',
        balance: balance,
        mnemonic: _accountProvider.currentAccount?.mnemonic ?? '',
        createdAt: _accountProvider.currentAccount?.createdAt ?? DateTime.now(),
      );

      _accountProvider.setCurrentAccount(account);
      return account;
    } catch (e) {
      debugPrint('StellarDatasource: getAccountBalance - Error: $e');
      if (e is StellarFailure) rethrow;

      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error al obtener el balance: $e',
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
      // Validate memo length if provided
      if (memo != null && memo.length > 28) {
        throw StellarFailure(
          stellarCode: StellarErrorCode.invalidMemo.code,
          stellarMessage: 'El memo no puede tener más de 28 caracteres',
        );
      }

      // Validate amount
      if (amount <= 0) {
        throw StellarFailure(
          stellarCode: StellarErrorCode.invalidAmount.code,
          stellarMessage: 'El monto debe ser mayor que 0',
        );
      }

      final transactionHash = await sendTransaction(
        sourceSecretSeed: sourceSecretKey,
        destinationPublicKey: destinationPublicKey,
        amount: amount,
        memo: memo,
      );

      final details = await _validateTransaction(transactionHash);
      return StellarTransactionModel(
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
    } catch (e) {
      debugPrint('StellarDatasource: sendPayment - Error: $e');
      if (e is StellarFailure) rethrow;

      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage: 'Error al enviar el pago: $e',
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
          stellarMessage: 'La frase semilla no es válida',
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
        final account = await _sdk.accounts.account(keyPair.accountId);
        final balance = await getBalance(keyPair.accountId);

        debugPrint('StellarDatasource: importAccount - Cuenta encontrada');
        return StellarAccountModel(
          publicKey: keyPair.accountId,
          secretKey: keyPair.secretSeed,
          balance: balance,
          mnemonic: mnemonic,
          createdAt: DateTime.now(),
        );
      } catch (e) {
        debugPrint('StellarDatasource: importAccount - Cuenta no encontrada');
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
        stellarMessage: 'Error al importar la cuenta: $e',
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
            paymentOp =
                operations.records.firstWhere(
                      (op) => op is PaymentOperationResponse,
                    )
                    as PaymentOperationResponse;
          } catch (_) {
            // Si no hay operación de pago, continuamos con valores por defecto
          }

          // Si no hay operación de pago, usar valores por defecto
          result.add(
            StellarTransactionModel(
              hash: tx.hash,
              sourceAccount: tx.sourceAccount,
              destinationAccount: paymentOp?.to ?? 'Desconocido',
              amount:
                  paymentOp != null
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
            'StellarDatasource: getTransactions - Error al procesar transacción ${tx.hash}: $e',
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
        stellarMessage: 'Error al obtener las transacciones: $e',
      );
    }
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
      throw Exception('Error creating account in testnet: ${response.data}');
    }
    debugPrint(
      'StellarDatasource: createAccountInTestnet - Cuenta creada exitosamente',
    );
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
        'StellarDatasource: getBalance - Intentando devolver el balance de la cuenta: $publicKey',
      );
      return 0.0;
    }
  }

  /// Gets all assets and their balances for a given Stellar account
  @override
  Future<List<StellarAssetModel>> getAccountAssets(String publicKey) async {
    try {
      final account = await _sdk.accounts.account(publicKey);
      return account.balances.map((balance) {
        return StellarAssetModel(
          code: balance.assetCode ?? 'XLM',
          balance: double.tryParse(balance.balance) ?? 0.0,
          type: balance.assetType,
          issuer: balance.assetIssuer,
          limit: balance.limit != null ? double.tryParse(balance.limit!) : null,
          isAuthorized: balance.isAuthorized ?? true,
          decimals: 7, // Default for XLM, should be fetched from asset info
        );
      }).toList();
    } catch (e) {
      debugPrint('StellarDatasource: getAccountAssets - Error: $e');
      if (e is StellarFailure) rethrow;

      throw StellarFailure(
        stellarCode: StellarErrorCode.unknown.code,
        stellarMessage:
            'Error al obtener los assets de la cuenta en el datasource: $e',
      );
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
          'StellarDatasource: sendTransaction - Error: Balance insuficiente',
        );
        throw Exception(
          'Balance insuficiente. Balance actual: $balance XLM, Monto a enviar: $amount XLM',
        );
      }

      final sourceAccount = await _sdk.accounts.account(
        sourceKeyPair.accountId,
      );
      debugPrint('StellarDatasource: sendTransaction - Cuenta fuente cargada');

      final transaction =
          TransactionBuilder(sourceAccount)
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
          'Error al enviar transacción: ${response.extras?.resultCodes?.transactionResultCode}',
        );
      }
    } catch (e) {
      debugPrint('StellarDatasource: sendTransaction - Excepción: $e');
      throw Exception('Error al enviar transacción: $e');
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
      throw Exception('Error al validar transacción: $e');
    }
  }
}
