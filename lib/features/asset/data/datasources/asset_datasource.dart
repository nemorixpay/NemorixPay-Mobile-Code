import '../../domain/entities/asset_entity.dart';
import '../../domain/entities/asset_price_point.dart';

/// @file        asset_price_datasource.dart
/// @brief       Data source contract for asset operations.
/// @details     Handles the data operations for asset.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class AssetDataSource {
  Future<AssetEntity> getCurrentPrice(String symbol);
  Future<AssetEntity> updatePrice(String symbol);
  Future<List<AssetPricePoint>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  });
}
