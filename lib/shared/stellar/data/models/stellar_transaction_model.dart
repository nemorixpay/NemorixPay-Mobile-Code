import 'package:nemorixpay/shared/stellar/domain/entities/stellar_transaction.dart';

/// @file        stellar_transaction_model.dart
/// @brief       Model representing a Stellar transaction.
/// @details     Provides serialization/deserialization methods for Stellar transactions
///              and mapping between domain entities and data models.
/// @author      Miguel Fagundez
/// @date        2025-05-20
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarTransactionModel {
  final String hash;
  final String sourceAccount;
  final String destinationAccount;
  final double amount;
  final String? memo;
  final bool successful;
  final int? ledger;
  final DateTime createdAt;
  final String feeCharged;

  const StellarTransactionModel({
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

  factory StellarTransactionModel.fromJson(Map<String, dynamic> json) {
    return StellarTransactionModel(
      hash: json['hash'] as String,
      sourceAccount: json['sourceAccount'] as String,
      destinationAccount: json['destinationAccount'] as String,
      amount: (json['amount'] as num).toDouble(),
      memo: json['memo'] as String?,
      successful: json['successful'] as bool,
      ledger: json['ledger'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      feeCharged: json['feeCharged'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'sourceAccount': sourceAccount,
      'destinationAccount': destinationAccount,
      'amount': amount,
      'memo': memo,
      'successful': successful,
      'ledger': ledger,
      'createdAt': createdAt.toUtc().toIso8601String().replaceAll('.000Z', 'Z'),
      'feeCharged': feeCharged,
    };
  }

  StellarTransaction toEntity() {
    return StellarTransaction(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StellarTransactionModel &&
        other.hash == hash &&
        other.sourceAccount == sourceAccount &&
        other.destinationAccount == destinationAccount &&
        other.amount == amount &&
        other.memo == memo &&
        other.successful == successful &&
        other.ledger == ledger &&
        other.createdAt == createdAt &&
        other.feeCharged == feeCharged;
  }

  @override
  int get hashCode {
    return hash.hashCode ^
        sourceAccount.hashCode ^
        destinationAccount.hashCode ^
        amount.hashCode ^
        memo.hashCode ^
        successful.hashCode ^
        ledger.hashCode ^
        createdAt.hashCode ^
        feeCharged.hashCode;
  }
}
