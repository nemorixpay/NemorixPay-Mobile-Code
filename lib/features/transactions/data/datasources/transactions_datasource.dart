import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';

/// @file        transactions_datasource.dart
/// @brief       Local datasource for Transactions.
/// @details     Provides access to account transactions.
/// @author      Miguel Fagundez
/// @date        09/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class TransactionsDatasource {
  /// Gets the list of account transactions
  Future<List<TransactionListItemData>> getTransactions();

  /// Gets the new list of account transactions
  Future<List<TransactionListItemData>> refreshTransactions();
}
