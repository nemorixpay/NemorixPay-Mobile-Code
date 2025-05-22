import 'package:equatable/equatable.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_asset_info_model.dart';

/// @file        stellar_asset_info.dart
/// @brief       Entity representing available Stellar asset information.
/// @details     This class defines the structure for Stellar asset information,
///              including user-friendly details like name, description, and
///              verification status.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarAssetInfo extends Equatable {
  final String code;
  final String name;
  final String description;
  final String issuer;
  final String issuerName;
  final bool isVerified;
  final String? logoUrl;
  final int decimals;
  final String type;

  const StellarAssetInfo({
    required this.code,
    required this.name,
    required this.description,
    required this.issuer,
    required this.issuerName,
    required this.isVerified,
    this.logoUrl,
    required this.decimals,
    required this.type,
  });

  @override
  List<Object?> get props => [
    code,
    name,
    description,
    issuer,
    issuerName,
    isVerified,
    logoUrl,
    decimals,
    type,
  ];

  /// Converts this StellarAssetInfo entity to a StellarAssetInfoModel
  StellarAssetInfoModel toModel() {
    return StellarAssetInfoModel(
      code: code,
      name: name,
      description: description,
      issuer: issuer,
      issuerName: issuerName,
      isVerified: isVerified,
      logoUrl: logoUrl,
      decimals: decimals,
      type: type,
    );
  }

  StellarAssetInfo copyWith({
    String? code,
    String? name,
    String? description,
    String? issuer,
    String? issuerName,
    bool? isVerified,
    String? logoUrl,
    int? decimals,
    String? type,
  }) {
    return StellarAssetInfo(
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      issuer: issuer ?? this.issuer,
      issuerName: issuerName ?? this.issuerName,
      isVerified: isVerified ?? this.isVerified,
      logoUrl: logoUrl ?? this.logoUrl,
      decimals: decimals ?? this.decimals,
      type: type ?? this.type,
    );
  }
}
