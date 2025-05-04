import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:dio/dio.dart';
import 'package:bip39/bip39.dart' as bip39;

/// @file        stellar_service.dart
/// @brief       Service for Stellar network integration in NemorixPay.
/// @details     Provides methods for mnemonic generation, key derivation, and account creation on the Stellar testnet using the official Flutter SDK.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
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

  // Future methods: getBalance, sendTransaction, etc.
}
