import 'package:equatable/equatable.dart';
import '../../data/models/crypto_price_point_model.dart';

/// @file        crypto_price_point.dart
/// @brief       Entity class representing a crypto price point.
/// @details     This class contains price, volume, and market cap data for a specific timestamp.
/// @author      Miguel Fagundez
/// @date        05/24/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class CryptoPricePoint extends Equatable {
  final double price;
  final double volume;
  final double marketCap;
  final DateTime timestamp;

  const CryptoPricePoint({
    required this.price,
    required this.volume,
    required this.marketCap,
    required this.timestamp,
  });

  CryptoPricePointModel toModel() {
    return CryptoPricePointModel(
      price: price,
      volume: volume,
      marketCap: marketCap,
      timestamp: timestamp,
    );
  }

  @override
  List<Object?> get props => [price, volume, marketCap, timestamp];
}
