import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/data/datasources/crypto_market_datasource.dart';
import 'package:nemorixpay/features/crypto/data/models/crypto_asset_with_market_data_model.dart';
import 'package:nemorixpay/features/crypto/data/models/market_data_model.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';

/// @file        crypto_market_datasource_impl.dart
/// @brief       Implementation of crypto market data operations.
/// @details     Provides concrete implementation for fetching and managing
///              crypto market data, including current prices, historical data,
///              and asset details.
/// @author      Miguel Fagundez
/// @date        2025-06-05
/// @version     1.0
/// @copyright   Apache 2.0 License

class CryptoMarketDataSourceImpl implements CryptoMarketDataSource {
  final Map<String, CryptoAssetWithMarketDataModel> _cryptoCache = {};
  final Random _random = Random();
  final String _apiBaseUrl;
  final bool _useMockData;
  final AssetCacheManager _assetCacheManager;

  CryptoMarketDataSourceImpl({
    String? apiBaseUrl,
    bool useMockData = true,
    required AssetCacheManager assetCacheManager,
  })  : _apiBaseUrl = apiBaseUrl ?? 'https://api.example.com',
        _useMockData = useMockData,
        _assetCacheManager = assetCacheManager;

  @override
  Future<List<CryptoAssetWithMarketDataModel>> getCryptoAssets() async {
    try {
      debugPrint('CryptoMarketDataSourceImpl - getCryptoAssets: Starting');

      // Get available assets from Stellar
      final availableAssets = await _assetCacheManager.getAllAssets();
      // Transform to CryptoAssetWithMarketDataModel
      final assets = await Future.wait(
        availableAssets.map((stellarAsset) async {
          final marketData = _useMockData
              ? _generateMockMarketData()
              : await getMarketData(stellarAsset.assetCode);

          return CryptoAssetWithMarketDataModel(
            asset: stellarAsset,
            marketData: marketData,
            isFavorite: false,
          );
        }),
      );
      return assets;
    } catch (e) {
      debugPrint('CryptoMarketDataSourceImpl - getCryptoAssets: Error: $e');
      throw AssetFailure.assetsListFailed('Failed to get assets list: $e');
    }
  }

  @override
  Future<List<CryptoAssetWithMarketDataModel>> getCryptoAccountAssets() async {
    try {
      debugPrint(
        'CryptoMarketDataSourceImpl - getCryptoAccountAssets: Starting',
      );

      // Get only account assets from Stellar
      final accountAssets = await _assetCacheManager.getAccountAssets();
      debugPrint(
        'CryptoMarketDataSourceImpl - getCryptoAccountAssets: list = ${accountAssets.length}',
      );
      // Transform to CryptoAssetWithMarketDataModel
      final assets = await Future.wait(
        accountAssets.map((asset) async {
          final marketData = _useMockData
              ? _generateMockMarketData()
              : await getMarketData(asset.assetCode);

          return CryptoAssetWithMarketDataModel(
            asset: asset,
            marketData: marketData,
            isFavorite: false,
          );
        }),
      );

      return assets;
    } catch (e) {
      debugPrint(
        'CryptoMarketDataSourceImpl - getCryptoAccountAssets: Error: $e',
      );
      throw AssetFailure.assetsListFailed(
        'Failed to get account assets list: $e',
      );
    }
  }

  @override
  Future<MarketDataModel> getMarketData(String symbol) async {
    try {
      debugPrint(
        'CryptoMarketDataSourceImpl - getMarketData: Starting for symbol: $symbol',
      );

      if (_useMockData) {
        return _getMockMarketData(symbol);
      }
      return _getApiMarketData(symbol);
    } catch (e) {
      debugPrint('CryptoMarketDataSourceImpl - getMarketData: Error: $e');
      throw AssetFailure.marketDataNotFound('Failed to get market data: $e');
    }
  }

  @override
  Future<CryptoAssetWithMarketDataModel> getCryptoAssetDetails(
    String symbol,
  ) async {
    try {
      debugPrint(
        'CryptoMarketDataSourceImpl - getCryptoAssetDetails: Starting for symbol: $symbol',
      );

      // Get asset from Stellar
      final stellarAsset = await _assetCacheManager.getAssetByCode(symbol);

      // Get market data
      final marketData = await getMarketData(symbol);

      return CryptoAssetWithMarketDataModel(
        asset: stellarAsset,
        marketData: marketData,
        isFavorite: false,
      );
    } catch (e) {
      debugPrint(
        'CryptoMarketDataSourceImpl - getCryptoAssetDetails: Error: $e',
      );
      throw AssetFailure.assetDetailsNotFound(
        'Failed to get asset details (Crypto Market DataSource): $e',
      );
    }
  }

  @override
  Future<MarketDataModel> updateMarketData(String symbol) async {
    try {
      debugPrint(
        'CryptoMarketDataSourceImpl - updateMarketData: Starting for symbol: $symbol',
      );

      if (_useMockData) {
        return _updateMockMarketData(symbol);
      }
      return _getApiMarketData(symbol);
    } catch (e) {
      debugPrint('CryptoMarketDataSourceImpl - updateMarketData: Error: $e');
      throw AssetFailure.marketDataUpdateFailed(
        'Failed to update market data: $e',
      );
    }
  }

  // Métodos privados para datos mock
  MarketDataModel _getMockMarketData(String symbol) {
    if (!_cryptoCache.containsKey(symbol)) {
      return _generateMockMarketData();
    }
    return _cryptoCache[symbol]!.marketData;
  }

  MarketDataModel _updateMockMarketData(String symbol) {
    final updatedMarketData = _generateMockMarketData();

    if (_cryptoCache.containsKey(symbol)) {
      final currentAsset = _cryptoCache[symbol]!;
      _cryptoCache[symbol] = currentAsset.copyWith(
        marketData: updatedMarketData,
      );
    }

    return updatedMarketData;
  }

  MarketDataModel _generateMockMarketData() {
    final basePrice = 1000.0 + (_random.nextDouble() * 1000);
    final variation = (_random.nextDouble() * 0.02) - 0.01;
    final price = basePrice * (1 + variation);

    return MarketDataModel(
      currentPrice: price,
      priceChange: price * variation,
      priceChangePercentage: variation * 100,
      marketCap: price * 1000000,
      volume: price * 100000,
      high24h: price * 1.1,
      low24h: price * 0.9,
      circulatingSupply: 1000000,
      totalSupply: 2000000,
      maxSupply: 21000000,
      ath: price * 2,
      athChangePercentage: -50,
      athDate: DateTime.now().subtract(const Duration(days: 30)),
      atl: price * 0.5,
      atlChangePercentage: 100,
      atlDate: DateTime.now().subtract(const Duration(days: 60)),
      lastUpdated: DateTime.now(),
    );
  }

  // Métodos privados para API real
  Future<MarketDataModel> _getApiMarketData(String symbol) async {
    try {
      final response = await http.get(
        Uri.parse('$_apiBaseUrl/crypto/market-data/$symbol'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MarketDataModel.fromJson(data);
      } else {
        throw AssetFailure.marketDataNotFound(
          'Failed to load market data: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw AssetFailure.marketDataNotFound('Failed to load market data: $e');
    }
  }

  // Método para inicializar datos mock
  void initializeMockData(CryptoAssetWithMarketDataModel asset) {
    // TODO check this line
    //_assetCache[asset.asset.symbol] = asset;
  }
}
