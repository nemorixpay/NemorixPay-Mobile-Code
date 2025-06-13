import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';

/// @file        crypto_market_repository.dart
/// @brief       Repository contract for crypto market data operations.
/// @details     Handles the data contract operations for crypto market data, including
///              fetching current prices, historical data, and asset details.
/// @author      Miguel Fagundez
/// @date        2025-06-06
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class CryptoMarketRepository {
  /// Gets the list of available crypto assets with their market data
  ///
  /// Returns [List<CryptoAssetWithMarketData>] with all available assets
  /// Throws [AssetFailure] if the operation fails
  Future<Either<Failure, List<CryptoAssetWithMarketData>>> getCryptoAssets();

  /// Gets the list of the account crypto assets with their market data
  ///
  /// Returns [List<CryptoAssetWithMarketData>] with all account assets
  /// Throws [AssetFailure] if the operation fails
  Future<Either<Failure, List<CryptoAssetWithMarketData>>>
  getCryptoAccountAssets();

  /// Gets the market data for a specific crypto asset
  ///
  /// Returns [MarketDataEntity] with the current market data
  /// Throws [AssetFailure] if the operation fails
  Future<Either<Failure, MarketDataEntity>> getMarketData(String symbol);

  /// Gets the complete details of a crypto asset including its market data
  ///
  /// Returns [CryptoAssetWithMarketData] with the complete asset details
  /// Throws [AssetFailure] if the operation fails
  Future<Either<Failure, CryptoAssetWithMarketData>> getCryptoAssetDetails(
    String symbol,
  );

  /// Updates the market data for a specific crypto asset
  ///
  /// Returns [MarketDataEntity] with the updated market data
  /// Throws [AssetFailure] if the operation fails
  Future<Either<Failure, MarketDataEntity>> updateMarketData(String symbol);
}
