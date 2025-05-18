import '../entities/asset_entity.dart';
import '../entities/asset_price_point.dart';

/// @file        asset_repository.dart
/// @brief       Repository interface for asset operations.
/// @details     Defines the contract for asset data operations.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class AssetRepository {
  /// Get current price for an asset
  Future<AssetEntity> getCurrentPrice(String symbol);

  /// Update price for an asset
  Future<AssetEntity> updatePrice(String symbol);

  /// Get price history for an asset
  Future<List<AssetPricePoint>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  });
}
