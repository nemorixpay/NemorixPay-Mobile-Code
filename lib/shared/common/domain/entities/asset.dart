import 'package:equatable/equatable.dart';
import '../../data/models/asset_model.dart';

/// @file        asset.dart
/// @brief       Core entity representing a generic asset in the system.
/// @details     This entity is used throughout the application to represent
///              any type of asset (Stellar, Crypto, etc.) and provides
///              a unified interface for asset data.
/// @author      Miguel Fagundez
/// @date        2025-05-30
/// @version     1.0
/// @copyright   Apache 2.0 License
class Asset extends Equatable {
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

  const Asset({
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

  /// Creates a native asset (e.g., XLM, ETH)
  /// @param code The asset code (e.g., 'XLM', 'ETH')
  /// @param network The network where the asset exists (e.g., 'stellar', 'ethereum')
  /// @param name Optional name, defaults to code
  /// @param symbol Optional symbol, defaults to code
  /// @param decimals Optional number of decimals, defaults to 7
  static Asset createNative({
    required String code,
    required String network,
    String? name,
    String? symbol,
    int decimals = 7,
  }) {
    return Asset(
      id: '${network}_${code}_native',
      asset_code: code,
      name: name ?? code,
      symbol: symbol ?? code,
      asset_type: 'native',
      network: network,
      is_verified: true,
      decimals: decimals,
      is_authorized: true,
    );
  }

  /// Checks if this is a native asset (e.g., XLM, ETH)
  bool isNative() => asset_type == 'native';

  /// Checks if this asset is on the Stellar network
  bool isStellar() => network == 'stellar';

  /// Checks if this asset has been verified
  bool isVerified() => is_verified;

  /// Checks if this asset has a positive balance
  bool hasBalance() => balance != null && balance! > 0;

  /// Gets the available balance (total balance minus liabilities)
  double getAvailableBalance() {
    if (balance == null) return 0;
    final liabilities = (buying_liabilities ?? 0) + (selling_liabilities ?? 0);
    return balance! - liabilities;
  }

  /// Gets the total amount reserved in liabilities
  double getReservedAmount() {
    return (buying_liabilities ?? 0) + (selling_liabilities ?? 0);
  }

  /// Gets the display name (falls back to asset code if name is empty)
  String getDisplayName() => name.isNotEmpty ? name : asset_code;

  /// Gets the full asset code including issuer for non-native assets
  String getFullCode() => isNative() ? asset_code : '$asset_code:$asset_issuer';

  /// Gets the formatted balance with symbol
  String getFormattedBalance() =>
      '${balance?.toStringAsFixed(decimals) ?? '0'} $symbol';

  /// Checks if the asset can maintain liabilities
  bool canMaintainLiabilities() =>
      is_authorized_to_maintain_liabilities ?? false;

  /// Checks if the asset can maintain offers
  bool canMaintainOffers() => is_authorized_to_maintain_offers ?? false;

  /// Checks if the asset can maintain trustlines
  bool canMaintainTrustlines() => is_authorized_to_maintain_trustlines ?? false;

  /// Checks if the asset can maintain claimable balances
  bool canMaintainClaimableBalances() =>
      is_authorized_to_maintain_claimable_balances ?? false;

  /// Checks if the asset can maintain liquidity pools
  bool canMaintainLiquidityPools() =>
      is_authorized_to_maintain_liquidity_pools ?? false;

  /// Checks if the asset can maintain contracts
  bool canMaintainContracts() => is_authorized_to_maintain_contracts ?? false;

  /// Checks if this asset is the same as another asset
  /// Compares code, issuer and network
  bool isSameAsset(Asset other) =>
      asset_code == other.asset_code &&
      asset_issuer == other.asset_issuer &&
      network == other.network;

  /// Converts the entity to an [AssetModel]
  AssetModel toModel() {
    return AssetModel(
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
