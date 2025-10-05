/// @file        transactions_analytics_datasource_impl.dart
/// @brief       Implementation of transaction analytics datasource for Firebase.
/// @details     This class implements the TransactionsAnalyticsDatasource interface
///              using HTTP client to communicate with Firebase Realtime Database.
///              It handles GET and POST operations for transaction analytics data.
/// @author      Miguel Fagundez
/// @date        04/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nemorixpay/config/constants/app_constants.dart';
import '../models/transaction_analytics_model.dart';
import 'transactions_analytics_datasource.dart';

/// Implementation of TransactionsAnalyticsDatasource for Firebase Realtime Database
class TransactionsAnalyticsDatasourceImpl
    implements TransactionsAnalyticsDatasource {
  final http.Client _httpClient;
  static const String _baseUrl = AppConstants.analyticsBaseUrl;
  static const String _transactionsEndpoint =
      AppConstants.analyticsTransactionsEndpoint;

  const TransactionsAnalyticsDatasourceImpl({
    required http.Client httpClient,
  }) : _httpClient = httpClient;

  /// Creates a new transaction analytics record in Firebase
  ///
  /// [transaction] - The TransactionAnalyticsModel to create
  ///
  /// Returns the created TransactionAnalyticsModel.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<TransactionAnalyticsModel> createTransaction(
      TransactionAnalyticsModel transaction) async {
    try {
      debugPrint(
          'TransactionsAnalyticsDatasourceImpl: createTransaction - Starting');
      debugPrint(
          'TransactionsAnalyticsDatasourceImpl: createTransaction - Transaction ID: ${transaction.id}');

      // First, get all existing transactions to determine the next key
      final existingTransactions = await getTransactions();
      final nextKey = existingTransactions.length;

      debugPrint(
          'TransactionsAnalyticsDatasourceImpl: createTransaction - Next key: $nextKey');

      // Use PUT request to create transaction with sequential numeric key
      final response = await _httpClient.put(
        Uri.parse('$_baseUrl/transactions/$nextKey.json'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(transaction.toJson()),
      );

      if (response.statusCode == 200) {
        debugPrint(
            'TransactionsAnalyticsDatasourceImpl: createTransaction - Success');
        return transaction;
      } else {
        debugPrint(
            'TransactionsAnalyticsDatasourceImpl: createTransaction - Error: ${response.statusCode}');
        throw Exception('Failed to create transaction: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(
          'TransactionsAnalyticsDatasourceImpl: createTransaction - Exception: $e');
      rethrow;
    }
  }

  /// Retrieves all transaction analytics records from Firebase
  ///
  /// Returns a list of all TransactionAnalyticsModel objects.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<List<TransactionAnalyticsModel>> getTransactions() async {
    try {
      debugPrint(
          'TransactionsAnalyticsDatasourceImpl: getTransactions - Starting');

      final response = await _httpClient.get(
        Uri.parse('$_baseUrl$_transactionsEndpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        debugPrint(
            'TransactionsAnalyticsDatasourceImpl: getTransactions - Response received');

        if (responseBody.isEmpty || responseBody == 'null') {
          debugPrint(
              'TransactionsAnalyticsDatasourceImpl: getTransactions - No transactions found');
          return [];
        }

        final dynamic jsonData = jsonDecode(responseBody);
        debugPrint(
            'TransactionsAnalyticsDatasourceImpl: getTransactions - JSON parsed');

        List<TransactionAnalyticsModel> transactions = [];

        if (jsonData is List) {
          // Handle array format
          debugPrint(
              'TransactionsAnalyticsDatasourceImpl: getTransactions - Processing array format');
          for (int i = 0; i < jsonData.length; i++) {
            if (jsonData[i] != null) {
              try {
                final transaction =
                    TransactionAnalyticsModel.fromJson(jsonData[i]);
                transactions.add(transaction);
              } catch (e) {
                debugPrint(
                    'TransactionsAnalyticsDatasourceImpl: getTransactions - Error parsing transaction at index $i: $e');
              }
            }
          }
        } else if (jsonData is Map) {
          // Handle map format (numeric keys)
          debugPrint(
              'TransactionsAnalyticsDatasourceImpl: getTransactions - Processing map format');
          jsonData.forEach((key, value) {
            if (value != null) {
              try {
                final transaction = TransactionAnalyticsModel.fromJson(value);
                transactions.add(transaction);
              } catch (e) {
                debugPrint(
                    'TransactionsAnalyticsDatasourceImpl: getTransactions - Error parsing transaction with key $key: $e');
              }
            }
          });
        }

        debugPrint(
            'TransactionsAnalyticsDatasourceImpl: getTransactions - Success: ${transactions.length} transactions');
        return transactions;
      } else {
        debugPrint(
            'TransactionsAnalyticsDatasourceImpl: getTransactions - Error: ${response.statusCode}');
        throw Exception('Failed to get transactions: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(
          'TransactionsAnalyticsDatasourceImpl: getTransactions - Exception: $e');
      rethrow;
    }
  }
}
