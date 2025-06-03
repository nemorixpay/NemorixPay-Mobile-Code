import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_account.dart';

/// @file        stellar_account_model.dart
/// @brief       Model class for Stellar account data.
/// @details     This class represents a Stellar account in the data layer,
///              providing a way to store and manage account information.
/// @author      Miguel Fagundez
/// @date        2025-05-20
/// @version     1.1
/// @copyright   Apache 2.0 License

class StellarAccountModel {
  final String publicKey;
  final String secretKey;
  final double balance;
  final String mnemonic;
  final DateTime createdAt;
  final List<AssetModel>? assets;

  const StellarAccountModel({
    required this.publicKey,
    required this.secretKey,
    required this.balance,
    required this.mnemonic,
    required this.createdAt,
    this.assets,
  });

  /// Creates a StellarAccountModel from a JSON map
  factory StellarAccountModel.fromJson(Map<String, dynamic> json) {
    return StellarAccountModel(
      publicKey: json['publicKey'] as String,
      secretKey: json['secretKey'] as String,
      balance: (json['balance'] as num).toDouble(),
      mnemonic: json['mnemonic'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      assets:
          json['assets'] != null
              ? (json['assets'] as List)
                  .map((e) => AssetModel.fromJson(e as Map<String, dynamic>))
                  .toList()
              : null,
    );
  }

  /// Converts this StellarAccountModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'publicKey': publicKey,
      'secretKey': secretKey,
      'balance': balance,
      'mnemonic': mnemonic,
      'createdAt': createdAt.toIso8601String(),
      'assets': assets?.map((e) => e.toJson()).toList(),
    };
  }

  // /// Creates a StellarAccountModel from a StellarAccount entity
  // factory StellarAccountModel.fromEntity(StellarAccount account) {
  //   return StellarAccountModel(
  //     publicKey: account.publicKey,
  //     secretKey: account.secretKey,
  //     balance: account.balance,
  //     mnemonic: account.mnemonic,
  //     createdAt: account.createdAt,
  //   );
  // }

  /// Converts this StellarAccountModel to a StellarAccount entity
  StellarAccount toEntity() {
    return StellarAccount(
      publicKey: publicKey,
      secretKey: secretKey,
      balance: balance,
      mnemonic: mnemonic,
      createdAt: createdAt,
      assets: assets?.map((asset) => asset.toEntity()).toList(),
    );
  }

  /// Creates a copy of this StellarAccountModel with the given fields replaced with the new values
  StellarAccountModel copyWith({
    String? publicKey,
    String? secretKey,
    double? balance,
    String? mnemonic,
    DateTime? createdAt,
    List<AssetModel>? assets,
  }) {
    return StellarAccountModel(
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
      balance: balance ?? this.balance,
      mnemonic: mnemonic ?? this.mnemonic,
      createdAt: createdAt ?? this.createdAt,
      assets: assets ?? this.assets,
    );
  }
}
