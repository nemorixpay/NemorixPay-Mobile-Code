import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto_price_point.freezed.dart';
part 'crypto_price_point.g.dart';

/// @file        crypto_price_point.dart
/// @brief       Entity for cryptocurrency price points with detailed information.
/// @details     This class represents a single price point in a cryptocurrency's price history,
///              including price, volume, market cap, and timestamp.
/// @author      Miguel Fagundez
/// @date        2025-04-15
/// @version     1.0
/// @copyright   Apache 2.0 License
@freezed
class CryptoPricePoint with _$CryptoPricePoint {
  const factory CryptoPricePoint({
    required double price,
    required double volume,
    required double marketCap,
    required DateTime timestamp,
    @Default(0.0) double change24h,
    @Default(0.0) double high24h,
    @Default(0.0) double low24h,
    @Default(0.0) double open24h,
  }) = _CryptoPricePoint;

  factory CryptoPricePoint.fromJson(Map<String, dynamic> json) =>
      _$CryptoPricePointFromJson(json);
}
