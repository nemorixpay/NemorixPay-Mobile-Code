/// @file        transactions_analytics_service.dart
/// @brief       Service for managing transaction analytics operations.
/// @details     This service provides high-level operations for transaction analytics tracking,
///              including transaction tracking and data retrieval. It acts as a
///              business logic layer between the presentation layer and the data layer.
/// @author      Miguel Fagundez
/// @date        04/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'dart:io';
import '../data/datasources/transactions_analytics_datasource.dart';
import '../data/models/transaction_analytics_model.dart';

class TransactionsAnalyticsService {
  final TransactionsAnalyticsDatasource _datasource;

  const TransactionsAnalyticsService({
    required TransactionsAnalyticsDatasource datasource,
  }) : _datasource = datasource;

  /// Tracks a new transaction for analytics purposes
  ///
  /// [transactionId] - The unique identifier of the transaction (hash)
  /// [assetAmount] - The amount of the asset being transacted
  /// [assetCode] - The code of the asset (XLM, USDC)
  /// [feeCharged] - The fee charged for the transaction
  /// [fiatAmount] - The fiat equivalent amount
  /// [fiatSymbol] - The fiat symbol (US, EUR, etc.)
  /// [location] - The country/region of the transaction
  /// [type] - The type of transaction (send, receive)
  ///
  /// Returns the created TransactionAnalyticsModel object.
  ///
  /// Throws an exception if the operation fails.
  Future<TransactionAnalyticsModel> trackTransaction({
    required String transactionId,
    required double assetAmount,
    required String assetCode,
    required double feeCharged,
    required double fiatAmount,
    required String fiatSymbol,
    required String location,
    required String type,
  }) async {
    try {
      final transactionModel = TransactionAnalyticsModel(
        id: transactionId,
        assetAmount: assetAmount,
        assetCode: assetCode,
        createdAt: DateTime.now(),
        feeCharged: feeCharged,
        fiatAmount: fiatAmount,
        fiatSymbol: fiatSymbol,
        location: location,
        platform: getCurrentPlatform(),
        type: type,
      );

      return await _datasource.createTransaction(transactionModel);
    } catch (e) {
      throw Exception('Failed to track transaction: $e');
    }
  }

  /// Retrieves all transactions from the analytics database
  ///
  /// Returns a list of all TransactionAnalyticsModel objects.
  ///
  /// Throws an exception if the operation fails.
  Future<List<TransactionAnalyticsModel>> getAllTransactions() async {
    try {
      return await _datasource.getTransactions();
    } catch (e) {
      throw Exception('Failed to retrieve transactions: $e');
    }
  }

  /// Gets the current platform string based on the running platform
  ///
  /// Returns 'ios' for iOS, 'android' for Android, or 'web' for web platform.
  static String getCurrentPlatform() {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'web';
    }
  }

  /// Creates a TransactionAnalyticsModel with current date and platform information
  ///
  /// [transactionId] - The unique identifier of the transaction
  /// [assetAmount] - The amount of the asset being transacted
  /// [assetCode] - The code of the asset (XLM, USDC)
  /// [feeCharged] - The fee charged for the transaction
  /// [fiatAmount] - The fiat equivalent amount
  /// [fiatSymbol] - The fiat symbol (US, EUR, etc.)
  /// [location] - The country/region of the transaction
  /// [type] - The type of transaction (send, receive)
  ///
  /// Returns a TransactionAnalyticsModel with current date and platform information.
  TransactionAnalyticsModel createTransactionModelWithCurrentDate({
    required String transactionId,
    required double assetAmount,
    required String assetCode,
    required double feeCharged,
    required double fiatAmount,
    required String fiatSymbol,
    required String location,
    required String type,
  }) {
    return TransactionAnalyticsModel(
      id: transactionId,
      assetAmount: assetAmount,
      assetCode: assetCode,
      createdAt: DateTime.now(),
      feeCharged: feeCharged,
      fiatAmount: fiatAmount,
      fiatSymbol: fiatSymbol,
      location: location,
      platform: getCurrentPlatform(),
      type: type,
    );
  }
}
