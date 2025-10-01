import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/transactions/transaction_failure.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';
import 'package:nemorixpay/features/transactions/domain/repositories/transactions_repository.dart';

/// @file        refresh_transactions_usecase.dart
/// @brief       Use case for refreshing transaction list.
/// @details     Calls the repository to refresh the account transactions with
///              business logic validation and error handling.
/// @author      Miguel Fagundez
/// @date        09/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class RefreshTransactionsUseCase {
  final TransactionsRepository _repository;

  RefreshTransactionsUseCase(this._repository);

  /// Executes the use case to refresh transactions
  /// @return Either<Failure, List<TransactionListItemData>> List of fresh transactions or error
  Future<Either<Failure, List<TransactionListItemData>>> call() async {
    debugPrint('RefreshTransactionsUseCase: call - Starting');

    try {
      final result = await _repository.refreshTransactions();

      return result.fold(
        (failure) {
          debugPrint(
              'RefreshTransactionsUseCase: call - Repository error: ${failure.message}');
          return Left(failure);
        },
        (transactions) {
          debugPrint(
              'RefreshTransactionsUseCase: call - Success: ${transactions.length} fresh transactions');

          // Business logic: Sort transactions by date (newest first)
          final sortedTransactions =
              List<TransactionListItemData>.from(transactions)
                ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          debugPrint(
              'RefreshTransactionsUseCase: call - Sorted ${sortedTransactions.length} fresh transactions');
          return Right(sortedTransactions);
        },
      );
    } catch (e) {
      debugPrint('RefreshTransactionsUseCase: call - Unexpected error: $e');
      return Left(
        TransactionsFailure(
          transactionMessage: 'Unexpected error refreshing transactions: $e',
          transactionCode: 'TRANSACTIONS_REFRESH_USECASE_ERROR',
        ),
      );
    }
  }
}
