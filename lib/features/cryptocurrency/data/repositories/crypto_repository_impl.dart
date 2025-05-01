import 'package:equatable/equatable.dart';
import '../../domain/entities/crypto_entity.dart';
import '../../domain/entities/crypto_price_point.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_price_datasource.dart';

/// @file        crypto_repository_impl.dart
/// @brief       Implementation of the cryptocurrency repository.
/// @details     Provides concrete implementation of cryptocurrency data operations.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoPriceDataSource dataSource;

  CryptoRepositoryImpl(this.dataSource);

  @override
  Future<CryptoEntity> getCurrentPrice(String symbol) async {
    return await dataSource.getCurrentPrice(symbol);
  }

  @override
  Future<CryptoEntity> updatePrice(String symbol) async {
    return await dataSource.updatePrice(symbol);
  }

  @override
  Future<List<CryptoPricePoint>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  }) async {
    return await dataSource.getPriceHistory(symbol, start: start, end: end);
  }
}
