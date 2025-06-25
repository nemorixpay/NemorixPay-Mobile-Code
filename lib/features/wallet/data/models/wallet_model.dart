import '../../domain/entities/wallet.dart';

/// @file        wallet_model.dart
/// @brief       Data model for wallet information.
/// @details     Represents a wallet in the data layer, providing methods for
///              JSON serialization/deserialization and conversion to/from
///              domain entities. Includes all necessary wallet attributes
///              and data transformation methods.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class WalletModel {
  final String? publicKey;
  final String? secretKey;
  final double? balance;
  final String? mnemonic;
  final DateTime? createdAt;

  const WalletModel({
    this.publicKey,
    this.secretKey,
    this.balance,
    this.mnemonic,
    this.createdAt,
  });

  WalletModel fromJson(Map<String, dynamic> json) {
    return WalletModel(
      publicKey: json['publicKey'] as String,
      secretKey: json['secretKey'] as String,
      balance: (json['balance'] as num).toDouble(),
      mnemonic: json['mnemonic'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'publicKey': publicKey,
      'secretKey': secretKey,
      'balance': balance,
      'mnemonic': mnemonic,
      'createdAt':
          createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  Wallet toEntity() {
    return Wallet(
      publicKey: publicKey,
      secretKey: secretKey,
      balance: balance,
      mnemonic: mnemonic,
      createdAt: createdAt,
    );
  }

  WalletModel copyWith({
    String? publicKey,
    String? secretKey,
    double? balance,
    String? mnemonic,
    DateTime? createdAt,
  }) {
    return WalletModel(
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
      balance: balance ?? this.balance,
      mnemonic: mnemonic ?? this.mnemonic,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
