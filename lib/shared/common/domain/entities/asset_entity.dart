import 'package:equatable/equatable.dart';
import '../../data/models/asset_model.dart';

/// @file        asset_entity.dart
/// @brief       Entity representing a generic asset in the system.
/// @details     This class represents the core business logic for assets from different
///              sources (Stellar, Crypto, etc.) in the domain layer.
/// @author      Miguel Fagundez
/// @date        2025-05-30
/// @version     1.0
/// @copyright   Apache 2.0 License
class AssetEntity extends Equatable {
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

  const AssetEntity({
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

  /// Creates a native asset (e.g., XLM, ETH)
  /// @param code The asset code (e.g., 'XLM', 'ETH')
  /// @param network The network where the asset exists (e.g., 'stellar', 'ethereum')
  /// @param name Optional name, defaults to code
  /// @param symbol Optional symbol, defaults to code
  /// @param decimals Optional number of decimals, defaults to 7
  static AssetEntity createNative({
    required String code,
    required String network,
    String? name,
    String? symbol,
    int decimals = 7,
  }) {
    return AssetEntity(
      id: '${network}_${code}_native',
      assetCode: code,
      name: name ?? code,
      assetType: 'native',
      network: network,
      isVerified: true,
      decimals: decimals,
      isAuthorized: true,
    );
  }

  /// Checks if this is a native asset (e.g., XLM, ETH)
  bool isNative() => assetType == 'native';

  /// Checks if this asset is on the Stellar network
  bool isStellar() => network == 'stellar';

  /// Checks if this asset has been verified
  bool checkIsVerified() => this.isVerified;

  /// Checks if this asset has a positive balance
  bool hasBalance() => balance != null && balance! > 0;

  /// Gets the available balance (total balance minus liabilities)
  double getAvailableBalance() {
    if (balance == null) return 0;
    final liabilities = (buyingLiabilities ?? 0) + (sellingLiabilities ?? 0);
    return balance! - liabilities;
  }

  /// Gets the total amount reserved in liabilities
  double getReservedAmount() {
    return (buyingLiabilities ?? 0) + (sellingLiabilities ?? 0);
  }

  /// Gets the display name (falls back to asset code if name is empty)
  String getDisplayName() => name.isNotEmpty ? name : assetCode;

  /// Gets the full asset code including issuer for non-native assets
  String getFullCode() => isNative() ? assetCode : '$assetCode:$assetIssuer';

  /// Checks if this asset is the same as another asset
  /// Compares code, issuer and network
  bool isSameAsset(AssetEntity other) =>
      assetCode == other.assetCode &&
      assetIssuer == other.assetIssuer &&
      network == other.network;

  /// Converts the entity to an [AssetModel]
  AssetModel toModel() {
    return AssetModel(
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

  AssetEntity copyWith({
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
    return AssetEntity(
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
