import 'package:nemorixpay/features/asset/data/datasources/asset_datasource.dart';

import '../../domain/entities/asset_entity.dart';
import '../../domain/entities/asset_price_point.dart';
import '../../domain/repositories/asset_repository.dart';

/// @file        asset_repository_impl.dart
/// @brief       Implementation of the Asset repository.
/// @details     Provides concrete implementation of asset data operations.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class AssetRepositoryImpl implements AssetRepository {
  final AssetDataSource dataSource;

  AssetRepositoryImpl(this.dataSource);

  @override
  Future<AssetEntity> getCurrentPrice(String symbol) async {
    return await dataSource.getCurrentPrice(symbol);
  }

  @override
  Future<AssetEntity> updatePrice(String symbol) async {
    return await dataSource.updatePrice(symbol);
  }

  @override
  Future<List<AssetPricePoint>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  }) async {
    return await dataSource.getPriceHistory(symbol, start: start, end: end);
  }
}
