import 'package:equatable/equatable.dart';
import 'package:nemorixpay/features/crypto/data/models/crypto_asset_with_market_data_model.dart';
import '../../../../shared/common/domain/entities/asset_entity.dart';

import 'market_data_entity.dart';

/// @file        crypto_asset_with_market_data.dart
/// @brief       Entity class combining a generic asset with its market data for the crypto feature.
/// @details     Used to represent a crypto asset and its dynamic market data in the domain layer.
/// @author      Miguel Fagundez
/// @date        2025-06-05
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoAssetWithMarketData extends Equatable {
  final AssetEntity asset;
  final MarketDataEntity marketData;
  bool isFavorite;

  CryptoAssetWithMarketData({
    required this.asset,
    required this.marketData,
    this.isFavorite = false,
  });

  CryptoAssetWithMarketData copyWith({
    AssetEntity? asset,
    MarketDataEntity? marketData,
    bool? isFavorite,
  }) {
    return CryptoAssetWithMarketData(
      asset: asset ?? this.asset,
      marketData: marketData ?? this.marketData,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [asset, marketData, isFavorite];

  /// Converts the entity to its corresponding model
  ///
  /// This method is used to convert the domain entity to a data model
  /// for persistence or API communication.
  CryptoAssetWithMarketDataModel toModel() {
    return CryptoAssetWithMarketDataModel(
      asset: asset.toModel(),
      marketData: marketData.toModel(),
      isFavorite: isFavorite,
    );
  }
}
