import 'package:nemorixpay/features/wallet/domain/entity/wallet_entity.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';
import 'package:nemorixpay/shared/stellar/domain/entity/stellar_account_model.dart';
import 'package:nemorixpay/shared/stellar/domain/entity/stellar_transaction_model.dart';
import 'package:nemorixpay/shared/stellar/domain/entity/stellar_failure.dart';

class WalletDataSourceImpl {
  final StellarDataSourceImpl _stellarDataSource;

  WalletDataSourceImpl(this._stellarDataSource);

  Future<WalletEntity> createWallet({String passphrase = ""}) async {
    final mnemonic = await _stellarDataSource.generateMnemonic();
    final account = await _stellarDataSource.createAccount(
      mnemonic: mnemonic.join(' '),
      passphrase: passphrase,
    );

    return WalletEntity(
      publicKey: account.publicKey,
      secretKey: account.secretKey,
      balance: account.balance,
      mnemonic: account.mnemonic,
      createdAt: account.createdAt,
    );
  }

  Future<WalletEntity> importWallet({
    required String mnemonic,
    String passphrase = "",
  }) async {
    try {
      final account = await _stellarDataSource.importAccount(
        mnemonic: mnemonic,
        passphrase: passphrase,
      );

      return WalletEntity(
        publicKey: account.publicKey,
        secretKey: account.secretKey,
        balance: account.balance,
        mnemonic: account.mnemonic,
        createdAt: account.createdAt,
      );
    } on StellarFailure catch (e) {
      throw WalletFailure(
        walletCode: e.stellarCode,
        walletMessage: e.stellarMessage,
      );
    }
  }

  Future<double> getWalletBalance(String publicKey) async {
    try {
      return await _stellarDataSource.getAccountBalance(publicKey);
    } on StellarFailure catch (e) {
      throw WalletFailure(
        walletCode: e.stellarCode,
        walletMessage: e.stellarMessage,
      );
    }
  }

  Future<StellarTransactionModel> sendPayment({
    required String sourceSecretKey,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  }) async {
    try {
      return await _stellarDataSource.sendPayment(
        sourceSecretKey: sourceSecretKey,
        destinationPublicKey: destinationPublicKey,
        amount: amount,
        memo: memo,
      );
    } on StellarFailure catch (e) {
      throw WalletFailure(
        walletCode: e.stellarCode,
        walletMessage: e.stellarMessage,
      );
    }
  }
}
