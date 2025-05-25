import 'package:equatable/equatable.dart';
import '../../data/models/asset_price_point_model.dart';

/// @file        asset_price_point.dart
/// @brief       Entity class representing an asset price point.
/// @details     This class contains price, volume, and market cap data for a specific timestamp.
/// @author      Miguel Fagundez
/// @date        05/24/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class AssetPricePoint extends Equatable {
  final double price;
  final double volume;
  final double marketCap;
  final DateTime timestamp;

  const AssetPricePoint({
    required this.price,
    required this.volume,
    required this.marketCap,
    required this.timestamp,
  });

  AssetPricePointModel toModel() {
    return AssetPricePointModel(
      price: price,
      volume: volume,
      marketCap: marketCap,
      timestamp: timestamp,
    );
  }

  @override
  List<Object?> get props => [price, volume, marketCap, timestamp];
}
