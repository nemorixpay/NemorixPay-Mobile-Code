import 'package:equatable/equatable.dart';
import '../../domain/entities/asset_entity.dart';

/// @file        asset_model.dart
/// @brief       Model representing a generic asset in the system.
/// @details     Provides serialization/deserialization methods for assets from different
///              sources (Stellar, Crypto, etc.) and mapping between domain entities
///              and data models.
/// @author      Miguel Fagundez
/// @date        2025-05-30
/// @version     1.0
/// @copyright   Apache 2.0 License
class AssetModel extends Equatable {
  /// Unique identifier for the asset
  final String id;

  /// Asset code (e.g., 'XLM', 'BTC', 'USDC')
  final String assetCode;

  /// Full name of the asset
  final String name;

  /// Type of asset (e.g., 'native', 'credit_alphanum4', 'credit_alphanum12')
  final String assetType;

  /// Network where the asset exists (e.g., 'stellar', 'ethereum')
  final String network;

  /// Number of decimal places for the asset
  final int decimals;

  /// Description of the asset
  final String? description;

  /// Issuer address for non-native assets
  final String? assetIssuer;

  /// Name of the asset issuer (e.g., 'Circle' for USDC)
  final String? issuerName;

  /// Whether the asset has been verified
  final bool isVerified;

  /// Domain of the asset issuer
  final String? domain;

  /// Current balance of the asset for the account
  final double? balance;

  /// Trust limit for the asset (if applicable)
  final double? limit;

  /// Whether the asset is authorized for the current account
  final bool isAuthorized;

  /// Buying liabilities of the asset
  final double? buyingLiabilities;

  /// Selling liabilities of the asset
  final double? sellingLiabilities;

  /// Total amount of the asset in circulation
  final double? amount;

  /// Number of accounts holding this asset
  final int? numAccounts;

  /// URL to the asset's image/logo
  final String? logoUrl;

  const AssetModel({
    required this.id,
    required this.assetCode,
    required this.name,
    required this.assetType,
    required this.network,
    required this.decimals,
    this.description,
    this.assetIssuer,
    this.issuerName,
    this.isVerified = false,
    this.domain,
    this.balance,
    this.limit,
    this.isAuthorized = true,
    this.buyingLiabilities,
    this.sellingLiabilities,
    this.amount,
    this.numAccounts,
    this.logoUrl,
  });

  /// Creates an AssetModel from a JSON map
  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'] as String? ?? '',
      assetCode: json['asset_code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      assetType: json['asset_type'] as String? ?? '',
      network: json['network'] as String? ?? '',
      decimals: json['decimals'] as int? ?? 7,
      description: json['description'] as String?,
      assetIssuer: json['asset_issuer'] as String?,
      issuerName: json['issuer_name'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      domain: json['domain'] as String?,
      balance:
          json['balance'] != null ? (json['balance'] as num).toDouble() : null,
      limit: json['limit'] != null ? (json['limit'] as num).toDouble() : null,
      isAuthorized: json['is_authorized'] as bool? ?? true,
      buyingLiabilities: json['buying_liabilities'] != null
          ? (json['buying_liabilities'] as num).toDouble()
          : null,
      sellingLiabilities: json['selling_liabilities'] != null
          ? (json['selling_liabilities'] as num).toDouble()
          : null,
      amount:
          json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      numAccounts: json['num_accounts'] as int?,
      logoUrl: json['logo_url'] as String?,
    );
  }

  /// Converts the AssetModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'asset_code': assetCode,
      'name': name,
      'asset_type': assetType,
      'network': network,
      'decimals': decimals,
      'description': description,
      'asset_issuer': assetIssuer,
      'issuer_name': issuerName,
      'is_verified': isVerified,
      'domain': domain,
      'balance': balance,
      'limit': limit,
      'is_authorized': isAuthorized,
      'buying_liabilities': buyingLiabilities,
      'selling_liabilities': sellingLiabilities,
      'amount': amount,
      'num_accounts': numAccounts,
      'logo_url': logoUrl,
    };
  }

  /// Converts this AssetModel to an AssetEntity
  AssetEntity toEntity() {
    return AssetEntity(
      id: id,
      assetCode: assetCode,
      name: name,
      assetType: assetType,
      network: network,
      decimals: decimals,
      description: description,
      assetIssuer: assetIssuer,
      issuerName: issuerName,
      isVerified: isVerified,
      domain: domain,
      balance: balance,
      limit: limit,
      isAuthorized: isAuthorized,
      buyingLiabilities: buyingLiabilities,
      sellingLiabilities: sellingLiabilities,
      amount: amount,
      numAccounts: numAccounts,
      logoUrl: logoUrl,
    );
  }

  AssetModel copyWith({
    String? id,
    String? assetCode,
    String? name,
    String? description,
    String? assetIssuer,
    String? issuerName,
    bool? isVerified,
    String? logoUrl,
    int? decimals,
    String? assetType,
    String? network,
  }) {
    return AssetModel(
      assetCode: assetCode ?? this.assetCode,
      name: name ?? this.name,
      description: description ?? this.description,
      assetIssuer: assetIssuer ?? this.assetIssuer,
      issuerName: issuerName ?? this.issuerName,
      isVerified: isVerified ?? this.isVerified,
      logoUrl: logoUrl ?? this.logoUrl,
      decimals: decimals ?? this.decimals,
      assetType: assetType ?? this.assetType,
      id: id ?? '',
      network: network ?? 'Stellar',
    );
  }

  @override
  List<Object?> get props => [
        id,
        assetCode,
        name,
        assetType,
        network,
        decimals,
        description,
        assetIssuer,
        issuerName,
        isVerified,
        domain,
        balance,
        limit,
        isAuthorized,
        buyingLiabilities,
        sellingLiabilities,
        amount,
        numAccounts,
        logoUrl,
      ];
}
