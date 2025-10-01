import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/transactions/transaction_failure.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';
import 'package:nemorixpay/features/transactions/domain/repositories/transactions_repository.dart';

/// @file        get_transactions_usecase.dart
/// @brief       Use case for retrieving a list of transactions.
/// @details     Calls the repository to get the account transactions with
///              business logic validation and error handling.
/// @author      Miguel Fagundez
/// @date        09/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetTransactionsUseCase {
  final TransactionsRepository _repository;

  GetTransactionsUseCase(this._repository);

  /// Executes the use case to get transactions
  /// @return Either<Failure, List<TransactionListItemData>> List of transactions or error
  Future<Either<Failure, List<TransactionListItemData>>> call() async {
    debugPrint('GetTransactionsUseCase: call - Starting');

    try {
      final result = await _repository.getTransactions();

      return result.fold(
        (failure) {
          debugPrint(
              'GetTransactionsUseCase: call - Repository error: ${failure.message}');
          return Left(failure);
        },
        (transactions) {
          debugPrint(
              'GetTransactionsUseCase: call - Success: ${transactions.length} transactions');

          // Business logic: Sort transactions by date (newest first)
          final sortedTransactions =
              List<TransactionListItemData>.from(transactions)
                ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          debugPrint(
              'GetTransactionsUseCase: call - Sorted ${sortedTransactions.length} transactions');
          return Right(sortedTransactions);
        },
      );
    } catch (e) {
      debugPrint('GetTransactionsUseCase: call - Unexpected error: $e');
      return Left(
        TransactionsFailure(
          transactionMessage: 'Unexpected error getting transactions: $e',
          transactionCode: 'TRANSACTIONS_USECASE_ERROR',
        ),
      );
    }
  }
}
