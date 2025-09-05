import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';

/// @file        mock_transaction_data.dart
/// @brief       Mock transaction data for UI testing
/// @details     Provides sample transaction data to test the UI components
/// @author      Miguel Fagundez
/// @date        08/28/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class MockTransactionData {
  static const String currentUserPublicKey = 'GABC1234567890ABCDEF';

  /// Generate mock transaction data for testing
  static List<TransactionListItemData> getMockTransactions() {
    return [
      TransactionListItemData.fromStellarTransaction(
        hash:
            '1111111111111111111111111111111111111111111111111111111111111111',
        sourceAccount: currentUserPublicKey,
        destinationAccount: 'GDEF1234567890ABCDEF',
        amount: 8.7588,
        memo: 'Payment for services',
        successful: true,
        createdAt: DateTime(2025, 3, 5, 1, 44),
        currentUserPublicKey: currentUserPublicKey,
        assetCode: 'XLM',
        currentPrice: 5.17,
      ),
      TransactionListItemData.fromStellarTransaction(
        hash:
            '2222222222222222222222222222222222222222222222222222222222222222',
        sourceAccount: 'GDEF1234567890ABCDEF',
        destinationAccount: currentUserPublicKey,
        amount: 8.7588,
        memo: 'Refund',
        successful: true,
        createdAt: DateTime(2025, 3, 6, 14, 31),
        currentUserPublicKey: currentUserPublicKey,
        assetCode: 'USDC',
        currentPrice: 1.0,
      ),
      TransactionListItemData.fromStellarTransaction(
        hash:
            '3333333333333333333333333333333333333333333333333333333333333333',
        sourceAccount: currentUserPublicKey,
        destinationAccount: 'GHIJ1234567890ABCDEF',
        amount: 15.5000,
        memo: 'Transfer to friend',
        successful: false,
        createdAt: DateTime(2025, 3, 6, 20, 40),
        currentUserPublicKey: currentUserPublicKey,
        assetCode: 'XLM',
        currentPrice: 5.17,
      ),
      TransactionListItemData.fromStellarTransaction(
        hash:
            '4444444444444444444444444444444444444444444444444444444444444444',
        sourceAccount: currentUserPublicKey,
        destinationAccount: 'GKLM1234567890ABCDEF',
        amount: 25.0000,
        memo: 'Business payment',
        successful: true,
        createdAt: DateTime(2025, 3, 8, 9, 14),
        currentUserPublicKey: currentUserPublicKey,
        assetCode: 'XLM',
        currentPrice: 5.17,
      ),
      TransactionListItemData.fromStellarTransaction(
        hash:
            '5555555555555555555555555555555555555555555555555555555555555555',
        sourceAccount: currentUserPublicKey,
        destinationAccount: 'GNOP1234567890ABCDEF',
        amount: 10.2500,
        memo: 'Shopping payment',
        successful: true,
        createdAt: DateTime(2025, 3, 9, 11, 24),
        currentUserPublicKey: currentUserPublicKey,
        assetCode: 'XLM',
        currentPrice: 5.17,
      ),
      TransactionListItemData.fromStellarTransaction(
        hash:
            '6666666666666666666666666666666666666666666666666666666666666666',
        sourceAccount: 'GQRS1234567890ABCDEF',
        destinationAccount: currentUserPublicKey,
        amount: 50.0000,
        memo: 'Salary payment',
        successful: true,
        createdAt: DateTime(2025, 3, 9, 13, 21),
        currentUserPublicKey: currentUserPublicKey,
        assetCode: 'XLM',
        currentPrice: 5.17,
      ),
      TransactionListItemData.fromStellarTransaction(
        hash:
            '7777777777777777777777777777777777777777777777777777777777777777',
        sourceAccount: currentUserPublicKey,
        destinationAccount: 'GTUV1234567890ABCDEF',
        amount: 100.0000,
        memo: 'Large transfer',
        successful: false,
        createdAt: DateTime(2025, 3, 10, 10, 17),
        currentUserPublicKey: currentUserPublicKey,
        assetCode: 'USDC',
        currentPrice: 1.0,
      ),
      TransactionListItemData.fromStellarTransaction(
        hash:
            '8888888888888888888888888888888888888888888888888888888888888888',
        sourceAccount: 'GWXY1234567890ABCDEF',
        destinationAccount: currentUserPublicKey,
        amount: 75.5000,
        memo: 'Investment return',
        successful: true,
        createdAt: DateTime(2025, 3, 15, 8, 8),
        currentUserPublicKey: currentUserPublicKey,
        assetCode: 'XLM',
        currentPrice: 5.17,
      ),
    ];
  }

  /// Generate empty transaction list for testing
  static List<TransactionListItemData> getEmptyTransactions() {
    return [];
  }

  /// Generate single transaction for testing
  static TransactionListItemData getSingleTransaction() {
    return TransactionListItemData.fromStellarTransaction(
      hash: '9999999999999999999999999999999999999999999999999999999999999999',
      sourceAccount: currentUserPublicKey,
      destinationAccount: 'GZAB1234567890ABCDEF',
      amount: 12.3456,
      memo: 'Test transaction',
      successful: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      currentUserPublicKey: currentUserPublicKey,
      assetCode: 'XLM',
      currentPrice: 5.17,
    );
  }
}
