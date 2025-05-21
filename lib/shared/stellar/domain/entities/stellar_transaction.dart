import 'package:equatable/equatable.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_transaction_model.dart';

/// @file        stellar_transaction.dart
/// @brief       Entity representing a Stellar transaction.
/// @details     Contains the essential information of a Stellar transaction including
///              source, destination, amount, and transaction status.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarTransaction extends Equatable {
  final String hash;
  final String sourceAccount;
  final String destinationAccount;
  final double amount;
  final String? memo;
  final bool successful;
  final int? ledger;
  final DateTime createdAt;
  final String feeCharged;

  const StellarTransaction({
    required this.hash,
    required this.sourceAccount,
    required this.destinationAccount,
    required this.amount,
    this.memo,
    required this.successful,
    this.ledger,
    required this.createdAt,
    required this.feeCharged,
  });

  @override
  List<Object?> get props => [
    hash,
    sourceAccount,
    destinationAccount,
    amount,
    memo,
    successful,
    ledger,
    createdAt,
    feeCharged,
  ];

  StellarTransaction copyWith({
    String? hash,
    String? sourceAccount,
    String? destinationAccount,
    double? amount,
    String? memo,
    bool? successful,
    int? ledger,
    DateTime? createdAt,
    String? feeCharged,
  }) {
    return StellarTransaction(
      hash: hash ?? this.hash,
      sourceAccount: sourceAccount ?? this.sourceAccount,
      destinationAccount: destinationAccount ?? this.destinationAccount,
      amount: amount ?? this.amount,
      memo: memo ?? this.memo,
      successful: successful ?? this.successful,
      ledger: ledger ?? this.ledger,
      createdAt: createdAt ?? this.createdAt,
      feeCharged: feeCharged ?? this.feeCharged,
    );
  }

  StellarTransactionModel toModel() {
    return StellarTransactionModel(
      hash: hash,
      sourceAccount: sourceAccount,
      destinationAccount: destinationAccount,
      amount: amount,
      memo: memo,
      successful: successful,
      ledger: ledger,
      createdAt: createdAt,
      feeCharged: feeCharged,
    );
  }
}
