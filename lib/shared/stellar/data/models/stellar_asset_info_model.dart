import 'package:nemorixpay/shared/stellar/domain/entities/stellar_asset_info.dart';

/// @file        stellar_asset_info_model.dart
/// @brief       Model class for Stellar asset information data.
/// @details     This class represents Stellar asset information in the data layer,
///              providing serialization/deserialization methods and mapping between
///              domain entities and data models.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarAssetInfoModel {
  final String code;
  final String name;
  final String description;
  final String issuer;
  final String issuerName;
  final bool isVerified;
  final String? logoUrl;
  final int decimals;
  final String type;

  const StellarAssetInfoModel({
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

  factory StellarAssetInfoModel.fromJson(Map<String, dynamic> json) {
    return StellarAssetInfoModel(
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      issuer: json['issuer'] as String,
      issuerName: json['issuerName'] as String,
      isVerified: json['isVerified'] as bool,
      logoUrl: json['logoUrl'] as String?,
      decimals: json['decimals'] as int,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'description': description,
      'issuer': issuer,
      'issuerName': issuerName,
      'isVerified': isVerified,
      'logoUrl': logoUrl,
      'decimals': decimals,
      'type': type,
    };
  }

  /// Converts this StellarAssetInfoModel to a StellarAssetInfo entity
  StellarAssetInfo toEntity() {
    return StellarAssetInfo(
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

  StellarAssetInfoModel copyWith({
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
    return StellarAssetInfoModel(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StellarAssetInfoModel &&
        other.code == code &&
        other.name == name &&
        other.description == description &&
        other.issuer == issuer &&
        other.issuerName == issuerName &&
        other.isVerified == isVerified &&
        other.logoUrl == logoUrl &&
        other.decimals == decimals &&
        other.type == type;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        description.hashCode ^
        issuer.hashCode ^
        issuerName.hashCode ^
        isVerified.hashCode ^
        logoUrl.hashCode ^
        decimals.hashCode ^
        type.hashCode;
  }
}
