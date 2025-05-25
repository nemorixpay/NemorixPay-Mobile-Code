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
    final asset = await dataSource.getCurrentPrice(symbol);
    return asset.toEntity();
  }

  @override
  Future<AssetEntity> updatePrice(String symbol) async {
    final asset = await dataSource.updatePrice(symbol);
    return asset.toEntity();
  }

  @override
  Future<List<AssetPricePoint>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  }) async {
    final listOfAssetPointsModel = await dataSource.getPriceHistory(
      symbol,
      start: start,
      end: end,
    );
    final List<AssetPricePoint> listOfAssetPoints =
        listOfAssetPointsModel.map((model) => model.toEntity()).toList();

    return listOfAssetPoints;
  }
}
