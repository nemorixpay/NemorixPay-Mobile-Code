/// @file        transactions_analytics_datasource.dart
/// @brief       Abstract interface for transaction analytics data operations.
/// @details     This abstract class defines the contract for transaction analytics
///              data operations, including creating and retrieving transaction data
///              from Firebase Realtime Database.
/// @author      Miguel Fagundez
/// @date        04/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

import '../models/transaction_analytics_model.dart';

/// Abstract interface for transaction analytics data operations
abstract class TransactionsAnalyticsDatasource {
  /// Creates a new transaction analytics record
  ///
  /// [transaction] - The TransactionAnalyticsModel to create
  ///
  /// Returns the created TransactionAnalyticsModel.
  ///
  /// Throws an exception if the operation fails.
  Future<TransactionAnalyticsModel> createTransaction(
      TransactionAnalyticsModel transaction);

  /// Retrieves all transaction analytics records
  ///
  /// Returns a list of all TransactionAnalyticsModel objects.
  ///
  /// Throws an exception if the operation fails.
  Future<List<TransactionAnalyticsModel>> getTransactions();
}
