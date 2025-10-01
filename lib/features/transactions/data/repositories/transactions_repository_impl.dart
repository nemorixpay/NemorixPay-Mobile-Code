import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/transactions/transaction_failure.dart';
import 'package:nemorixpay/features/transactions/data/datasources/transactions_datasource.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';
import 'package:nemorixpay/features/transactions/domain/repositories/transactions_repository.dart';

/// @file        transactions_repository_impl.dart
/// @brief       Implementation of TransactionsRepository using local/Stellar datasource.
/// @details     Provides concrete implementation for transaction data operations,
///              handling errors and mapping data from datasource to domain entities.
/// @author      Miguel Fagundez
/// @date        09/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsDatasource _datasource;

  TransactionsRepositoryImpl({
    required TransactionsDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Failure, List<TransactionListItemData>>>
      getTransactions() async {
    debugPrint('TransactionsRepositoryImpl: getTransactions - Starting');

    try {
      final transactions = await _datasource.getTransactions();
      debugPrint(
          'TransactionsRepositoryImpl: getTransactions - Success: ${transactions.length} transactions');
      return Right(transactions);
    } catch (e) {
      debugPrint('TransactionsRepositoryImpl: getTransactions - Error: $e');
      return Left(
        TransactionsFailure(
          transactionMessage: 'Failed to get transactions: $e',
          transactionCode: 'TRANSACTIONS_GET_ERROR',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TransactionListItemData>>>
      refreshTransactions() async {
    debugPrint('TransactionsRepositoryImpl: refreshTransactions - Starting');

    try {
      final transactions = await _datasource.refreshTransactions();
      debugPrint(
          'TransactionsRepositoryImpl: refreshTransactions - Success: ${transactions.length} fresh transactions');
      return Right(transactions);
    } catch (e) {
      debugPrint('TransactionsRepositoryImpl: refreshTransactions - Error: $e');
      return Left(
        TransactionsFailure(
          transactionMessage: 'Failed to refresh transactions: $e',
          transactionCode: 'TRANSACTIONS_REFRESH_ERROR',
        ),
      );
    }
  }
}
