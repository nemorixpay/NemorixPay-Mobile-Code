import 'package:equatable/equatable.dart';
import '../../domain/entities/crypto_price_point.dart';

/// @file        crypto_price_point_model.dart
/// @brief       Data model for crypto price point information.
/// @details     Represents a price point in the data layer, providing methods for
///              JSON serialization/deserialization and conversion to/from
///              domain entities. Includes price, volume, market cap and timestamp
///              data for a specific point in time.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.0
/// @copyright   Apache 2.0 License

class CryptoPricePointModel extends Equatable {
  final double price;
  final double volume;
  final double marketCap;
  final DateTime timestamp;

  const CryptoPricePointModel({
    required this.price,
    required this.volume,
    required this.marketCap,
    required this.timestamp,
  });

  factory CryptoPricePointModel.fromJson(Map<String, dynamic> json) {
    return CryptoPricePointModel(
      price: (json['price'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      marketCap: (json['marketCap'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'volume': volume,
      'marketCap': marketCap,
      'timestamp': timestamp.toUtc().toIso8601String(),
    };
  }

  CryptoPricePoint toEntity() {
    return CryptoPricePoint(
      price: price,
      volume: volume,
      marketCap: marketCap,
      timestamp: timestamp,
    );
  }

  CryptoPricePointModel copyWith({
    double? price,
    double? volume,
    double? marketCap,
    DateTime? timestamp,
  }) {
    return CryptoPricePointModel(
      price: price ?? this.price,
      volume: volume ?? this.volume,
      marketCap: marketCap ?? this.marketCap,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [price, volume, marketCap, timestamp];
}
