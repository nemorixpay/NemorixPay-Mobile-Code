import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/asset/data/datasources/asset_datasource.dart';

import '../../domain/entities/asset_entity.dart';
import '../../domain/entities/asset_price_point.dart';
import '../../domain/repositories/asset_repository.dart';

/// @file        asset_repository_impl.dart
/// @brief       Implementation of the Asset repository.
/// @details     Provides concrete implementation of asset data operations.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class AssetRepositoryImpl implements AssetRepository {
  final AssetDataSource dataSource;

  AssetRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, AssetEntity>> getCurrentPrice(String symbol) async {
    try {
      final asset = await dataSource.getCurrentPrice(symbol);
      return Right(asset.toEntity());
    } catch (e) {
      return Left(AssetFailure.priceUpdateFailed(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AssetEntity>> updatePrice(String symbol) async {
    try {
      final asset = await dataSource.updatePrice(symbol);
      return Right(asset.toEntity());
    } catch (e) {
      return Left(AssetFailure.priceUpdateFailed(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AssetPricePoint>>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final listOfAssetPointsModel = await dataSource.getPriceHistory(
        symbol,
        start: start,
        end: end,
      );
      final List<AssetPricePoint> listOfAssetPoints =
          listOfAssetPointsModel.map((model) => model.toEntity()).toList();

      return Right(listOfAssetPoints);
    } catch (e) {
      return Left(AssetFailure.priceHistoryNotFound(e.toString()));
    }
  }
}
