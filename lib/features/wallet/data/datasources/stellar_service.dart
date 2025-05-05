import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:dio/dio.dart';
import 'package:bip39/bip39.dart' as bip39;

/// @file        stellar_service.dart
/// @brief       Service for Stellar network integration in NemorixPay.
/// @details     Provides methods for mnemonic generation, key derivation, account creation
///              and create/validate transactions on the Stellar testnet using the official Flutter SDK.
/// @author      Miguel Fagundez
/// @date        2025-05-04
/// @version     1.1
/// @copyright   Apache 2.0 License

/// Service responsible for interacting with the Stellar network
class StellarService {
  final StellarSDK sdk;
  StellarService({required this.sdk});

  /// Generates a BIP39 mnemonic phrase (12 or 24 words)
  /// 12 words: String mnemonic12 = bip39.generateMnemonic(strength: 128);
  /// 24 words: String mnemonic24 = bip39.generateMnemonic(strength: 256);
  String generateMnemonic({int strength = 128}) {
    return bip39.generateMnemonic(strength: strength);
  }

  /// Derives a KeyPair (public/private keys) from a mnemonic phrase
  Future<KeyPair> getKeyPairFromMnemonic(
    String mnemonic, {
    String passphrase = "",
  }) async {
    final seed = bip39.mnemonicToSeed(mnemonic, passphrase: passphrase);
    final stellarSeed = seed.sublist(0, 32);
    final secretSeed = StrKey.encodeStellarSecretSeed(stellarSeed);
    return KeyPair.fromSecretSeed(secretSeed);
  }

  /// Creates and funds a new account in the Stellar testnet using Friendbot
  Future<void> createAccountInTestnet(String publicKey) async {
    final url = 'https://friendbot.stellar.org/?addr=$publicKey';
    final response = await Dio().get(url);
    if (response.statusCode != 200) {
      throw Exception('Error creating account in testnet');
    }
  }

  /// Gets the XLM balance for a given public key
  Future<double> getBalance(String publicKey) async {
    final account = await sdk.accounts.account(publicKey);
    // Buscar el balance de XLM (asset_type == 'native')
    final xlmBalance = account.balances.firstWhere(
      (b) => b.assetType == 'native',
      orElse: () => throw Exception('No XLM balance found'),
    );
    return double.tryParse(xlmBalance.balance) ?? 0.0;
  }

  /// Sends XLM from source account to destination account
  Future<String> sendTransaction({
    required String sourceSecretSeed,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  }) async {
    try {
      // Create source KeyPair from secret seed
      final sourceKeyPair = KeyPair.fromSecretSeed(sourceSecretSeed);

      // Verificar balance antes de proceder
      final balance = await getBalance(sourceKeyPair.accountId);
      if (balance < amount) {
        throw Exception(
          'Balance insuficiente. Balance actual: $balance XLM, Monto a enviar: $amount XLM',
        );
      }

      // Load source account
      final sourceAccount = await sdk.accounts.account(sourceKeyPair.accountId);

      // Create transaction
      final transaction =
          TransactionBuilder(sourceAccount)
              .addOperation(
                PaymentOperationBuilder(
                  destinationPublicKey, // destination account ID
                  Asset.NATIVE, // asset type (XLM)
                  amount.toString(), // amount to send
                ).build(),
              )
              .addMemo(Memo.text("NemorixPay Transfer: $memo"))
              .build();

      // Sign transaction
      transaction.sign(sourceKeyPair, Network.TESTNET);

      // Submit transaction
      final response = await sdk.submitTransaction(transaction);

      // Check if transaction was successful
      final String transactionHash = response.hash ?? '';
      if (response.success && transactionHash.isNotEmpty) {
        return transactionHash;
      } else {
        throw Exception(
          'Error al enviar transacción: ${response.extras?.resultCodes?.transactionResultCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al enviar transacción: $e');
    }
  }

  /// Validates a transaction by its hash
  Future<Map<String, dynamic>> validateTransaction(
    String transactionHash,
  ) async {
    try {
      // Solo normalizar el hash a minúsculas y eliminar espacios
      final normalizedHash = transactionHash.toLowerCase().trim();

      final transaction = await sdk.transactions.transaction(normalizedHash);
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
