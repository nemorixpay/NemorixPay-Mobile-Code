import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_error_codes.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';
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
  final StellarDataSourceImpl datasource;

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
    } catch (failure) {
      debugPrint('StellarRepositoryImpl: generateMnemonic - Error: $failure');
      // Si ya es un StellarFailure, lo devolvemos como Left
      if (failure is StellarFailure) {
        return Left(failure);
      }
      // Si es otro tipo de error, lo convertimos a StellarFailure
      return Left(
        StellarFailure.unknown(
          'Error al obtener el generateMnemonic: $failure',
        ),
      );
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
      return Right(account.toEntity());
    } catch (failure) {
      debugPrint('StellarRepositoryImpl: createAccount - Error: $failure');
      // Si ya es un StellarFailure, lo devolvemos como Left
      if (failure is StellarFailure) {
        return Left(failure);
      }
      // Si es otro tipo de error, lo convertimos a StellarFailure
      return Left(
        StellarFailure.unknown('Error creating stellar account. Try again!'),
      );
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
      return Right(account.toEntity());
    } catch (failure) {
      debugPrint('StellarRepositoryImpl: importAccount - Error: $failure');
      // Si ya es un StellarFailure, lo devolvemos como Left
      if (failure is StellarFailure) {
        return Left(failure);
      }
      // Si es otro tipo de error, lo convertimos a StellarFailure
      return Left(
        StellarFailure.unknown(
          'Error al obtener al importar la cuenta de Stellar: $failure',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, double>> getAccountBalance(String publicKey) async {
    debugPrint(
      'StellarRepositoryImpl: getAccountBalance - Consultando balance para: $publicKey',
    );
    try {
      final balance = await datasource.getAccountBalance(publicKey);
      debugPrint(
        'StellarRepositoryImpl: getAccountBalance - Balance obtenido: $balance',
      );
      return Right(balance);
    } catch (failure) {
      debugPrint('StellarRepositoryImpl: getAccountBalance - Error: $failure');
      // Si ya es un StellarFailure, lo devolvemos como Left
      if (failure is StellarFailure) {
        return Left(failure);
      }
      // Si es otro tipo de error, lo convertimos a StellarFailure
      return Left(
        StellarFailure.unknown(
          'Error al obtener el balance de la cuenta de Stellar: $failure',
        ),
      );
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
      return Right(transaction.toEntity());
    } catch (failure) {
      debugPrint('StellarRepositoryImpl: sendPayment - Error: $failure');
      // Si ya es un StellarFailure, lo devolvemos como Left
      if (failure is StellarFailure) {
        return Left(failure);
      }
      // Si es otro tipo de error, lo convertimos a StellarFailure
      return Left(StellarFailure.unknown('Error al enviar un pago: $failure'));
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
      return Right(transaction.toEntity());
    } catch (failure) {
      debugPrint(
        'StellarRepositoryImpl: validateTransaction - Error: $failure',
      );
      // Si ya es un StellarFailure, lo devolvemos como Left
      if (failure is StellarFailure) {
        return Left(failure);
      }
      // Si es otro tipo de error, lo convertimos a StellarFailure
      return Left(
        StellarFailure.unknown('Error al validar una transaccion: $failure'),
      );
    }
  }

  @override
  Future<Either<Failure, List<AssetEntity>>> getAccountAssets(
    String publicKey,
  ) async {
    try {
      final assets = await datasource.getAccountAssets(publicKey);
      return Right(assets.map((asset) => asset.toEntity()).toList());
    } on StellarFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(
        StellarFailure(
          stellarCode: StellarErrorCode.unknown.code,
          stellarMessage:
              'Error al obtener los assets de la cuenta en el repositorio: $e',
        ),
      );
    }
  }

  /// Gets all available assets in the Stellar network
  /// @return Either<Failure, List<AssetEntity>> List of available assets or error
  @override
  Future<Either<Failure, List<AssetEntity>>> getAvailableAssets() async {
    try {
      final assets = await datasource.getAvailableAssets();
      debugPrint(
        'StellarRepositoryImpl: getAvailableAssets - Assets length: ${assets.length}',
      );
      return Right(assets.map((asset) => asset.toEntity()).toList());
    } on StellarFailure catch (failure) {
      debugPrint(
        'StellarRepositoryImpl: getAvailableAssets - StellarFailure: ${failure.message}',
      );
      return Left(failure);
    } catch (e) {
      debugPrint(
        'StellarRepositoryImpl: getAvailableAssets - General Error: $e',
      );
      return Left(
        StellarFailure(
          stellarCode: StellarErrorCode.unknown.code,
          stellarMessage: 'Error getting available assets in repository: $e',
        ),
      );
    }
  }

  /// Gets the transaction history for the current account
  /// @return Either<Failure, List<StellarTransaction>> List of transactions or error
  @override
  Future<Either<Failure, List<StellarTransaction>>> getTransactions() async {
    debugPrint(
      'StellarRepositoryImpl: getTransactions - Obteniendo historial de transacciones',
    );
    try {
      final transactions = await datasource.getTransactions();
      debugPrint(
        'StellarRepositoryImpl: getTransactions - Transacciones obtenidas: ${transactions.length}',
      );
      return Right(transactions.map((tx) => tx.toEntity()).toList());
    } on StellarFailure catch (failure) {
      debugPrint(
        'StellarRepositoryImpl: getTransactions - StellarFailure: ${failure.message}',
      );
      return Left(failure);
    } catch (e) {
      debugPrint(
        'StellarRepositoryImpl: getTransactions - General Error: $e',
      );
      return Left(
        StellarFailure(
          stellarCode: StellarErrorCode.unknown.code,
          stellarMessage: 'Error getting transactions in repository: $e',
        ),
      );
    }
  }
}
