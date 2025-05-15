import 'package:flutter/foundation.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:dio/dio.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:nemorixpay/features/stellar/domain/entities/stellar_account.dart';
import 'package:nemorixpay/features/stellar/domain/entities/stellar_transaction.dart';
import 'package:nemorixpay/core/errors/stellar_failure.dart';
import 'package:nemorixpay/core/errors/stellar_error_codes.dart';

/// @file        stellar_datasource.dart
/// @brief       Service for Stellar network integration in NemorixPay.
/// @details     Provides methods for mnemonic generation, key derivation, account creation
///              and create/validate transactions on the Stellar testnet using the official Flutter SDK.
/// @author      Miguel Fagundez
/// @date        2025-05-15
/// @version     1.2
/// @copyright   Apache 2.0 License

/// Service responsible for interacting with the Stellar network
class StellarDatasource {
  late final StellarSDK _sdk;

  StellarDatasource() {
    _sdk = StellarSDK.TESTNET;
  }

  /// Generates a mnemonic phrase (12 or 24 words)
  /// @param strength Strength of the mnemonic phrase (128 for 12 words, 256 for 24 words)
  /// @return List of mnemonic words
  Future<List<String>> generateMnemonic({int strength = 256}) async {
    final mnemonic = bip39.generateMnemonic(strength: strength);
    debugPrint('StellarDatasource: generateMnemonic');
    debugPrint(mnemonic);
    return mnemonic.split(' ');
  }

  /// Creates a new Stellar account from a mnemonic phrase
  Future<StellarAccount> createAccount({
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

    return StellarAccount(
      publicKey: keyPair.accountId,
      secretKey: keyPair.secretSeed,
      balance: 0.0,
      mnemonic: mnemonic,
      createdAt: DateTime.now(),
    );
  }

  /// Gets the current balance of a Stellar account
  Future<StellarAccount> getAccountBalance(String publicKey) async {
    try {
      // Validate public key format
      if (!publicKey.startsWith('G') || publicKey.length != 56) {
        throw StellarFailure(
          stellarCode: StellarErrorCode.invalidPublicKey.code,
          stellarMessage: 'La clave pública no es válida',
        );
      }

      final balance = await getBalance(publicKey);
      return StellarAccount(
        publicKey: publicKey,
        balance: balance,
        createdAt: DateTime.now(),
      );
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
  Future<StellarTransaction> sendPayment({
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
      return StellarTransaction(
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
  Future<StellarTransaction> validateTransaction(String transactionHash) async {
    final details = await _validateTransaction(transactionHash);
    return StellarTransaction(
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
  Future<StellarAccount> importAccount({
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
        return StellarAccount(
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

  // Private helper methods
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

  Future<double> getBalance(String publicKey) async {
    final account = await _sdk.accounts.account(publicKey);
    final xlmBalance = account.balances.firstWhere(
      (b) => b.assetType == 'native',
      orElse: () => throw Exception('No XLM balance found'),
    );
    return double.tryParse(xlmBalance.balance) ?? 0.0;
  }

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
