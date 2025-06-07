import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';
import 'package:nemorixpay/features/crypto/data/datasources/crypto_market_datasource.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';

/// @file        crypto_market_repository_impl.dart
/// @brief       Implementation of the crypto market data operations.
/// @details     Provides concrete implementation of crypto/market data operations.
/// @author      Miguel Fagundez
/// @date        2025-06-06
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoMarketRepositoryImpl implements CryptoMarketRepository {
  final CryptoMarketDataSource dataSource;

  CryptoMarketRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, CryptoAssetWithMarketData>> getCryptoAssetDetails(
    String symbol,
  ) async {
    try {
      final assetWithMarketData = await dataSource.getCryptoAssetDetails(
        symbol,
      );
      return Right(assetWithMarketData.toEntity());
    } catch (e) {
      debugPrint(
        'CryptoMarketRepositoryImpl - getCryptoAssetDetails: Error: $e',
      );
      if (e is AssetFailure) return Left(e);
      return Left(AssetFailure.assetDetailsNotFound(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CryptoAssetWithMarketData>>>
  getCryptoAssets() async {
    try {
      final listOfCryptos = await dataSource.getCryptoAssets();
      return Right(listOfCryptos.map((crypto) => crypto.toEntity()).toList());
    } catch (e) {
      debugPrint('CryptoMarketRepositoryImpl - getCryptoAssets: Error: $e');
      if (e is AssetFailure) return Left(e);
      return Left(AssetFailure.assetsListFailed(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MarketDataEntity>> getMarketData(String symbol) async {
    try {
      final marketData = await dataSource.getMarketData(symbol);
      return Right(marketData.toEntity());
    } catch (e) {
      debugPrint('CryptoMarketRepositoryImpl - getMarketData: Error: $e');
      if (e is AssetFailure) return Left(e);
      return Left(AssetFailure.marketDataNotFound(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MarketDataEntity>> updateMarketData(
    String symbol,
  ) async {
    try {
      final marketData = await dataSource.updateMarketData(symbol);
      return Right(marketData.toEntity());
    } catch (e) {
      debugPrint('CryptoMarketRepositoryImpl - updateMarketData: Error: $e');
      if (e is AssetFailure) return Left(e);
      return Left(AssetFailure.marketDataUpdateFailed(e.toString()));
    }
  }
}
