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
  final String asset_code;

  /// Full name of the asset
  final String name;

  /// Symbol used to represent the asset
  final String symbol;

  /// Type of asset (e.g., 'native', 'credit_alphanum4', 'credit_alphanum12')
  final String asset_type;

  /// Network where the asset exists (e.g., 'stellar', 'ethereum')
  final String network;

  /// Issuer address for non-native assets
  final String? asset_issuer;

  /// Name of the asset issuer (e.g., 'Circle' for USDC)
  final String? issuer_name;

  /// Whether the asset has been verified
  final bool is_verified;

  /// Domain of the asset issuer
  final String? domain;

  /// Number of accounts holding this asset
  final int? num_accounts;

  /// Total amount of the asset in circulation
  final double? amount;

  /// URL to the asset's image/logo
  final String? logo_url;

  /// Description of the asset
  final String? description;

  /// Number of decimal places for the asset
  final int decimals;

  /// Whether the asset is authorized for the current account
  final bool is_authorized;

  /// Trust limit for the asset (if applicable)
  final double? limit;

  /// Current balance of the asset for the account
  final double? balance;

  /// Buying liabilities of the asset
  final double? buying_liabilities;

  /// Selling liabilities of the asset
  final double? selling_liabilities;

  /// Last ledger where the asset was modified
  final int? last_modified_ledger;

  /// Timestamp of the last modification
  final DateTime? last_modified_time;

  /// Address of the asset sponsor (if applicable)
  final String? sponsor;

  /// Flags of the asset
  final Map<String, bool>? flags;

  /// Token for pagination
  final String? paging_token;

  /// Whether clawback is enabled
  final bool? is_clawback_enabled;

  /// Whether authorized to maintain liabilities
  final bool? is_authorized_to_maintain_liabilities;

  /// Whether authorized to maintain offers
  final bool? is_authorized_to_maintain_offers;

  /// Whether authorized to maintain trustlines
  final bool? is_authorized_to_maintain_trustlines;

  /// Whether authorized to maintain claimable balances
  final bool? is_authorized_to_maintain_claimable_balances;

  /// Whether authorized to maintain liquidity pools
  final bool? is_authorized_to_maintain_liquidity_pools;

  /// Whether authorized to maintain contracts
  final bool? is_authorized_to_maintain_contracts;

  /// Number of claimable balances
  final int? num_claimable_balances;

  /// Number of liquidity pools
  final int? num_liquidity_pools;

  /// Number of contracts
  final int? num_contracts;

  /// Number of accounts with trustlines
  final int? accounts_with_trustlines;

  /// Number of accounts with offers
  final int? accounts_with_offers;

  /// Number of accounts with balance
  final int? accounts_with_balance;

  /// Number of accounts with liabilities
  final int? accounts_with_liabilities;

  /// Number of accounts with sponsoring
  final int? accounts_with_sponsoring;

  /// Number of accounts with sponsored
  final int? accounts_with_sponsored;

  /// Number of accounts with claimable balances
  final int? accounts_with_claimable_balances;

  /// Number of accounts with liquidity pools
  final int? accounts_with_liquidity_pools;

  /// Number of accounts with contracts
  final int? accounts_with_contracts;

  /// Additional metadata specific to the asset
  final Map<String, dynamic> metadata;

  const AssetModel({
    required this.id,
    required this.asset_code,
    required this.name,
    required this.symbol,
    required this.asset_type,
    required this.network,
    this.asset_issuer,
    this.issuer_name,
    this.is_verified = false,
    this.domain,
    this.num_accounts,
    this.amount,
    this.logo_url,
    this.description,
    this.decimals = 7,
    this.is_authorized = true,
    this.limit,
    this.balance,
    this.buying_liabilities,
    this.selling_liabilities,
    this.last_modified_ledger,
    this.last_modified_time,
    this.sponsor,
    this.flags,
    this.paging_token,
    this.is_clawback_enabled,
    this.is_authorized_to_maintain_liabilities,
    this.is_authorized_to_maintain_offers,
    this.is_authorized_to_maintain_trustlines,
    this.is_authorized_to_maintain_claimable_balances,
    this.is_authorized_to_maintain_liquidity_pools,
    this.is_authorized_to_maintain_contracts,
    this.num_claimable_balances,
    this.num_liquidity_pools,
    this.num_contracts,
    this.accounts_with_trustlines,
    this.accounts_with_offers,
    this.accounts_with_balance,
    this.accounts_with_liabilities,
    this.accounts_with_sponsoring,
    this.accounts_with_sponsored,
    this.accounts_with_claimable_balances,
    this.accounts_with_liquidity_pools,
    this.accounts_with_contracts,
    this.metadata = const {},
  });

  /// Creates an AssetModel from a JSON map
  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'] as String,
      asset_code: json['asset_code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      asset_type: json['asset_type'] as String,
      network: json['network'] as String,
      asset_issuer: json['asset_issuer'] as String?,
      issuer_name: json['issuer_name'] as String?,
      is_verified: json['is_verified'] as bool? ?? false,
      domain: json['domain'] as String?,
      num_accounts: json['num_accounts'] as int?,
      amount:
          json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      logo_url: json['logo_url'] as String?,
      description: json['description'] as String?,
      decimals: json['decimals'] as int? ?? 7,
      is_authorized: json['is_authorized'] as bool? ?? true,
      limit: json['limit'] != null ? (json['limit'] as num).toDouble() : null,
      balance:
          json['balance'] != null ? (json['balance'] as num).toDouble() : null,
      buying_liabilities:
          json['buying_liabilities'] != null
              ? (json['buying_liabilities'] as num).toDouble()
              : null,
      selling_liabilities:
          json['selling_liabilities'] != null
              ? (json['selling_liabilities'] as num).toDouble()
              : null,
      last_modified_ledger: json['last_modified_ledger'] as int?,
      last_modified_time:
          json['last_modified_time'] != null
              ? DateTime.parse(json['last_modified_time'] as String)
              : null,
      sponsor: json['sponsor'] as String?,
      flags:
          json['flags'] != null
              ? Map<String, bool>.from(json['flags'] as Map)
              : null,
      paging_token: json['paging_token'] as String?,
      is_clawback_enabled: json['is_clawback_enabled'] as bool?,
      is_authorized_to_maintain_liabilities:
          json['is_authorized_to_maintain_liabilities'] as bool?,
      is_authorized_to_maintain_offers:
          json['is_authorized_to_maintain_offers'] as bool?,
      is_authorized_to_maintain_trustlines:
          json['is_authorized_to_maintain_trustlines'] as bool?,
      is_authorized_to_maintain_claimable_balances:
          json['is_authorized_to_maintain_claimable_balances'] as bool?,
      is_authorized_to_maintain_liquidity_pools:
          json['is_authorized_to_maintain_liquidity_pools'] as bool?,
      is_authorized_to_maintain_contracts:
          json['is_authorized_to_maintain_contracts'] as bool?,
      num_claimable_balances: json['num_claimable_balances'] as int?,
      num_liquidity_pools: json['num_liquidity_pools'] as int?,
      num_contracts: json['num_contracts'] as int?,
      accounts_with_trustlines: json['accounts_with_trustlines'] as int?,
      accounts_with_offers: json['accounts_with_offers'] as int?,
      accounts_with_balance: json['accounts_with_balance'] as int?,
      accounts_with_liabilities: json['accounts_with_liabilities'] as int?,
      accounts_with_sponsoring: json['accounts_with_sponsoring'] as int?,
      accounts_with_sponsored: json['accounts_with_sponsored'] as int?,
      accounts_with_claimable_balances:
          json['accounts_with_claimable_balances'] as int?,
      accounts_with_liquidity_pools:
          json['accounts_with_liquidity_pools'] as int?,
      accounts_with_contracts: json['accounts_with_contracts'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );
  }

  /// Converts this AssetModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'asset_code': asset_code,
      'name': name,
      'symbol': symbol,
      'asset_type': asset_type,
      'network': network,
      'asset_issuer': asset_issuer,
      'issuer_name': issuer_name,
      'is_verified': is_verified,
      'domain': domain,
      'num_accounts': num_accounts,
      'amount': amount,
      'logo_url': logo_url,
      'description': description,
      'decimals': decimals,
      'is_authorized': is_authorized,
      'limit': limit,
      'balance': balance,
      'buying_liabilities': buying_liabilities,
      'selling_liabilities': selling_liabilities,
      'last_modified_ledger': last_modified_ledger,
      'last_modified_time': last_modified_time?.toIso8601String(),
      'sponsor': sponsor,
      'flags': flags,
      'paging_token': paging_token,
      'is_clawback_enabled': is_clawback_enabled,
      'is_authorized_to_maintain_liabilities':
          is_authorized_to_maintain_liabilities,
      'is_authorized_to_maintain_offers': is_authorized_to_maintain_offers,
      'is_authorized_to_maintain_trustlines':
          is_authorized_to_maintain_trustlines,
      'is_authorized_to_maintain_claimable_balances':
          is_authorized_to_maintain_claimable_balances,
      'is_authorized_to_maintain_liquidity_pools':
          is_authorized_to_maintain_liquidity_pools,
      'is_authorized_to_maintain_contracts':
          is_authorized_to_maintain_contracts,
      'num_claimable_balances': num_claimable_balances,
      'num_liquidity_pools': num_liquidity_pools,
      'num_contracts': num_contracts,
      'accounts_with_trustlines': accounts_with_trustlines,
      'accounts_with_offers': accounts_with_offers,
      'accounts_with_balance': accounts_with_balance,
      'accounts_with_liabilities': accounts_with_liabilities,
      'accounts_with_sponsoring': accounts_with_sponsoring,
      'accounts_with_sponsored': accounts_with_sponsored,
      'accounts_with_claimable_balances': accounts_with_claimable_balances,
      'accounts_with_liquidity_pools': accounts_with_liquidity_pools,
      'accounts_with_contracts': accounts_with_contracts,
      'metadata': metadata,
    };
  }

  /// Converts this AssetModel to an Asset entity
  AssetEntity toEntity() {
    return AssetEntity(
      id: id,
      asset_code: asset_code,
      name: name,
      symbol: symbol,
      asset_type: asset_type,
      network: network,
      asset_issuer: asset_issuer,
      issuer_name: issuer_name,
      is_verified: is_verified,
      domain: domain,
      num_accounts: num_accounts,
      amount: amount,
      logo_url: logo_url,
      description: description,
      decimals: decimals,
      is_authorized: is_authorized,
      limit: limit,
      balance: balance,
      buying_liabilities: buying_liabilities,
      selling_liabilities: selling_liabilities,
      last_modified_ledger: last_modified_ledger,
      last_modified_time: last_modified_time,
      sponsor: sponsor,
      flags: flags,
      paging_token: paging_token,
      is_clawback_enabled: is_clawback_enabled,
      is_authorized_to_maintain_liabilities:
          is_authorized_to_maintain_liabilities,
      is_authorized_to_maintain_offers: is_authorized_to_maintain_offers,
      is_authorized_to_maintain_trustlines:
          is_authorized_to_maintain_trustlines,
      is_authorized_to_maintain_claimable_balances:
          is_authorized_to_maintain_claimable_balances,
      is_authorized_to_maintain_liquidity_pools:
          is_authorized_to_maintain_liquidity_pools,
      is_authorized_to_maintain_contracts: is_authorized_to_maintain_contracts,
      num_claimable_balances: num_claimable_balances,
      num_liquidity_pools: num_liquidity_pools,
      num_contracts: num_contracts,
      accounts_with_trustlines: accounts_with_trustlines,
      accounts_with_offers: accounts_with_offers,
      accounts_with_balance: accounts_with_balance,
      accounts_with_liabilities: accounts_with_liabilities,
      accounts_with_sponsoring: accounts_with_sponsoring,
      accounts_with_sponsored: accounts_with_sponsored,
      accounts_with_claimable_balances: accounts_with_claimable_balances,
      accounts_with_liquidity_pools: accounts_with_liquidity_pools,
      accounts_with_contracts: accounts_with_contracts,
      metadata: metadata,
    );
  }

  /// Creates an AssetModel from a StellarAsset
  /// @param stellarAsset The StellarAsset object from the Stellar SDK
  /// @param id Optional custom ID, if not provided will be generated
  factory AssetModel.fromStellarAsset(
    Map<String, dynamic> stellarAsset, {
    String? id,
  }) {
    return AssetModel(
      id:
          id ??
          'stellar_${stellarAsset['code']}_${stellarAsset['issuer'] ?? 'native'}',
      asset_code: stellarAsset['code'] as String,
      name:
          stellarAsset['code']
              as String, // Default to code if name not available
      symbol: stellarAsset['code'] as String,
      asset_type: stellarAsset['type'] as String,
      network: 'stellar',
      asset_issuer: stellarAsset['issuer'] as String?,
      is_authorized: stellarAsset['is_authorized'] as bool? ?? true,
      limit:
          stellarAsset['limit'] != null
              ? double.parse(stellarAsset['limit'] as String)
              : null,
      balance:
          stellarAsset['balance'] != null
              ? double.parse(stellarAsset['balance'] as String)
              : null,
      buying_liabilities:
          stellarAsset['buying_liabilities'] != null
              ? double.parse(stellarAsset['buying_liabilities'] as String)
              : null,
      selling_liabilities:
          stellarAsset['selling_liabilities'] != null
              ? double.parse(stellarAsset['selling_liabilities'] as String)
              : null,
      last_modified_ledger: stellarAsset['last_modified_ledger'] as int?,
      last_modified_time:
          stellarAsset['last_modified_time'] != null
              ? DateTime.parse(stellarAsset['last_modified_time'] as String)
              : null,
      sponsor: stellarAsset['sponsor'] as String?,
      flags:
          stellarAsset['flags'] != null
              ? Map<String, bool>.from(stellarAsset['flags'] as Map)
              : null,
      paging_token: stellarAsset['paging_token'] as String?,
      is_clawback_enabled: stellarAsset['is_clawback_enabled'] as bool?,
      is_authorized_to_maintain_liabilities:
          stellarAsset['is_authorized_to_maintain_liabilities'] as bool?,
      is_authorized_to_maintain_offers:
          stellarAsset['is_authorized_to_maintain_offers'] as bool?,
      is_authorized_to_maintain_trustlines:
          stellarAsset['is_authorized_to_maintain_trustlines'] as bool?,
      is_authorized_to_maintain_claimable_balances:
          stellarAsset['is_authorized_to_maintain_claimable_balances'] as bool?,
      is_authorized_to_maintain_liquidity_pools:
          stellarAsset['is_authorized_to_maintain_liquidity_pools'] as bool?,
      is_authorized_to_maintain_contracts:
          stellarAsset['is_authorized_to_maintain_contracts'] as bool?,
    );
  }

  /// Creates an AssetModel from a StellarAssetInfo
  /// @param stellarAssetInfo The StellarAssetInfo object from the Stellar SDK
  /// @param id Optional custom ID, if not provided will be generated
  factory AssetModel.fromStellarAssetInfo(
    Map<String, dynamic> stellarAssetInfo, {
    String? id,
  }) {
    return AssetModel(
      id:
          id ??
          'stellar_info_${stellarAssetInfo['code']}_${stellarAssetInfo['issuer'] ?? 'native'}',
      asset_code: stellarAssetInfo['code'] as String,
      name: stellarAssetInfo['name'] as String,
      symbol: stellarAssetInfo['code'] as String,
      asset_type: stellarAssetInfo['type'] as String,
      network: 'stellar',
      asset_issuer: stellarAssetInfo['issuer'] as String?,
      issuer_name: stellarAssetInfo['issuer_name'] as String?,
      is_verified: stellarAssetInfo['is_verified'] as bool? ?? false,
      domain: stellarAssetInfo['domain'] as String?,
      num_accounts: stellarAssetInfo['num_accounts'] as int?,
      amount:
          stellarAssetInfo['amount'] != null
              ? double.parse(stellarAssetInfo['amount'] as String)
              : null,
      logo_url: stellarAssetInfo['logo_url'] as String?,
      description: stellarAssetInfo['description'] as String?,
      decimals: stellarAssetInfo['decimals'] as int? ?? 7,
      num_claimable_balances:
          stellarAssetInfo['num_claimable_balances'] as int?,
      num_liquidity_pools: stellarAssetInfo['num_liquidity_pools'] as int?,
      num_contracts: stellarAssetInfo['num_contracts'] as int?,
      accounts_with_trustlines:
          stellarAssetInfo['accounts_with_trustlines'] as int?,
      accounts_with_offers: stellarAssetInfo['accounts_with_offers'] as int?,
      accounts_with_balance: stellarAssetInfo['accounts_with_balance'] as int?,
      accounts_with_liabilities:
          stellarAssetInfo['accounts_with_liabilities'] as int?,
      accounts_with_sponsoring:
          stellarAssetInfo['accounts_with_sponsoring'] as int?,
      accounts_with_sponsored:
          stellarAssetInfo['accounts_with_sponsored'] as int?,
      accounts_with_claimable_balances:
          stellarAssetInfo['accounts_with_claimable_balances'] as int?,
      accounts_with_liquidity_pools:
          stellarAssetInfo['accounts_with_liquidity_pools'] as int?,
      accounts_with_contracts:
          stellarAssetInfo['accounts_with_contracts'] as int?,
    );
  }

  /// Creates an AssetModel from a StellarBalance
  /// @param stellarBalance The StellarBalance object from the Stellar SDK
  /// @param id Optional custom ID, if not provided will be generated
  factory AssetModel.fromStellarBalance(
    Map<String, dynamic> stellarBalance, {
    String? id,
  }) {
    return AssetModel(
      id:
          id ??
          'stellar_balance_${stellarBalance['asset_code']}_${stellarBalance['asset_issuer'] ?? 'native'}',
      asset_code: stellarBalance['asset_code'] as String,
      name:
          stellarBalance['asset_code']
              as String, // Default to code if name not available
      symbol: stellarBalance['asset_code'] as String,
      asset_type: stellarBalance['asset_type'] as String,
      network: 'stellar',
      asset_issuer: stellarBalance['asset_issuer'] as String?,
      balance:
          stellarBalance['balance'] != null
              ? double.parse(stellarBalance['balance'] as String)
              : null,
      buying_liabilities:
          stellarBalance['buying_liabilities'] != null
              ? double.parse(stellarBalance['buying_liabilities'] as String)
              : null,
      selling_liabilities:
          stellarBalance['selling_liabilities'] != null
              ? double.parse(stellarBalance['selling_liabilities'] as String)
              : null,
      last_modified_ledger: stellarBalance['last_modified_ledger'] as int?,
      last_modified_time:
          stellarBalance['last_modified_time'] != null
              ? DateTime.parse(stellarBalance['last_modified_time'] as String)
              : null,
      sponsor: stellarBalance['sponsor'] as String?,
      is_clawback_enabled: stellarBalance['is_clawback_enabled'] as bool?,
      is_authorized_to_maintain_liabilities:
          stellarBalance['is_authorized_to_maintain_liabilities'] as bool?,
      is_authorized_to_maintain_offers:
          stellarBalance['is_authorized_to_maintain_offers'] as bool?,
      is_authorized_to_maintain_trustlines:
          stellarBalance['is_authorized_to_maintain_trustlines'] as bool?,
      is_authorized_to_maintain_claimable_balances:
          stellarBalance['is_authorized_to_maintain_claimable_balances']
              as bool?,
      is_authorized_to_maintain_liquidity_pools:
          stellarBalance['is_authorized_to_maintain_liquidity_pools'] as bool?,
      is_authorized_to_maintain_contracts:
          stellarBalance['is_authorized_to_maintain_contracts'] as bool?,
    );
  }

  /// Merges multiple Stellar data sources into a single AssetModel
  /// @param stellarAsset The StellarAsset object
  /// @param stellarAssetInfo The StellarAssetInfo object
  /// @param stellarBalance The StellarBalance object
  /// @param id Optional custom ID, if not provided will be generated
  factory AssetModel.fromStellarData({
    Map<String, dynamic>? stellarAsset,
    Map<String, dynamic>? stellarAssetInfo,
    Map<String, dynamic>? stellarBalance,
    String? id,
  }) {
    // Start with base data from StellarAsset if available
    var model =
        stellarAsset != null
            ? AssetModel.fromStellarAsset(stellarAsset, id: id)
            : AssetModel(
              id: id ?? 'stellar_unknown',
              asset_code: 'UNKNOWN',
              name: 'Unknown Asset',
              symbol: 'UNKNOWN',
              asset_type: 'unknown',
              network: 'stellar',
            );

    // Merge with StellarAssetInfo if available
    if (stellarAssetInfo != null) {
      final infoModel = AssetModel.fromStellarAssetInfo(
        stellarAssetInfo,
        id: model.id,
      );
      model = AssetModel(
        id: model.id,
        asset_code: model.asset_code,
        name: infoModel.name,
        symbol: model.symbol,
        asset_type: model.asset_type,
        network: model.network,
        asset_issuer: model.asset_issuer,
        issuer_name: infoModel.issuer_name,
        is_verified: infoModel.is_verified,
        domain: infoModel.domain,
        num_accounts: infoModel.num_accounts,
        amount: infoModel.amount,
        logo_url: infoModel.logo_url,
        description: infoModel.description,
        decimals: infoModel.decimals,
        is_authorized: model.is_authorized,
        limit: model.limit,
        balance: model.balance,
        buying_liabilities: model.buying_liabilities,
        selling_liabilities: model.selling_liabilities,
        last_modified_ledger: model.last_modified_ledger,
        last_modified_time: model.last_modified_time,
        sponsor: model.sponsor,
        flags: model.flags,
        paging_token: model.paging_token,
        is_clawback_enabled: model.is_clawback_enabled,
        is_authorized_to_maintain_liabilities:
            model.is_authorized_to_maintain_liabilities,
        is_authorized_to_maintain_offers:
            model.is_authorized_to_maintain_offers,
        is_authorized_to_maintain_trustlines:
            model.is_authorized_to_maintain_trustlines,
        is_authorized_to_maintain_claimable_balances:
            model.is_authorized_to_maintain_claimable_balances,
        is_authorized_to_maintain_liquidity_pools:
            model.is_authorized_to_maintain_liquidity_pools,
        is_authorized_to_maintain_contracts:
            model.is_authorized_to_maintain_contracts,
        num_claimable_balances: infoModel.num_claimable_balances,
        num_liquidity_pools: infoModel.num_liquidity_pools,
        num_contracts: infoModel.num_contracts,
        accounts_with_trustlines: infoModel.accounts_with_trustlines,
        accounts_with_offers: infoModel.accounts_with_offers,
        accounts_with_balance: infoModel.accounts_with_balance,
        accounts_with_liabilities: infoModel.accounts_with_liabilities,
        accounts_with_sponsoring: infoModel.accounts_with_sponsoring,
        accounts_with_sponsored: infoModel.accounts_with_sponsored,
        accounts_with_claimable_balances:
            infoModel.accounts_with_claimable_balances,
        accounts_with_liquidity_pools: infoModel.accounts_with_liquidity_pools,
        accounts_with_contracts: infoModel.accounts_with_contracts,
        metadata: model.metadata,
      );
    }

    // Merge with StellarBalance if available
    if (stellarBalance != null) {
      final balanceModel = AssetModel.fromStellarBalance(
        stellarBalance,
        id: model.id,
      );
      model = AssetModel(
        id: model.id,
        asset_code: model.asset_code,
        name: model.name,
        symbol: model.symbol,
        asset_type: model.asset_type,
        network: model.network,
        asset_issuer: model.asset_issuer,
        issuer_name: model.issuer_name,
        is_verified: model.is_verified,
        domain: model.domain,
        num_accounts: model.num_accounts,
        amount: model.amount,
        logo_url: model.logo_url,
        description: model.description,
        decimals: model.decimals,
        is_authorized: model.is_authorized,
        limit: model.limit,
        balance: balanceModel.balance,
        buying_liabilities: balanceModel.buying_liabilities,
        selling_liabilities: balanceModel.selling_liabilities,
        last_modified_ledger: balanceModel.last_modified_ledger,
        last_modified_time: balanceModel.last_modified_time,
        sponsor: balanceModel.sponsor,
        flags: model.flags,
        paging_token: model.paging_token,
        is_clawback_enabled: balanceModel.is_clawback_enabled,
        is_authorized_to_maintain_liabilities:
            balanceModel.is_authorized_to_maintain_liabilities,
        is_authorized_to_maintain_offers:
            balanceModel.is_authorized_to_maintain_offers,
        is_authorized_to_maintain_trustlines:
            balanceModel.is_authorized_to_maintain_trustlines,
        is_authorized_to_maintain_claimable_balances:
            balanceModel.is_authorized_to_maintain_claimable_balances,
        is_authorized_to_maintain_liquidity_pools:
            balanceModel.is_authorized_to_maintain_liquidity_pools,
        is_authorized_to_maintain_contracts:
            balanceModel.is_authorized_to_maintain_contracts,
        num_claimable_balances: model.num_claimable_balances,
        num_liquidity_pools: model.num_liquidity_pools,
        num_contracts: model.num_contracts,
        accounts_with_trustlines: model.accounts_with_trustlines,
        accounts_with_offers: model.accounts_with_offers,
        accounts_with_balance: model.accounts_with_balance,
        accounts_with_liabilities: model.accounts_with_liabilities,
        accounts_with_sponsoring: model.accounts_with_sponsoring,
        accounts_with_sponsored: model.accounts_with_sponsored,
        accounts_with_claimable_balances:
            model.accounts_with_claimable_balances,
        accounts_with_liquidity_pools: model.accounts_with_liquidity_pools,
        accounts_with_contracts: model.accounts_with_contracts,
        metadata: model.metadata,
      );
    }

    return model;
  }

  @override
  List<Object?> get props => [
    id,
    asset_code,
    name,
    symbol,
    asset_type,
    network,
    asset_issuer,
    issuer_name,
    is_verified,
    domain,
    num_accounts,
    amount,
    logo_url,
    description,
    decimals,
    is_authorized,
    limit,
    balance,
    buying_liabilities,
    selling_liabilities,
    last_modified_ledger,
    last_modified_time,
    sponsor,
    flags,
    paging_token,
    is_clawback_enabled,
    is_authorized_to_maintain_liabilities,
    is_authorized_to_maintain_offers,
    is_authorized_to_maintain_trustlines,
    is_authorized_to_maintain_claimable_balances,
    is_authorized_to_maintain_liquidity_pools,
    is_authorized_to_maintain_contracts,
    num_claimable_balances,
    num_liquidity_pools,
    num_contracts,
    accounts_with_trustlines,
    accounts_with_offers,
    accounts_with_balance,
    accounts_with_liabilities,
    accounts_with_sponsoring,
    accounts_with_sponsored,
    accounts_with_claimable_balances,
    accounts_with_liquidity_pools,
    accounts_with_contracts,
    metadata,
  ];
}
