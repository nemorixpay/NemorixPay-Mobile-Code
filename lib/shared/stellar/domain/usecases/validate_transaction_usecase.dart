import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../entities/stellar_transaction.dart';
import '../repositories/stellar_repository.dart';

/// @file        validate_transaction_usecase.dart
/// @brief       Validate transaction use case for NemorixPay Stellar feature.
/// @details     This use case handles the validation of Stellar transactions
///              by their hash.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class ValidateTransactionUseCase {
  final StellarRepository repository;

  ValidateTransactionUseCase({required this.repository});

  Future<Either<Failure, StellarTransaction>> call(
    String transactionHash,
  ) async {
    debugPrint('ValidateTransactionUseCase');
    return await repository.validateTransaction(transactionHash);
  }
}
