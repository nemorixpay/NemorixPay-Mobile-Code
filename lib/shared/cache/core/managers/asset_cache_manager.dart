import 'package:equatable/equatable.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';

/// @file        asset_cache_manager.dart
/// @brief       Singleton class managing asset cache state.
/// @details     Acts as a cache layer and provides centralized access to assets
///              from any feature in the application. Implements caching logic
///              to optimize performance and reduce API calls.
/// @author      Miguel Fagundez
/// @date        2025-05-30
/// @version     1.0
/// @copyright   Apache 2.0 License
// ignore: must_be_immutable
class AssetCacheManager extends Equatable {
  /// Singleton instance
  static AssetCacheManager? _instance;

  /// Expiration duration for cache
  final Duration _expirationDuration;

  /// Factory constructor to get the singleton instance
  factory AssetCacheManager({Duration? expirationDuration}) {
    _instance ??= AssetCacheManager._internal(
      expirationDuration: expirationDuration ?? const Duration(minutes: 5),
    );
    return _instance!;
  }

  /// Private constructor for singleton pattern
  AssetCacheManager._internal({required Duration expirationDuration})
    : _expirationDuration = expirationDuration;

  /// Map of assets indexed by their ID
  final Map<String, AssetEntity> _assets = {};

  /// Timestamp of the last update
  DateTime? _lastUpdate;

  /// Flag indicating if an update is in progress
  bool _isLoading = false;

  /// List of all assets in the system
  List<AssetEntity> get allAssets => _assets.values.toList();

  /// Get a specific asset by its ID
  AssetEntity? getAsset(String id) => _assets[id];

  /// Whether an update operation is in progress
  bool get isLoading => _isLoading;

  /// Whether the assets need to be refreshed (older than expiration duration)
  bool get needsRefresh =>
      _lastUpdate == null ||
      DateTime.now().difference(_lastUpdate!) > _expirationDuration;

  /// Gets all native assets (XLM in Stellar network)
  List<AssetEntity> get nativeAssets =>
      _assets.values.where((asset) => asset.isNative()).toList();

  /// Gets all Stellar assets
  List<AssetEntity> get stellarAssets =>
      _assets.values.where((asset) => asset.isStellar()).toList();

  /// Gets all verified assets
  List<AssetEntity> get verifiedAssets =>
      _assets.values.where((asset) => asset.isVerified()).toList();

  /// Gets all assets with positive balance
  List<AssetEntity> get assetsWithBalance =>
      _assets.values.where((asset) => asset.hasBalance()).toList();

  /// Gets an asset by its code and network
  AssetEntity? getAssetByCode(String code, String network) {
    try {
      return _assets.values.firstWhere(
        (asset) => asset.asset_code == code && asset.network == network,
      );
    } catch (e) {
      return null;
    }
  }

  /// Gets all assets for a specific network
  List<AssetEntity> getAssetsByNetwork(String network) =>
      _assets.values.where((asset) => asset.network == network).toList();

  /// Gets all assets with a specific type
  List<AssetEntity> getAssetsByType(String type) =>
      _assets.values.where((asset) => asset.asset_type == type).toList();

  /// Gets all assets from a specific issuer
  List<AssetEntity> getAssetsByIssuer(String issuer) =>
      _assets.values.where((asset) => asset.asset_issuer == issuer).toList();

  /// Gets all assets that can maintain liabilities
  List<AssetEntity> getAssetsWithLiabilitiesPermission() =>
      _assets.values.where((asset) => asset.canMaintainLiabilities()).toList();

  /// Gets all assets that can maintain offers
  List<AssetEntity> getAssetsWithOffersPermission() =>
      _assets.values.where((asset) => asset.canMaintainOffers()).toList();

  /// Gets all assets that can maintain trustlines
  List<AssetEntity> getAssetsWithTrustlinesPermission() =>
      _assets.values.where((asset) => asset.canMaintainTrustlines()).toList();

  /// Updates the assets in the cache
  ///
  /// [assets] List of assets to update
  Future<void> updateAssets(List<AssetEntity> assets) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      for (var asset in assets) {
        _assets[asset.id] = asset;
      }
      _lastUpdate = DateTime.now();
    } finally {
      _isLoading = false;
    }
  }

  /// Gets assets from cache or fetches them if needed
  ///
  /// [fetchAssets] Function to fetch assets if cache is empty or stale
  Future<List<AssetEntity>> getAssetsIfNeeded(
    Future<List<AssetEntity>> Function() fetchAssets,
  ) async {
    if (!needsRefresh && _assets.isNotEmpty) {
      return allAssets;
    }

    if (_isLoading) {
      while (_isLoading) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return allAssets;
    }

    final assets = await fetchAssets();
    await updateAssets(assets);
    return assets;
  }

  /// Removes an asset from the cache
  ///
  /// [id] ID of the asset to remove
  void removeAsset(String id) {
    _assets.remove(id);
  }

  /// Clears all assets from the cache
  void clearAssets() {
    _assets.clear();
    _lastUpdate = null;
  }

  /// Gets the total number of assets
  int get assetCount => _assets.length;

  /// Gets the total number of assets for a specific network
  int getAssetCountByNetwork(String network) =>
      getAssetsByNetwork(network).length;

  /// Gets the total number of assets with a specific type
  int getAssetCountByType(String type) => getAssetsByType(type).length;

  @override
  List<Object?> get props => [_assets, _lastUpdate, _isLoading];
}
