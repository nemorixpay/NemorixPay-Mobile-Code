// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CryptoImpl _$$CryptoImplFromJson(Map<String, dynamic> json) => _$CryptoImpl(
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  project: json['project'] as String,
  logoPath: json['logoPath'] as String,
  currentPrice: (json['currentPrice'] as num).toDouble(),
  priceHistory: (json['priceHistory'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      (e as List<dynamic>)
          .map((e) => CryptoPricePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  ),
  marketCap: (json['marketCap'] as num).toDouble(),
  volume: (json['volume'] as num).toDouble(),
  circulatingSupply: (json['circulatingSupply'] as num).toDouble(),
  totalSupply: (json['totalSupply'] as num).toDouble(),
  allTimeHigh: (json['allTimeHigh'] as num).toDouble(),
  performance: (json['performance'] as num).toDouble(),
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$$CryptoImplToJson(_$CryptoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'project': instance.project,
      'logoPath': instance.logoPath,
      'currentPrice': instance.currentPrice,
      'priceHistory': instance.priceHistory,
      'marketCap': instance.marketCap,
      'volume': instance.volume,
      'circulatingSupply': instance.circulatingSupply,
      'totalSupply': instance.totalSupply,
      'allTimeHigh': instance.allTimeHigh,
      'performance': instance.performance,
      'isFavorite': instance.isFavorite,
    };
