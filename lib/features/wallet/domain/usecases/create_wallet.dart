import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

/// @file        create_wallet.dart
/// @brief       Use case for creating a new wallet.
/// @details     Handles the business logic for creating a new wallet,
///              including error handling and repository interaction.
///              Returns Either type with Failure or Wallet entity.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class CreateWallet {
  final WalletRepository repository;

  CreateWallet({required this.repository});

  Future<Either<Failure, Wallet>> call() async {
    debugPrint('CreateWallet');
    return await repository.createWallet();
  }
}
