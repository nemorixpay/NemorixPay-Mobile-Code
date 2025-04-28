import 'package:equatable/equatable.dart';

/// @file        crypto_entity.dart
/// @brief       Entity class representing a cryptocurrency.
/// @details     This class contains all the properties needed to represent a cryptocurrency,
///             including its price, market data, and historical information.
/// @author      Miguel Fagundez
/// @date        04/28/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoEntity extends Equatable {
  final String name;
  final String symbol;
  final String logoPath;
  final double currentPrice;
  final double priceChange;
  final double priceChangePercentage;
  final double marketCap;
  final double volume;
  final double high24h;
  final double low24h;
  final double circulatingSupply;
  final double totalSupply;
  final double? maxSupply;
  final double ath;
  final double athChangePercentage;
  final DateTime athDate;
  final double atl;
  final double atlChangePercentage;
  final DateTime atlDate;
  final DateTime lastUpdated;
  final bool isFavorite;

  const CryptoEntity({
    required this.name,
    required this.symbol,
    required this.logoPath,
    required this.currentPrice,
    required this.priceChange,
    required this.priceChangePercentage,
    required this.marketCap,
    required this.volume,
    required this.high24h,
    required this.low24h,
    required this.circulatingSupply,
    required this.totalSupply,
    this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.lastUpdated,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
    name,
    symbol,
    logoPath,
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
    isFavorite,
  ];
}

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

  @override
  List<Object?> get props => [price, volume, marketCap, timestamp];
}
