import 'package:nemorixpay/shared/stellar/domain/entities/stellar_asset.dart';

/// @file        stellar_asset_model.dart
/// @brief       Model representing a Stellar asset.
/// @details     Provides serialization/deserialization methods for Stellar assets
///              and mapping between domain entities and data models.
/// @author      Miguel Fagundez
/// @date        2025-05-21
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarAssetModel {
  final String code;
  final double balance;
  final String type;
  final String? issuer;
  final double? limit;
  final bool isAuthorized;
  final int decimals;

  const StellarAssetModel({
    required this.code,
    required this.balance,
    required this.type,
    this.issuer,
    this.limit,
    this.isAuthorized = true,
    this.decimals = 7,
  });

  factory StellarAssetModel.fromJson(Map<String, dynamic> json) {
    return StellarAssetModel(
      code: json['code'] as String,
      balance: (json['balance'] as num).toDouble(),
      type: json['type'] as String,
      issuer: json['issuer'] as String?,
      limit: json['limit'] != null ? (json['limit'] as num).toDouble() : null,
      isAuthorized: json['isAuthorized'] as bool? ?? true,
      decimals: json['decimals'] as int? ?? 7,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'balance': balance,
      'type': type,
      'issuer': issuer,
      'limit': limit,
      'isAuthorized': isAuthorized,
      'decimals': decimals,
    };
  }

  /// Converts this StellarAssetModel to a StellarAsset entity
  StellarAsset toEntity() {
    return StellarAsset(
      code: code,
      balance: balance,
      type: type,
      issuer: issuer,
      limit: limit,
      isAuthorized: isAuthorized,
      decimals: decimals,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StellarAssetModel &&
        other.code == code &&
        other.balance == balance &&
        other.type == type &&
        other.issuer == issuer &&
        other.limit == limit &&
        other.isAuthorized == isAuthorized &&
        other.decimals == decimals;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        balance.hashCode ^
        type.hashCode ^
        issuer.hashCode ^
        limit.hashCode ^
        isAuthorized.hashCode ^
        decimals.hashCode;
  }
}
