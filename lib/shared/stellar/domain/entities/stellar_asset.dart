import 'package:equatable/equatable.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_asset_model.dart';

/// @file        stellar_asset.dart
/// @brief       Entity representing a Stellar asset.
/// @details     This class defines the structure for Stellar assets,
///              including essential information like code, balance, type,
///              issuer, trust limits, authorization status and decimals.
/// @author      Miguel Fagundez
/// @date        2025-05-17
/// @version     1.1
/// @copyright   Apache 2.0 License

class StellarAsset extends Equatable {
  final String code;
  final double balance;
  final String type;
  final String? issuer;
  final double? limit;
  final bool isAuthorized;
  final int decimals;

  const StellarAsset({
    required this.code,
    required this.balance,
    required this.type,
    this.issuer,
    this.limit,
    this.isAuthorized = true,
    this.decimals = 7,
  });

  @override
  List<Object?> get props => [
    code,
    balance,
    type,
    issuer,
    limit,
    isAuthorized,
    decimals,
  ];

  StellarAsset copyWith({
    String? code,
    double? balance,
    String? type,
    String? issuer,
    double? limit,
    bool? isAuthorized,
    int? decimals,
  }) {
    return StellarAsset(
      code: code ?? this.code,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      issuer: issuer ?? this.issuer,
      limit: limit ?? this.limit,
      isAuthorized: isAuthorized ?? this.isAuthorized,
      decimals: decimals ?? this.decimals,
    );
  }

  /// Converts this StellarAsset entity to a StellarAssetModel
  StellarAssetModel toModel() {
    return StellarAssetModel(
      code: code,
      balance: balance,
      type: type,
      issuer: issuer,
      limit: limit,
      isAuthorized: isAuthorized,
      decimals: decimals,
    );
  }
}
