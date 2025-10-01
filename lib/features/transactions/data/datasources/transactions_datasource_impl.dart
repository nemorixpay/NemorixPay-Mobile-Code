import 'package:flutter/foundation.dart';
import 'package:nemorixpay/features/transactions/data/datasources/transactions_datasource.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';
import 'package:nemorixpay/shared/stellar/domain/repositories/stellar_repository.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';

/// @file        transactions_datasource_impl.dart
/// @brief       Implementation of transactions data operations.
/// @details     Provides concrete implementation for fetching and managing
///              transaction data from Stellar network, including mapping
///              StellarTransaction to TransactionListItemData.
/// @author      Miguel Fagundez
/// @date        09/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionsDatasourceImpl implements TransactionsDatasource {
  final StellarRepository _stellarRepository;

  // Hardcoded values for OPCIÓN 1 ****** TEMPORAL ******
  static const double _hardcodedXlmPrice = 1.0; // $1 USD
  static const String _hardcodedAssetCode = 'XLM';
  static const String _hardcodedFiatSymbol = '\$';

  TransactionsDatasourceImpl({
    required StellarRepository stellarRepository,
  }) : _stellarRepository = stellarRepository;

  @override
  Future<List<TransactionListItemData>> getTransactions() async {
    debugPrint('TransactionsDatasourceImpl: getTransactions - Starting');

    try {
      // Get current user public key
      StellarAccountProvider? accountProvider = StellarAccountProvider();
      final currentAccount = accountProvider.currentAccount;
      if (currentAccount == null) {
        debugPrint(
            'TransactionsDatasourceImpl: getTransactions - No account found');
        throw Exception('No account found. Please log in again.');
      }

      final currentUserPublicKey = currentAccount.publicKey;
      debugPrint(
          'TransactionsDatasourceImpl: getTransactions - Public key: $currentUserPublicKey');

      // Get transactions from Stellar repository
      final result = await _stellarRepository.getTransactions();

      return result.fold(
        (failure) {
          debugPrint(
              'TransactionsDatasourceImpl: getTransactions - Error: ${failure.message}');
          throw Exception('Failed to get transactions: ${failure.message}');
        },
        (stellarTransactions) {
          debugPrint(
              'TransactionsDatasourceImpl: getTransactions - Found ${stellarTransactions.length} transactions');

          // Map StellarTransaction to TransactionListItemData
          final transactionData = stellarTransactions.map((tx) {
            return TransactionListItemData.fromStellarTransaction(
              hash: tx.hash,
              sourceAccount: tx.sourceAccount,
              destinationAccount: tx.destinationAccount,
              amount: tx.amount,
              memo: tx.memo,
              successful: tx.successful,
              createdAt: tx.createdAt,
              currentUserPublicKey: currentUserPublicKey.toString(),
              assetCode: _hardcodedAssetCode,
              currentPrice: _hardcodedXlmPrice,
              fiatSymbol: _hardcodedFiatSymbol,
            );
          }).toList();

          debugPrint(
              'TransactionsDatasourceImpl: getTransactions - Mapped ${transactionData.length} transactions');
          return transactionData;
        },
      );
    } catch (e) {
      debugPrint('TransactionsDatasourceImpl: getTransactions - Exception: $e');
      rethrow;
    }
  }

  @override
  Future<List<TransactionListItemData>> refreshTransactions() async {
    debugPrint('TransactionsDatasourceImpl: refreshTransactions - Starting');

    try {
      // Get current user public key
      StellarAccountProvider? accountProvider = StellarAccountProvider();
      final currentAccount = accountProvider.currentAccount;
      if (currentAccount == null) {
        debugPrint(
            'TransactionsDatasourceImpl: refreshTransactions - No account found');
        throw Exception('No account found. Please log in again.');
      }

      final currentUserPublicKey = currentAccount.publicKey;
      debugPrint(
          'TransactionsDatasourceImpl: refreshTransactions - Public key: $currentUserPublicKey');

      // Get fresh transactions from Stellar repository
      final result = await _stellarRepository.getTransactions();

      return result.fold(
        (failure) {
          debugPrint(
              'TransactionsDatasourceImpl: refreshTransactions - Error: ${failure.message}');
          throw Exception('Failed to refresh transactions: ${failure.message}');
        },
        (stellarTransactions) {
          debugPrint(
              'TransactionsDatasourceImpl: refreshTransactions - Found ${stellarTransactions.length} fresh transactions');

          // Map StellarTransaction to TransactionListItemData
          final transactionData = stellarTransactions.map((tx) {
            return TransactionListItemData.fromStellarTransaction(
              hash: tx.hash,
              sourceAccount: tx.sourceAccount,
              destinationAccount: tx.destinationAccount,
              amount: tx.amount,
              memo: tx.memo,
              successful: tx.successful,
              createdAt: tx.createdAt,
              currentUserPublicKey: currentUserPublicKey.toString(),
              assetCode: _hardcodedAssetCode,
              currentPrice: _hardcodedXlmPrice,
              fiatSymbol: _hardcodedFiatSymbol,
            );
          }).toList();

          debugPrint(
              'TransactionsDatasourceImpl: refreshTransactions - Mapped ${transactionData.length} fresh transactions');
          return transactionData;
        },
      );
    } catch (e) {
      debugPrint(
          'TransactionsDatasourceImpl: refreshTransactions - Exception: $e');
      rethrow;
    }
  }
}
