import 'package:nemorixpay/shared/stellar/domain/entities/stellar_account.dart';

/// @file        stellar_account_model.dart
/// @brief       Model class for Stellar account data.
/// @details     This class represents a Stellar account in the data layer,
///              providing a way to store and manage account information.
/// @author      Miguel Fagundez
/// @date        2025-05-17
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarAccountModel extends StellarAccount {
  const StellarAccountModel({
    required super.publicKey,
    required super.secretKey,
    required super.balance,
    required super.mnemonic,
    required super.createdAt,
  });

  /// Creates a StellarAccountModel from a StellarAccount entity
  factory StellarAccountModel.fromEntity(StellarAccount account) {
    return StellarAccountModel(
      publicKey: account.publicKey,
      secretKey: account.secretKey,
      balance: account.balance,
      mnemonic: account.mnemonic,
      createdAt: account.createdAt,
    );
  }

  /// Creates a copy of this StellarAccountModel with the given fields replaced with the new values
  @override
  StellarAccountModel copyWith({
    String? publicKey,
    String? secretKey,
    double? balance,
    String? mnemonic,
    DateTime? createdAt,
  }) {
    return StellarAccountModel(
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
      balance: balance ?? this.balance,
      mnemonic: mnemonic ?? this.mnemonic,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
