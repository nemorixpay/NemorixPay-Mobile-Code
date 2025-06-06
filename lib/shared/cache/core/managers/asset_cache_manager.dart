import 'package:equatable/equatable.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';

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

  /// StellarDataSource
  final StellarDataSource _stellarDataSource;

  /// Expiration duration for cache
  final Duration _expirationDuration;

  /// Factory constructor to get the singleton instance
  factory AssetCacheManager({Duration? expirationDuration}) {
    _instance ??= AssetCacheManager._internal(
      expirationDuration: expirationDuration ?? const Duration(minutes: 5),
      stellarDataSource: StellarDataSourceImpl(),
    );
    return _instance!;
  }

  /// Private constructor for singleton pattern
  AssetCacheManager._internal({
    required StellarDataSource stellarDataSource,
    required Duration expirationDuration,
  }) : _expirationDuration = expirationDuration,
       _stellarDataSource = stellarDataSource;

  /// Map of assets indexed by their ID
  final Map<String, AssetModel> _assets = {};

  /// Timestamp of the last update
  DateTime? _lastUpdate;

  /// Flag indicating if an update is in progress
  bool _isLoading = false;

  /// Whether an update operation is in progress
  bool get isLoading => _isLoading;

  /// Whether the assets need to be refreshed (older than expiration duration)
  bool get needsRefresh =>
      _lastUpdate == null ||
      DateTime.now().difference(_lastUpdate!) > _expirationDuration;

  Future<void> assetsEmpty() async {
    if (_assets.isEmpty) {
      await loadAssetsFromStellar();
    }
  }

  /// Loads assets from StellarDataSource into the cache
  Future<void> loadAssetsFromStellar() async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      final stellarAssets = await _stellarDataSource.getAvailableAssets();

      // Limpiar el caché actual
      _assets.clear();

      // Cargar los nuevos assets usando la clave única
      for (var asset in stellarAssets) {
        final key = _getAssetKey(asset.assetCode, asset.assetIssuer);
        _assets[key] = asset;
      }

      _lastUpdate = DateTime.now();
    } finally {
      _isLoading = false;
    }
  }

  /// Gets an asset by its code and network
  Future<AssetModel> getAssetByCode(String code) async {
    try {
      await assetsEmpty();
      return _assets.values.firstWhere((asset) => asset.assetCode == code);
    } catch (e) {
      throw AssetFailure.assetDetailsNotFound(
        'Failed to get asset details bycode (Asset Cache Manager): $e',
      );
    }
  }

  /// Generates a unique key for an asset based on its assetCode and assetIssuer
  String _getAssetKey(String assetCode, String? assetIssuer) {
    if (assetCode == 'XLM') {
      return 'XLM';
    }
    return assetIssuer != null ? '$assetCode:$assetIssuer' : assetCode;
  }

  /// Gets a specific asset by its assetCode and assetIssuer
  AssetModel? getAsset(String assetCode, {String? assetIssuer}) {
    try {
      final key = _getAssetKey(assetCode, assetIssuer);
      return _assets[key];
    } catch (e) {
      throw AssetFailure.assetDetailsNotFound(
        'Failed to get asset details by key (Asset Cache Manager): $e',
      );
    }
  }

  /// Updates or adds an asset to the cache
  void updateAsset(AssetModel asset) {
    final key = _getAssetKey(asset.assetCode, asset.assetIssuer);
    _assets[key] = asset;
  }

  /// Gets all stored assets
  Future<List<AssetModel>> getAllAssets() async {
    await assetsEmpty();
    return _assets.values.toList();
  }

  /// Gets all assets of a specific type (by assetCode)
  Future<List<AssetModel>> getAssetsByCode(String assetCode) async {
    await assetsEmpty();
    return _assets.values
        .where((asset) => asset.assetCode == assetCode)
        .toList();
  }

  /// Clears the cache
  Future<void> clearCache() async {
    _assets.clear();
    await assetsEmpty();
  }

  /// Gets all assets for a specific network
  Future<List<AssetModel>> getAssetsByNetwork(String network) async {
    await assetsEmpty();
    return _assets.values.where((asset) => asset.network == network).toList();
  }

  /// Gets all assets with a specific type
  Future<List<AssetModel>> getAssetsByType(String type) async {
    await assetsEmpty();
    return _assets.values.where((asset) => asset.assetType == type).toList();
  }

  /// Gets all assets from a specific issuer
  Future<List<AssetModel>> getAssetsByIssuer(String issuer) async {
    await assetsEmpty();
    return _assets.values
        .where((asset) => asset.assetIssuer == issuer)
        .toList();
  }

  /// Updates the assets in the cache
  ///
  /// [assets] List of assets to update
  Future<void> updateAssets(List<AssetModel> assets) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      for (var asset in assets) {
        final key = _getAssetKey(asset.assetCode, asset.assetIssuer);
        _assets[key] = asset;
      }
      _lastUpdate = DateTime.now();
    } finally {
      _isLoading = false;
    }
  }

  /// Gets assets from cache or fetches them if needed
  ///
  /// [fetchAssets] Function to fetch assets if cache is empty or stale
  Future<List<AssetModel>> getAssetsIfNeeded(
    Future<List<AssetModel>> Function() fetchAssets,
  ) async {
    if (!needsRefresh && _assets.isNotEmpty) {
      return getAllAssets();
    }

    if (_isLoading) {
      while (_isLoading) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return getAllAssets();
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

  /// Gets the total number of assets
  int get assetCount => _assets.length;

  /// Gets the total number of assets for a specific network
  Future<int> getAssetCountByNetwork(String network) async {
    final list = await getAssetsByNetwork(network);
    return list.length;
  }

  /// Gets all native assets (XLM in Stellar network)
  List<AssetModel> get nativeAssets =>
      _assets.values.where((asset) => asset.assetType == 'native').toList();

  /// Gets the total number of assets with a specific type
  Future<int> getAssetCountByType(String type) async {
    final list = await getAssetsByType(type);
    return list.length;
  }

  @override
  List<Object?> get props => [_assets, _lastUpdate, _isLoading];
}
