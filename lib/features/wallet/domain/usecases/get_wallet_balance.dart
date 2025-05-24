import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../repositories/wallet_repository.dart';
import 'package:nemorixpay/core/errors/failures.dart';

/// @file        get_wallet_balance.dart
/// @brief       Use case for retrieving wallet balance.
/// @details     Handles the business logic for getting a wallet's balance
///              using its public key, including error handling and repository
///              interaction. Returns Either type with Failure or Wallet entity.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetWalletBalanceUseCase {
  final WalletRepository repository;

  GetWalletBalanceUseCase({required this.repository});

  Future<Either<Failure, double>> call(String publicKey) async {
    debugPrint('GetWalletBalanceUseCase: GetWalletBalance');
    return await repository.getWalletBalance(publicKey);
  }
}
