import 'package:equatable/equatable.dart';

/// @file        transaction_list_item_data.dart
/// @brief       Entity representing transaction data for UI display
/// @details     Maps StellarTransactionModel data to UI-friendly format with calculated fields
/// @author      Miguel Fagundez
/// @date        08/28/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

/// Enum for transaction types
enum TransactionType { send, receive }

/// Enum for transaction status
enum TransactionStatus { confirmed, failed }

/// Enum for crypto assets
enum CryptoAsset { xlm, usdc }

/// Entity representing transaction data for UI display
class TransactionListItemData extends Equatable {
  // Data from Stellar SDK (real)
  final String hash;
  final String sourceAccount;
  final String destinationAccount;
  final double amount;
  final String? memo;
  final bool successful;
  final DateTime createdAt;

  // Calculated/derived data (NOT from SDK) - Need to be checked
  final TransactionType type;
  final String assetCode;
  final double? fiatAmount;
  final String fiatSymbol;

  const TransactionListItemData({
    required this.hash,
    required this.sourceAccount,
    required this.destinationAccount,
    required this.amount,
    this.memo,
    required this.successful,
    required this.createdAt,
    required this.type,
    required this.assetCode,
    this.fiatAmount,
    required this.fiatSymbol,
  });

  /// Factory constructor that maps from StellarTransactionModel
  factory TransactionListItemData.fromStellarTransaction({
    required String hash,
    required String sourceAccount,
    required String destinationAccount,
    required double amount,
    String? memo,
    required bool successful,
    required DateTime createdAt,
    required String currentUserPublicKey,
    required String assetCode,
    double? currentPrice,
    String fiatSymbol = '\$',
  }) {
    return TransactionListItemData(
      hash: hash,
      sourceAccount: sourceAccount,
      destinationAccount: destinationAccount,
      amount: amount,
      memo: memo,
      successful: successful,
      createdAt: createdAt,

      // Calculated fields
      type: sourceAccount == currentUserPublicKey
          ? TransactionType.send
          : TransactionType.receive,
      assetCode: assetCode,
      fiatAmount: currentPrice != null ? amount * currentPrice : null,
      fiatSymbol: fiatSymbol,
    );
  }

  /// Get transaction status based on successful field
  TransactionStatus get status =>
      successful ? TransactionStatus.confirmed : TransactionStatus.failed;

  /// Get crypto asset enum from asset code
  CryptoAsset get cryptoAsset {
    switch (assetCode.toLowerCase()) {
      case 'xlm':
        return CryptoAsset.xlm;
      case 'usdc':
        return CryptoAsset.usdc;
      default:
        return CryptoAsset.xlm; // Default to XLM
    }
  }

  /// Get formatted amount string
  String get formattedAmount => '$amount $assetCode';

  /// Get formatted fiat amount string
  String get formattedFiatAmount {
    if (fiatAmount == null) return 'N/A';
    return '$fiatSymbol${fiatAmount!.toStringAsFixed(2)}';
  }

  /// Get transaction ID for display (short hash)
  String get displayId => '#${hash.substring(0, 8)}';

  @override
  List<Object?> get props => [
        hash,
        sourceAccount,
        destinationAccount,
        amount,
        memo,
        successful,
        createdAt,
        type,
        assetCode,
        fiatAmount,
        fiatSymbol,
      ];

  TransactionListItemData copyWith({
    String? hash,
    String? sourceAccount,
    String? destinationAccount,
    double? amount,
    String? memo,
    bool? successful,
    DateTime? createdAt,
    TransactionType? type,
    String? assetCode,
    double? fiatAmount,
    String? fiatSymbol,
  }) {
    return TransactionListItemData(
      hash: hash ?? this.hash,
      sourceAccount: sourceAccount ?? this.sourceAccount,
      destinationAccount: destinationAccount ?? this.destinationAccount,
      amount: amount ?? this.amount,
      memo: memo ?? this.memo,
      successful: successful ?? this.successful,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      assetCode: assetCode ?? this.assetCode,
      fiatAmount: fiatAmount ?? this.fiatAmount,
      fiatSymbol: fiatSymbol ?? this.fiatSymbol,
    );
  }
}
