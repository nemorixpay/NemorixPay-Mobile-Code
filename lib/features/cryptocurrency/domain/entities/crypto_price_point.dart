import 'package:equatable/equatable.dart';

/// @file        crypto_price_point.dart
/// @brief       Entity class representing a cryptocurrency price point.
/// @details     This class contains price, volume, and market cap data for a specific timestamp.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
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

  factory CryptoPricePoint.fromJson(Map<String, dynamic> json) {
    return CryptoPricePoint(
      price: (json['price'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      marketCap: (json['marketCap'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  List<Object?> get props => [price, volume, marketCap, timestamp];
}
