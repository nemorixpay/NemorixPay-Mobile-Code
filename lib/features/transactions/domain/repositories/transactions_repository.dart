import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';

/// @file        transactions_repository.dart
/// @brief       Repository interface for Transactions feature.
/// @details     Defines contract for managing app transactions data.
/// @author      Miguel Fagundez
/// @date        09/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class TransactionsRepository {
  /// Gets the current account transactions
  Future<Either<Failure, List<TransactionListItemData>>> getTransactions();
}
