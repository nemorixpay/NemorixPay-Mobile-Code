import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import 'package:nemorixpay/core/errors/wallet/wallet_error_codes.dart';
import 'package:nemorixpay/core/errors/wallet/wallet_failure.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart';
import '../models/wallet_model.dart';
import 'wallet_datasource.dart';

/// @file        wallet_datasource_impl.dart
/// @brief       Implementation of wallet data operations using Stellar.
/// @details     Provides concrete implementation of wallet operations by
///              interacting with the Stellar network through StellarDataSource.
///              Handles wallet creation, import, and balance retrieval with
///              proper error handling and data mapping.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class WalletDataSourceImpl implements WalletDataSource {
  final StellarDataSource _stellarDatasource;

  WalletDataSourceImpl({required StellarDataSource stellarDatasource})
    : _stellarDatasource = stellarDatasource;

  @override
  Future<List<String>> createSeedPhrase() async {
    try {
      debugPrint(
        'WalletDataSourceImpl - createSeedPhrase: Starting generateMnemonic creation',
      );
      final mnemonic = await _stellarDatasource.generateMnemonic();
      debugPrint(
        'WalletDataSourceImpl - createSeedPhrase: Mnemonic Phrase created successfully',
      );
      return mnemonic;
    } catch (error) {
      debugPrint(
        'WalletDataSourceImpl - createSeedPhrase: Unexpected error: $error',
      );
      // Mapeamos el error específico
      if (error.toString().contains('invalid mnemonic')) {
        debugPrint(
          'WalletDataSourceImpl - createSeedPhrase: Invalid mnemonic error',
        );
        throw WalletFailure.invalidMnemonic('Invalid Mnemonic. Try again!');
      }

      if (error.toString().contains('network error')) {
        debugPrint('WalletDataSourceImpl - createSeedPhrase: Network error');
        throw WalletFailure.networkError(
          'Connection error with Stellar network',
        );
      }

      debugPrint('WalletDataSourceImpl - createSeedPhrase: Unknown error');
      throw WalletFailure(
        walletMessage: 'An unexpected error occurred',
        walletCode: WalletErrorCode.unknown.code,
      );
    }
  }

  @override
  Future<WalletModel> createWallet(String mnemonic) async {
    try {
      debugPrint(
        'WalletDataSourceImpl - createWallet: Starting wallet creation',
      );
      final account = await _stellarDatasource.createAccount(
        mnemonic: mnemonic,
      );
      debugPrint(
        'WalletDataSourceImpl - createWallet: Account created successfully',
      );

      final wallet = WalletModel(
        publicKey: account.publicKey,
        secretKey: account.secretKey,
        balance: account.balance,
        mnemonic: mnemonic,
        createdAt: DateTime.now(),
      );
      debugPrint(
        'WalletDataSourceImpl - createWallet: Wallet model created successfully',
      );

      return wallet;
    } catch (error) {
      debugPrint(
        'WalletDataSourceImpl - createWallet: Unexpected error: $error',
      );
      if (error is WalletFailure) {
        debugPrint(
          'WalletDataSourceImpl - createWallet: Re-throwing WalletFailure',
        );
        rethrow;
      }

      // Mapeamos el error específico
      if (error.toString().contains('invalid mnemonic')) {
        debugPrint(
          'WalletDataSourceImpl - createWallet: Invalid mnemonic error',
        );
        throw WalletFailure.invalidMnemonic('Invalid Mnemonic. Try again!');
      }

      if (error.toString().contains('account not found')) {
        debugPrint(
          'WalletDataSourceImpl - createWallet: Account not found error',
        );
        throw WalletFailure.accountNotFound(
          'Wallet does not exist in the Stellar network',
        );
      }

      if (error.toString().contains('network error')) {
        debugPrint('WalletDataSourceImpl - createWallet: Network error');
        throw WalletFailure.networkError(
          'Connection error with Stellar network',
        );
      }

      debugPrint('WalletDataSourceImpl - createWallet: Unknown error');
      throw WalletFailure(
        walletMessage: 'An unexpected error occurred',
        walletCode: WalletErrorCode.unknown.code,
      );
    }
  }

  @override
  Future<WalletModel> importWallet(String mnemonic) async {
    try {
      debugPrint('WalletDataSourceImpl - importWallet: Starting wallet import');
      debugPrint('WalletDataSourceImpl - importWallet: Mnemonic: $mnemonic');

      final account = await _stellarDatasource.importAccount(
        mnemonic: mnemonic,
      );
      debugPrint(
        'WalletDataSourceImpl - importWallet: Account imported successfully',
      );

      final wallet = WalletModel(
        publicKey: account.publicKey,
        secretKey: account.secretKey,
        balance: account.balance,
        mnemonic: mnemonic,
        createdAt: DateTime.now(),
      );
      debugPrint(
        'WalletDataSourceImpl - importWallet: Wallet model created successfully',
      );

      return wallet;
    } catch (error) {
      final newError = error as StellarFailure;

      debugPrint(
        'WalletDataSourceImpl - importWallet: Unexpected error: ${newError.stellarMessage}',
      );
      if (error is WalletFailure) {
        debugPrint(
          'WalletDataSourceImpl - importWallet: Re-throwing WalletFailure',
        );
        rethrow;
      }

      // Mapeamos el error específico
      if (error.stellarMessage.toString().contains('Invalid Seed')) {
        debugPrint(
          'WalletDataSourceImpl - importWallet: Invalid mnemonic error',
        );
        throw WalletFailure.invalidMnemonic(error.stellarMessage);
      }

      if (error.stellarMessage.toString().contains('import failed')) {
        debugPrint('WalletDataSourceImpl - importWallet: Import failed error');
        throw WalletFailure.importFailed(
          'Failed to import wallet. Please, try again!',
        );
      }

      if (error.stellarMessage.toString().contains('network error')) {
        debugPrint('WalletDataSourceImpl - importWallet: Network error');
        throw WalletFailure.networkError(
          'Connection error with Stellar network. Please, try again!',
        );
      }

      debugPrint('WalletDataSourceImpl - importWallet: Unknown error');
      throw WalletFailure(
        walletMessage: 'An unexpected error occurred. Please, try again!',
        walletCode: WalletErrorCode.unknown.code,
      );
    }
  }

  @override
  Future<double> getWalletBalance(String publicKey) async {
    try {
      debugPrint(
        'WalletDataSourceImpl - getWalletBalance: Starting balance retrieval',
      );
      debugPrint(
        'WalletDataSourceImpl - getWalletBalance: Public key: $publicKey',
      );

      final balance = await _stellarDatasource.getAccountBalance(publicKey);
      debugPrint(
        'WalletDataSourceImpl - getWalletBalance: Balance retrieved successfully: $balance',
      );

      return balance;
    } catch (error) {
      debugPrint(
        'WalletDataSourceImpl - getWalletBalance: Unexpected error: $error',
      );
      if (error is WalletFailure) {
        debugPrint(
          'WalletDataSourceImpl - getWalletBalance: Re-throwing WalletFailure',
        );
        rethrow;
      }

      // Mapeamos el error específico
      if (error.toString().contains('insufficient funds')) {
        debugPrint(
          'WalletDataSourceImpl - getWalletBalance: Insufficient funds error',
        );
        throw WalletFailure.insufficientFunds('Insufficient Funds. Try again!');
      }

      if (error.toString().contains('account not found')) {
        debugPrint(
          'WalletDataSourceImpl - getWalletBalance: Account not found error',
        );
        throw WalletFailure.accountNotFound(
          'Wallet does not exist in the Stellar network',
        );
      }

      if (error.toString().contains('network error')) {
        debugPrint('WalletDataSourceImpl - getWalletBalance: Network error');
        throw WalletFailure.networkError(
          'Connection error with Stellar network',
        );
      }

      debugPrint('WalletDataSourceImpl - getWalletBalance: Unknown error');
      throw WalletFailure(
        walletMessage: 'An unexpected error occurred',
        walletCode: WalletErrorCode.unknown.code,
      );
    }
  }
}
