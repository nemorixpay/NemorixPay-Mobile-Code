import 'package:freezed_annotation/freezed_annotation.dart';
import 'crypto_price_point.dart';

part 'crypto_entity.freezed.dart';
part 'crypto_entity.g.dart';

/// @file        crypto_entity.dart
/// @brief       Entity for cryptocurrency data.
/// @details     This class represents a cryptocurrency with all its properties and price history.
/// @author      Miguel Fagundez
/// @date        2025-04-26
/// @version     1.2
/// @copyright   Apache 2.0 License
@freezed
class Crypto with _$Crypto {
  const factory Crypto({
    required String name,
    required String abbreviation,
    required String project,
    required String logoPath,
    required double currentPrice,
    required Map<String, List<CryptoPricePoint>> priceHistory,
    required double marketCap,
    required double volume,
    required double circulatingSupply,
    required double totalSupply,
    required double allTimeHigh,
    required double performance,
    @Default(false) bool isFavorite,
  }) = _Crypto;

  factory Crypto.fromJson(Map<String, dynamic> json) => _$CryptoFromJson(json);
}
