import 'package:equatable/equatable.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';

/// @file        stellar_account.dart
/// @brief       Entity representing a Stellar account.
/// @details     Contains the essential information of a Stellar account including
///              public key, balance, and associated key pairs.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.1
/// @copyright   Apache 2.0 License

class StellarAccount extends Equatable {
  final String? publicKey;
  final String? secretKey;
  final double? balance;
  final String? mnemonic;
  final DateTime? createdAt;
  final List<AssetEntity>? assets;

  const StellarAccount({
    required this.publicKey,
    this.secretKey,
    required this.balance,
    this.mnemonic,
    required this.createdAt,
    this.assets,
  });

  @override
  List<Object?> get props => [
        publicKey,
        secretKey,
        balance,
        mnemonic,
        createdAt,
        assets,
      ];

  /// Converts this StellarAccount entity to a StellarAccountModel
  StellarAccountModel toModel() {
    return StellarAccountModel(
      publicKey: publicKey,
      secretKey: secretKey,
      balance: balance,
      mnemonic: mnemonic,
      createdAt: createdAt,
      assets: assets?.map((asset) => asset.toModel()).toList(),
    );
  }

  StellarAccount copyWith({
    String? publicKey,
    String? secretKey,
    double? balance,
    String? mnemonic,
    DateTime? createdAt,
    List<AssetEntity>? assets,
  }) {
    return StellarAccount(
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
      balance: balance ?? this.balance,
      mnemonic: mnemonic ?? this.mnemonic,
      createdAt: createdAt ?? this.createdAt,
      assets: assets ?? this.assets,
    );
  }
}
