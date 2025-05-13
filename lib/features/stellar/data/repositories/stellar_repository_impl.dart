import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/stellar_failure.dart';
import '../../domain/entities/stellar_account.dart';
import '../../domain/entities/stellar_transaction.dart';
import '../../domain/repositories/stellar_repository.dart';
import '../datasources/stellar_datasource.dart';

/// @file        stellar_repository_impl.dart
/// @brief       Implementation of the Stellar repository.
/// @details     Provides concrete implementation of Stellar network operations
///              using the StellarDatasource.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarRepositoryImpl implements StellarRepository {
  final StellarDatasource datasource;

  StellarRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<String>>> generateMnemonic({
    int strength = 256,
  }) async {
    try {
      final mnemonic = datasource.generateMnemonic(strength: strength);
      debugPrint('StellarRepositoryImpl: generateMnemonic');
      debugPrint(mnemonic.toString());
      return Right(mnemonic);
    } catch (e) {
      return Left(StellarFailure.fromException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, StellarAccount>> createAccount({
    required String mnemonic,
    String passphrase = "",
  }) async {
    try {
      final keyPair = await datasource.getKeyPairFromMnemonic(
        mnemonic,
        passphrase: passphrase,
      );

      await datasource.createAccountInTestnet(keyPair.accountId);

      final account = StellarAccount(
        publicKey: keyPair.accountId,
        secretKey: keyPair.secretSeed,
        balance: 0.0, // La cuenta nueva comienza con 0 XLM
        mnemonic: mnemonic,
        createdAt: DateTime.now(),
      );

      return Right(account);
    } catch (e) {
      return Left(StellarFailure.accountError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StellarAccount>> getAccountBalance(
    String publicKey,
  ) async {
    try {
      final balance = await datasource.getBalance(publicKey);

      final account = StellarAccount(
        publicKey: publicKey,
        balance: balance,
        createdAt: DateTime.now(),
      );

      return Right(account);
    } catch (e) {
      return Left(StellarFailure.accountError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StellarTransaction>> sendPayment({
    required String sourceSecretKey,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  }) async {
    try {
      final transactionHash = await datasource.sendTransaction(
        sourceSecretSeed: sourceSecretKey,
        destinationPublicKey: destinationPublicKey,
        amount: amount,
        memo: memo,
      );

      final transactionDetails = await datasource.validateTransaction(
        transactionHash,
      );

      final transaction = StellarTransaction(
        hash: transactionHash,
        sourceAccount: transactionDetails['sourceAccount'] as String,
        destinationAccount: destinationPublicKey,
        amount: amount,
        memo: memo,
        successful: transactionDetails['successful'] as bool,
        ledger: transactionDetails['ledger'] as int?,
        createdAt: DateTime.parse(transactionDetails['createdAt'] as String),
        feeCharged: transactionDetails['feeCharged'].toString(),
      );

      return Right(transaction);
    } catch (e) {
      return Left(StellarFailure.transactionError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StellarTransaction>> validateTransaction(
    String transactionHash,
  ) async {
    try {
      final transactionDetails = await datasource.validateTransaction(
        transactionHash,
      );

      final transaction = StellarTransaction(
        hash: transactionHash,
        sourceAccount: transactionDetails['sourceAccount'] as String,
        destinationAccount: '', // No disponible en la validación
        amount: 0.0, // No disponible en la validación
        successful: transactionDetails['successful'] as bool,
        ledger: transactionDetails['ledger'] as int?,
        createdAt: DateTime.parse(transactionDetails['createdAt'] as String),
        feeCharged: transactionDetails['feeCharged'].toString(),
      );

      return Right(transaction);
    } catch (e) {
      return Left(StellarFailure.transactionError(e.toString()));
    }
  }
}
