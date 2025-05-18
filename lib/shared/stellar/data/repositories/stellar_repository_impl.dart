import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_account.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_transaction.dart';
import 'package:nemorixpay/shared/stellar/domain/repositories/stellar_repository.dart';
import 'package:flutter/foundation.dart';

/// @file        stellar_repository_impl.dart
/// @brief       Implementation of the Stellar repository interface.
/// @details     This class implements the StellarRepository interface, providing
///              concrete implementations for all Stellar network operations.
/// @author      Miguel Fagundez
/// @date        2025-05-13
/// @version     1.1
/// @copyright   Apache 2.0 License

class StellarRepositoryImpl implements StellarRepository {
  final StellarDatasource datasource;

  StellarRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<String>>> generateMnemonic({
    int strength = 256,
  }) async {
    debugPrint(
      'StellarRepositoryImpl: generateMnemonic - Iniciando generación',
    );
    try {
      final mnemonic = await datasource.generateMnemonic(strength: strength);
      debugPrint(
        'StellarRepositoryImpl: generateMnemonic - Mnemonic generado exitosamente',
      );
      return Right(mnemonic);
    } on Exception catch (e) {
      debugPrint('StellarRepositoryImpl: generateMnemonic - Error: $e');
      return Left(StellarFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, StellarAccount>> createAccount({
    required String mnemonic,
    String passphrase = "",
  }) async {
    debugPrint(
      'StellarRepositoryImpl: createAccount - Iniciando creación de cuenta',
    );
    debugPrint('StellarRepositoryImpl: createAccount - Mnemonic: $mnemonic');
    try {
      final account = await datasource.createAccount(
        mnemonic: mnemonic,
        passphrase: passphrase,
      );
      debugPrint(
        'StellarRepositoryImpl: createAccount - Cuenta creada exitosamente: ${account.publicKey}',
      );
      return Right(account);
    } on Exception catch (e) {
      debugPrint('StellarRepositoryImpl: createAccount - Error: $e');
      return Left(StellarFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, StellarAccount>> importAccount({
    required String mnemonic,
    String passphrase = "",
  }) async {
    debugPrint(
      'StellarRepositoryImpl: importAccount - Iniciando importación de cuenta',
    );
    debugPrint('StellarRepositoryImpl: importAccount - Mnemonic: $mnemonic');
    try {
      final account = await datasource.importAccount(
        mnemonic: mnemonic,
        passphrase: passphrase,
      );
      debugPrint(
        'StellarRepositoryImpl: importAccount - Cuenta importada exitosamente: ${account.publicKey}',
      );
      return Right(account);
    } on Exception catch (e) {
      debugPrint('StellarRepositoryImpl: importAccount - Error: $e');
      return Left(StellarFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, StellarAccount>> getAccountBalance(
    String publicKey,
  ) async {
    debugPrint(
      'StellarRepositoryImpl: getAccountBalance - Consultando balance para: $publicKey',
    );
    try {
      final account = await datasource.getAccountBalance(publicKey);
      debugPrint(
        'StellarRepositoryImpl: getAccountBalance - Balance obtenido: ${account.balance}',
      );
      return Right(account);
    } on Exception catch (e) {
      debugPrint('StellarRepositoryImpl: getAccountBalance - Error: $e');
      return Left(StellarFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, StellarTransaction>> sendPayment({
    required String sourceSecretKey,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  }) async {
    debugPrint('StellarRepositoryImpl: sendPayment - Iniciando envío de pago');
    debugPrint(
      'StellarRepositoryImpl: sendPayment - Destino: $destinationPublicKey',
    );
    debugPrint('StellarRepositoryImpl: sendPayment - Monto: $amount');
    try {
      final transaction = await datasource.sendPayment(
        sourceSecretKey: sourceSecretKey,
        destinationPublicKey: destinationPublicKey,
        amount: amount,
        memo: memo,
      );
      debugPrint(
        'StellarRepositoryImpl: sendPayment - Transacción exitosa: ${transaction.hash}',
      );
      return Right(transaction);
    } on Exception catch (e) {
      debugPrint('StellarRepositoryImpl: sendPayment - Error: $e');
      return Left(StellarFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, StellarTransaction>> validateTransaction(
    String transactionHash,
  ) async {
    debugPrint(
      'StellarRepositoryImpl: validateTransaction - Validando transacción: $transactionHash',
    );
    try {
      final transaction = await datasource.validateTransaction(transactionHash);
      debugPrint(
        'StellarRepositoryImpl: validateTransaction - Transacción validada: ${transaction.successful}',
      );
      return Right(transaction);
    } on Exception catch (e) {
      debugPrint('StellarRepositoryImpl: validateTransaction - Error: $e');
      return Left(StellarFailure.fromException(e));
    }
  }
}
