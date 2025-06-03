import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/data/datasources/crypto_datasource.dart';
import 'package:nemorixpay/features/crypto/data/models/asset_model.dart';
import 'package:nemorixpay/features/crypto/data/models/crypto_price_point_model.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart';

/// @file        crypto_datasource_impl.dart
/// @brief       Data source for crypto price operations.
/// @details     Handles the data operations for crypto prices.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CryptoDataSourceImpl implements CryptoDataSource {
  final Map<String, AssetModel> _assetCache = {};
  final Random _random = Random();
  final String _apiBaseUrl;
  final bool _useMockData;
  final StellarDataSource _stellarDataSource;

  CryptoDataSourceImpl({
    String? apiBaseUrl,
    bool useMockData = true,
    required StellarDataSource stellarDataSource,
  }) : _apiBaseUrl = apiBaseUrl ?? 'https://api.example.com',
       _useMockData = useMockData,
       _stellarDataSource = stellarDataSource;

  @override
  Future<AssetModel> getCurrentPrice(String symbol) async {
    if (_useMockData) {
      return _getMockPrice(symbol);
    }
    return _getApiPrice(symbol);
  }

  @override
  Future<AssetModel> updatePrice(String symbol) async {
    if (_useMockData) {
      return _updateMockPrice(symbol);
    }
    return _getApiPrice(symbol);
  }

  @override
  Future<List<CryptoPricePointModel>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  }) async {
    if (_useMockData) {
      return _getMockHistory(symbol, start, end);
    }
    return _getApiHistory(symbol, start, end);
  }

  @override
  Future<List<AssetModel>> getAssetsList() async {
    try {
      // Get available assets from Stellar
      final availableAssets = await _stellarDataSource.getAvailableAssets();

      // Transform to AssetModel
      final assets =
          availableAssets.map((stellarAsset) {
            return AssetModel(
              name: stellarAsset.name,
              symbol: stellarAsset.assetCode,
              logoPath:
                  stellarAsset.logoUrl ?? 'assets/images/default_asset.png',
              currentPrice: 0.0, // TODO: Implement price fetching
              priceChange: 0.0,
              priceChangePercentage: 0.0,
              marketCap: 0.0,
              volume: 0.0,
              high24h: 0.0,
              low24h: 0.0,
              circulatingSupply: 0.0,
              totalSupply: 0.0,
              maxSupply: null,
              ath: 0.0,
              athChangePercentage: 0.0,
              athDate: DateTime.now(),
              atl: 0.0,
              atlChangePercentage: 0.0,
              atlDate: DateTime.now(),
              lastUpdated: DateTime.now(),
              isFavorite: false,
            );
          }).toList();

      return assets;
    } catch (e) {
      throw AssetFailure.assetsListFailed(e.toString());
    }
  }

  // Métodos para datos mock
  Future<AssetModel> _getMockPrice(String symbol) async {
    if (!_assetCache.containsKey(symbol)) {
      throw AssetFailure.invalidSymbol('Asset not found: $symbol');
    }
    return _assetCache[symbol]!;
  }

  Future<AssetModel> _updateMockPrice(String symbol) async {
    if (!_assetCache.containsKey(symbol)) {
      throw AssetFailure.invalidSymbol('Asset not found: $symbol');
    }

    final currentAsset = _assetCache[symbol]!;
    final variation = (_random.nextDouble() * 0.02) - 0.01;
    final newPrice = currentAsset.currentPrice * (1 + variation);

    final updatedAsset = currentAsset.copyWith(
      currentPrice: newPrice,
      lastUpdated: DateTime.now(),
    );

    _assetCache[symbol] = updatedAsset;
    return updatedAsset;
  }

  Future<List<CryptoPricePointModel>> _getMockHistory(
    String symbol,
    DateTime start,
    DateTime end,
  ) async {
    if (!_assetCache.containsKey(symbol)) {
      throw AssetFailure.invalidSymbol('Asset not found: $symbol');
    }

    final List<CryptoPricePointModel> history = [];
    final currentAsset = _assetCache[symbol]!;

    for (var i = 0; i < 24; i++) {
      final timestamp = start.add(Duration(hours: i));
      if (timestamp.isAfter(end)) break;

      final variation = (_random.nextDouble() * 0.02) - 0.01;
      final price = currentAsset.currentPrice * (1 + variation);

      history.add(
        CryptoPricePointModel(
          price: price,
          volume: currentAsset.volume * (1 + variation),
          marketCap: currentAsset.marketCap * (1 + variation),
          timestamp: timestamp,
        ),
      );
    }

    return history;
  }

  // Métodos para API real
  Future<AssetModel> _getApiPrice(String symbol) async {
    try {
      final response = await http.get(
        Uri.parse('$_apiBaseUrl/crypto/price/$symbol'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AssetModel.fromJson(data);
      } else {
        throw AssetFailure.priceUpdateFailed(
          'Failed to load price: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Fallback a datos mock si la API falla
      if (_assetCache.containsKey(symbol)) {
        return _getMockPrice(symbol);
      }
      throw AssetFailure.networkError('Failed to load price: _getApiPrice()');
    }
  }

  Future<List<CryptoPricePointModel>> _getApiHistory(
    String symbol,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_apiBaseUrl/crypto/history/$symbol?start=${start.toIso8601String()}&end=${end.toIso8601String()}',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data
            .map((json) => CryptoPricePointModel.fromJson(json))
            .toList();
      } else {
        throw AssetFailure.priceHistoryNotFound(
          'Failed to load history: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Fallback a datos mock si la API falla
      if (_assetCache.containsKey(symbol)) {
        return _getMockHistory(symbol, start, end);
      }
      throw AssetFailure.networkError(
        'Failed to load history: _getApiHistory()',
      );
    }
  }

  // Método para inicializar datos mock
  void initializeMockData(AssetModel asset) {
    _assetCache[asset.symbol] = asset;
  }
}
