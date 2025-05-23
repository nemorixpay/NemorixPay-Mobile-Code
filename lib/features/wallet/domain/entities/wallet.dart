import 'package:equatable/equatable.dart';
import '../../data/models/wallet_model.dart';

/// @file        wallet.dart
/// @brief       Entity representing a wallet in the system.
/// @details     Contains the essential information of a wallet including
///              public key, secret key, balance, mnemonic phrase, and
///              creation timestamp. Implements Equatable for value comparison.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class Wallet extends Equatable {
  final String publicKey;
  final String secretKey;
  final double balance;
  final String mnemonic;
  final DateTime createdAt;

  const Wallet({
    required this.publicKey,
    required this.secretKey,
    required this.balance,
    required this.mnemonic,
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

  WalletModel toModel() {
    return WalletModel(
      publicKey: publicKey,
      secretKey: secretKey,
      balance: balance,
      mnemonic: mnemonic,
      createdAt: createdAt,
    );
  }

  Wallet copyWith({
    String? publicKey,
    String? secretKey,
    double? balance,
    String? mnemonic,
    DateTime? createdAt,
  }) {
    return Wallet(
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
      balance: balance ?? this.balance,
      mnemonic: mnemonic ?? this.mnemonic,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
