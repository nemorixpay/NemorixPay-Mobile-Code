import 'package:equatable/equatable.dart';
import 'dart:math';

/// @file        crypto_entity.dart
/// @brief       Entity class representing a cryptocurrency.
/// @details     This class contains all the properties needed to represent a cryptocurrency,
///             including its price, market data, and historical information.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.1
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

  factory CryptoEntity.fromJson(Map<String, dynamic> json) {
    return CryptoEntity(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      logoPath: json['logoPath'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      priceChange: (json['priceChange'] as num).toDouble(),
      priceChangePercentage: (json['priceChangePercentage'] as num).toDouble(),
      marketCap: (json['marketCap'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      high24h: (json['high24h'] as num).toDouble(),
      low24h: (json['low24h'] as num).toDouble(),
      circulatingSupply: (json['circulatingSupply'] as num).toDouble(),
      totalSupply: (json['totalSupply'] as num).toDouble(),
      maxSupply:
          json['maxSupply'] != null
              ? (json['maxSupply'] as num).toDouble()
              : null,
      ath: (json['ath'] as num).toDouble(),
      athChangePercentage: (json['athChangePercentage'] as num).toDouble(),
      athDate: DateTime.parse(json['athDate'] as String),
      atl: (json['atl'] as num).toDouble(),
      atlChangePercentage: (json['atlChangePercentage'] as num).toDouble(),
      atlDate: DateTime.parse(json['atlDate'] as String),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  CryptoEntity copyWith({
    String? name,
    String? symbol,
    String? logoPath,
    double? currentPrice,
    double? priceChange,
    double? priceChangePercentage,
    double? marketCap,
    double? volume,
    double? high24h,
    double? low24h,
    double? circulatingSupply,
    double? totalSupply,
    double? maxSupply,
    double? ath,
    double? athChangePercentage,
    DateTime? athDate,
    double? atl,
    double? atlChangePercentage,
    DateTime? atlDate,
    DateTime? lastUpdated,
    bool? isFavorite,
  }) {
    return CryptoEntity(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      logoPath: logoPath ?? this.logoPath,
      currentPrice: currentPrice ?? this.currentPrice,
      priceChange: priceChange ?? this.priceChange,
      priceChangePercentage:
          priceChangePercentage ?? this.priceChangePercentage,
      marketCap: marketCap ?? this.marketCap,
      volume: volume ?? this.volume,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      maxSupply: maxSupply ?? this.maxSupply,
      ath: ath ?? this.ath,
      athChangePercentage: athChangePercentage ?? this.athChangePercentage,
      athDate: athDate ?? this.athDate,
      atl: atl ?? this.atl,
      atlChangePercentage: atlChangePercentage ?? this.atlChangePercentage,
      atlDate: atlDate ?? this.atlDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Simular actualización de precio
  CryptoEntity updatePrice() {
    final random = Random();
    final variation =
        (random.nextDouble() * 0.02) - 0.01; // Variación entre -1% y +1%
    final newPrice = currentPrice * (1 + variation);

    return copyWith(currentPrice: newPrice, lastUpdated: DateTime.now());
  }

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
