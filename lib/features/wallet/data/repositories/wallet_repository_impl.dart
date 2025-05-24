import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/wallet/wallet_failure.dart';
import 'package:nemorixpay/features/wallet/data/datasources/wallet_datasource.dart';
import 'package:nemorixpay/features/wallet/domain/entities/wallet.dart';
import 'package:nemorixpay/features/wallet/domain/repositories/wallet_repository.dart';

/// @file        wallet_repository_impl.dart
/// @brief       Implementation of the wallet repository.
/// @details     Provides concrete implementation of wallet operations by
///              coordinating between the domain layer and data sources.
///              Handles error mapping and data transformation between
///              data models and domain entities.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class WalletRepositoryImpl implements WalletRepository {
  final WalletDataSource _dataSource;

  WalletRepositoryImpl({required WalletDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<String>>> createSeedPhrase() async {
    try {
      final seedPhrase = await _dataSource.createSeedPhrase();
      return Right(seedPhrase);
    } catch (e) {
      debugPrint('WalletRepositoryImpl: createSeedPhrase - Error: $e');
      // Si ya es un WalletFailure, lo devolvemos como Left
      if (e is WalletFailure) {
        return Left(e);
      }

      // Si es otro tipo de error, lo convertimos a WalletFailure
      return Left(
        WalletFailure.unknown('Error al obtener el balance de la cuenta: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Wallet>> createWallet(String nmemonic) async {
    try {
      final walletModel = await _dataSource.createWallet(nmemonic);
      return Right(walletModel.toEntity());
    } catch (e) {
      debugPrint('WalletRepositoryImpl: createWallet - Error: $e');

      // Si ya es un WalletFailure, lo devolvemos como Left
      if (e is WalletFailure) {
        return Left(e);
      }

      // Si es otro tipo de error, lo convertimos a WalletFailure
      return Left(
        WalletFailure.unknown('Error al crear la cuenta. Try again!'),
      );
    }
  }

  @override
  Future<Either<Failure, Wallet>> importWallet(String mnemonic) async {
    try {
      final walletModel = await _dataSource.importWallet(mnemonic);
      return Right(walletModel.toEntity());
    } catch (e) {
      debugPrint('WalletRepositoryImpl: importWallet - Error: $e');
      // Si ya es un WalletFailure, lo devolvemos como Left
      if (e is WalletFailure) {
        return Left(e);
      }

      // Si es otro tipo de error, lo convertimos a StellarFailure
      return Left(WalletFailure.unknown('Error al importar la cuenta: $e'));
    }
  }

  @override
  Future<Either<Failure, double>> getWalletBalance(String publicKey) async {
    try {
      final balance = await _dataSource.getWalletBalance(publicKey);
      return Right(balance);
    } catch (e) {
      debugPrint('WalletRepositoryImpl: getWalletBalance - Error: $e');
      // Si ya es un WalletFailure, lo devolvemos como Left
      if (e is WalletFailure) {
        return Left(e);
      }

      // Si es otro tipo de error, lo convertimos a WalletFailure
      return Left(
        WalletFailure.unknown(
          'Error al obtener el balance de la cuenta. Try again!',
        ),
      );
    }
  }
}
