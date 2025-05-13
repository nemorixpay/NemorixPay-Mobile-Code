import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../entities/stellar_account.dart';
import '../repositories/stellar_repository.dart';

/// @file        get_account_balance_usecase.dart
/// @brief       Get account balance use case for NemorixPay Stellar feature.
/// @details     This use case handles retrieving the current balance of a
///              Stellar account.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetAccountBalanceUseCase {
  final StellarRepository repository;

  GetAccountBalanceUseCase({required this.repository});

  Future<Either<Failure, StellarAccount>> call(String publicKey) async {
    debugPrint('GetAccountBalanceUseCase');
    return await repository.getAccountBalance(publicKey);
  }
}
