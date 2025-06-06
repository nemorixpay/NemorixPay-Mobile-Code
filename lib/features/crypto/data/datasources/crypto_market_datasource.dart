import 'package:nemorixpay/features/crypto/data/models/crypto_asset_with_market_data_model.dart';
import 'package:nemorixpay/features/crypto/data/models/market_data_model.dart';

/// @file        crypto_market_datasource.dart
/// @brief       Data source contract for crypto market data operations.
/// @details     Handles the data operations for crypto market data, including
///              fetching current prices, historical data, and asset details.
/// @author      Miguel Fagundez
/// @date        2025-06-05
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class CryptoMarketDataSource {
  /// Gets the list of available crypto assets with their market data
  ///
  /// Returns [List<CryptoAssetWithMarketDataModel>] with all available assets
  /// Throws [AssetFailure] if the operation fails
  Future<List<CryptoAssetWithMarketDataModel>> getCryptoAssets();

  /// Gets the market data for a specific crypto asset
  ///
  /// Returns [MarketDataModel] with the current market data
  /// Throws [AssetFailure] if the operation fails
  Future<MarketDataModel> getMarketData(String symbol);

  /// Gets the complete details of a crypto asset including its market data
  ///
  /// Returns [CryptoAssetWithMarketDataModel] with the complete asset details
  /// Throws [AssetFailure] if the operation fails
  Future<CryptoAssetWithMarketDataModel> getCryptoAssetDetails(String symbol);

  /// Updates the market data for a specific crypto asset
  ///
  /// Returns [MarketDataModel] with the updated market data
  /// Throws [AssetFailure] if the operation fails
  Future<MarketDataModel> updateMarketData(String symbol);
}
