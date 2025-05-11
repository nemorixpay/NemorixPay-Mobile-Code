import '../../domain/entities/crypto_entity.dart';
import '../../domain/entities/crypto_price_point.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// @file        crypto_price_datasource.dart
/// @brief       Data source for cryptocurrency price operations.
/// @details     Handles the data operations for cryptocurrency prices.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class CryptoPriceDataSource {
  Future<CryptoEntity> getCurrentPrice(String symbol);
  Future<CryptoEntity> updatePrice(String symbol);
  Future<List<CryptoPricePoint>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  });
}

class CryptoPriceDataSourceImpl implements CryptoPriceDataSource {
  final Map<String, CryptoEntity> _cryptoCache = {};
  final Random _random = Random();
  final String _apiBaseUrl;
  final bool _useMockData;

  CryptoPriceDataSourceImpl({String? apiBaseUrl, bool useMockData = true})
    : _apiBaseUrl = apiBaseUrl ?? 'https://api.example.com',
      _useMockData = useMockData;

  @override
  Future<CryptoEntity> getCurrentPrice(String symbol) async {
    if (_useMockData) {
      return _getMockPrice(symbol);
    }
    return _getApiPrice(symbol);
  }

  @override
  Future<CryptoEntity> updatePrice(String symbol) async {
    if (_useMockData) {
      return _updateMockPrice(symbol);
    }
    return _getApiPrice(symbol);
  }

  @override
  Future<List<CryptoPricePoint>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  }) async {
    if (_useMockData) {
      return _getMockHistory(symbol, start, end);
    }
    return _getApiHistory(symbol, start, end);
  }

  // Métodos para datos mock
  Future<CryptoEntity> _getMockPrice(String symbol) async {
    if (!_cryptoCache.containsKey(symbol)) {
      throw Exception('Cryptocurrency not found: $symbol');
    }
    return _cryptoCache[symbol]!;
  }

  Future<CryptoEntity> _updateMockPrice(String symbol) async {
    if (!_cryptoCache.containsKey(symbol)) {
      throw Exception('Cryptocurrency not found: $symbol');
    }

    final currentCrypto = _cryptoCache[symbol]!;
    final variation = (_random.nextDouble() * 0.02) - 0.01;
    final newPrice = currentCrypto.currentPrice * (1 + variation);

    final updatedCrypto = currentCrypto.copyWith(
      currentPrice: newPrice,
      lastUpdated: DateTime.now(),
    );

    _cryptoCache[symbol] = updatedCrypto;
    return updatedCrypto;
  }

  Future<List<CryptoPricePoint>> _getMockHistory(
    String symbol,
    DateTime start,
    DateTime end,
  ) async {
    final List<CryptoPricePoint> history = [];
    final currentCrypto = _cryptoCache[symbol]!;

    for (var i = 0; i < 24; i++) {
      final timestamp = start.add(Duration(hours: i));
      if (timestamp.isAfter(end)) break;

      final variation = (_random.nextDouble() * 0.02) - 0.01;
      final price = currentCrypto.currentPrice * (1 + variation);

      history.add(
        CryptoPricePoint(
          price: price,
          volume: currentCrypto.volume * (1 + variation),
          marketCap: currentCrypto.marketCap * (1 + variation),
          timestamp: timestamp,
        ),
      );
    }

    return history;
  }

  // Métodos para API real
  Future<CryptoEntity> _getApiPrice(String symbol) async {
    try {
      final response = await http.get(
        Uri.parse('$_apiBaseUrl/crypto/price/$symbol'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CryptoEntity.fromJson(data);
      } else {
        throw Exception('Failed to load price: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback a datos mock si la API falla
      if (_cryptoCache.containsKey(symbol)) {
        return _getMockPrice(symbol);
      }
      throw Exception('Failed to load price: $e');
    }
  }

  Future<List<CryptoPricePoint>> _getApiHistory(
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
        return data.map((json) => CryptoPricePoint.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load history: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback a datos mock si la API falla
      if (_cryptoCache.containsKey(symbol)) {
        return _getMockHistory(symbol, start, end);
      }
      throw Exception('Failed to load history: $e');
    }
  }

  // Método para inicializar datos mock
  void initializeMockData(CryptoEntity crypto) {
    _cryptoCache[crypto.symbol] = crypto;
  }
}
