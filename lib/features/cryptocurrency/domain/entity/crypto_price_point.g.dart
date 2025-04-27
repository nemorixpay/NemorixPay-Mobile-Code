// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_price_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CryptoPricePointImpl _$$CryptoPricePointImplFromJson(
  Map<String, dynamic> json,
) => _$CryptoPricePointImpl(
  price: (json['price'] as num).toDouble(),
  volume: (json['volume'] as num).toDouble(),
  marketCap: (json['marketCap'] as num).toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
  change24h: (json['change24h'] as num?)?.toDouble() ?? 0.0,
  high24h: (json['high24h'] as num?)?.toDouble() ?? 0.0,
  low24h: (json['low24h'] as num?)?.toDouble() ?? 0.0,
  open24h: (json['open24h'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$CryptoPricePointImplToJson(
  _$CryptoPricePointImpl instance,
) => <String, dynamic>{
  'price': instance.price,
  'volume': instance.volume,
  'marketCap': instance.marketCap,
  'timestamp': instance.timestamp.toIso8601String(),
  'change24h': instance.change24h,
  'high24h': instance.high24h,
  'low24h': instance.low24h,
  'open24h': instance.open24h,
};
