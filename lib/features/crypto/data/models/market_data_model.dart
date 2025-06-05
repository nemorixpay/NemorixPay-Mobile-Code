import 'package:equatable/equatable.dart';
import '../../domain/entities/market_data_entity.dart';

/// @file        market_data_model.dart
/// @brief       Model class representing market data for a crypto asset.
/// @details     Contains dynamic market data such as price, volume, market cap, and historical highs/lows.
/// @author      Miguel Fagundez
/// @date        2025-06-04
/// @version     1.0
/// @copyright   Apache 2.0 License
class MarketDataModel extends Equatable {
  final double currentPrice;
  final double priceChange;
  final double priceChangePercentage;
  final double marketCap;
  final double volume;
  final double high24h;
  final double low24h;
  final double circulatingSupply;
  final double totalSupply;
  final double maxSupply;
  final double ath;
  final double athChangePercentage;
  final DateTime athDate;
  final double atl;
  final double atlChangePercentage;
  final DateTime atlDate;
  final DateTime lastUpdated;

  const MarketDataModel({
    required this.currentPrice,
    required this.priceChange,
    required this.priceChangePercentage,
    required this.marketCap,
    required this.volume,
    required this.high24h,
    required this.low24h,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.lastUpdated,
  });

  factory MarketDataModel.fromJson(Map<String, dynamic> json) {
    return MarketDataModel(
      currentPrice: (json['current_price'] as num).toDouble(),
      priceChange: (json['price_change'] as num).toDouble(),
      priceChangePercentage:
          (json['price_change_percentage'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      high24h: (json['high_24h'] as num).toDouble(),
      low24h: (json['low_24h'] as num).toDouble(),
      circulatingSupply: (json['circulating_supply'] as num).toDouble(),
      totalSupply: (json['total_supply'] as num).toDouble(),
      maxSupply: (json['max_supply'] as num).toDouble(),
      ath: (json['ath'] as num).toDouble(),
      athChangePercentage: (json['ath_change_percentage'] as num).toDouble(),
      athDate: DateTime.parse(json['ath_date'] as String),
      atl: (json['atl'] as num).toDouble(),
      atlChangePercentage: (json['atl_change_percentage'] as num).toDouble(),
      atlDate: DateTime.parse(json['atl_date'] as String),
      lastUpdated: DateTime.parse(json['last_updated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_price': currentPrice,
      'price_change': priceChange,
      'price_change_percentage': priceChangePercentage,
      'market_cap': marketCap,
      'volume': volume,
      'high_24h': high24h,
      'low_24h': low24h,
      'circulating_supply': circulatingSupply,
      'total_supply': totalSupply,
      'max_supply': maxSupply,
      'ath': ath,
      'ath_change_percentage': athChangePercentage,
      'ath_date': athDate.toIso8601String(),
      'atl': atl,
      'atl_change_percentage': atlChangePercentage,
      'atl_date': atlDate.toIso8601String(),
      'last_updated': lastUpdated.toIso8601String(),
    };
  }

  MarketDataEntity toEntity() {
    return MarketDataEntity(
      currentPrice: currentPrice,
      priceChange: priceChange,
      priceChangePercentage: priceChangePercentage,
      marketCap: marketCap,
      volume: volume,
      high24h: high24h,
      low24h: low24h,
      circulatingSupply: circulatingSupply,
      totalSupply: totalSupply,
      maxSupply: maxSupply,
      ath: ath,
      athChangePercentage: athChangePercentage,
      athDate: athDate,
      atl: atl,
      atlChangePercentage: atlChangePercentage,
      atlDate: atlDate,
      lastUpdated: lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
    currentPrice,
    priceChange,
    priceChangePercentage,
    marketCap,
    volume,
    high24h,
    low24h,
    circulatingSupply,
    totalSupply,
    maxSupply,
    ath,
    athChangePercentage,
    athDate,
    atl,
    atlChangePercentage,
    atlDate,
    lastUpdated,
  ];
}
