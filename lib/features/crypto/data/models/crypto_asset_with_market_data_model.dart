import 'package:equatable/equatable.dart';
import '../../domain/entities/crypto_asset_with_market_data.dart';
import '../../../../shared/common/data/models/asset_model.dart';
import 'market_data_model.dart';

/// @file        crypto_asset_with_market_data_model.dart
/// @brief       Model class combining a generic asset with its market data for the crypto feature.
/// @details     Used to represent a crypto asset and its dynamic market data in the data layer.
/// @author      Miguel Fagundez
/// @date        2025-06-04
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoAssetWithMarketDataModel extends Equatable {
  final AssetModel asset;
  final MarketDataModel marketData;
  final bool isFavorite;

  const CryptoAssetWithMarketDataModel({
    required this.asset,
    required this.marketData,
    this.isFavorite = false,
  });

  /// Creates a copy of this model with the given fields replaced with the new values
  CryptoAssetWithMarketDataModel copyWith({
    AssetModel? asset,
    MarketDataModel? marketData,
    bool? isFavorite,
  }) {
    return CryptoAssetWithMarketDataModel(
      asset: asset ?? this.asset,
      marketData: marketData ?? this.marketData,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory CryptoAssetWithMarketDataModel.fromJson(Map<String, dynamic> json) {
    return CryptoAssetWithMarketDataModel(
      asset: AssetModel.fromJson(json['asset'] as Map<String, dynamic>),
      marketData: MarketDataModel.fromJson(
        json['market_data'] as Map<String, dynamic>,
      ),
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset': asset.toJson(),
      'market_data': marketData.toJson(),
      'is_favorite': isFavorite,
    };
  }

  CryptoAssetWithMarketData toEntity() {
    return CryptoAssetWithMarketData(
      asset: asset.toEntity(),
      marketData: marketData.toEntity(),
      isFavorite: isFavorite,
    );
  }

  @override
  List<Object?> get props => [asset, marketData, isFavorite];
}
