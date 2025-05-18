import 'package:equatable/equatable.dart';

/// @file        stellar_account.dart
/// @brief       Entity representing a Stellar account.
/// @details     Contains the essential information of a Stellar account including
///              public key, balance, and associated key pairs.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarAccount extends Equatable {
  final String publicKey;
  final String? secretKey;
  final double balance;
  final String? mnemonic;
  final DateTime createdAt;

  const StellarAccount({
    required this.publicKey,
    this.secretKey,
    required this.balance,
    this.mnemonic,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    publicKey,
    secretKey,
    balance,
    mnemonic,
    createdAt,
  ];

  StellarAccount copyWith({
    String? publicKey,
    String? secretKey,
    double? balance,
    String? mnemonic,
    DateTime? createdAt,
  }) {
    return StellarAccount(
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
      balance: balance ?? this.balance,
      mnemonic: mnemonic ?? this.mnemonic,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
