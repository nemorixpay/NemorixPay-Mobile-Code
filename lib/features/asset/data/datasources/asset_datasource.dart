import 'package:nemorixpay/features/asset/data/models/asset_model.dart';
import 'package:nemorixpay/features/asset/data/models/asset_price_point_model.dart';

/// @file        asset_price_datasource.dart
/// @brief       Data source contract for asset operations.
/// @details     Handles the data operations for asset.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class AssetDataSource {
  Future<AssetModel> getCurrentPrice(String symbol);
  Future<AssetModel> updatePrice(String symbol);
  Future<List<AssetPricePointModel>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  });
}
