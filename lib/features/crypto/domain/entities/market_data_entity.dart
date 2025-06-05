import 'package:equatable/equatable.dart';
import '../../data/models/market_data_model.dart';

/// @file        market_data_entity.dart
/// @brief       Entity class representing market data for a crypto asset.
/// @details     Contains dynamic market data such as price, volume, market cap, and historical highs/lows.
/// @author      Miguel Fagundez
/// @date        2025-06-04
/// @version     1.0
/// @copyright   Apache 2.0 License
class MarketDataEntity extends Equatable {
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

  const MarketDataEntity({
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

  MarketDataModel toModel() {
    return MarketDataModel(
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
