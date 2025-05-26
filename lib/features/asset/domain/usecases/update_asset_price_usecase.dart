import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import '../entities/asset_entity.dart';
import '../repositories/asset_repository.dart';

/// @file        update_asset_price_usecase.dart
/// @brief       Use case for updating asset prices.
/// @details     Handles the business logic for updating asset prices.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class UpdateAssetPriceUseCase {
  final AssetRepository repository;

  UpdateAssetPriceUseCase(this.repository);

  /// Updates the price for a given asset symbol
  Future<Either<Failure, AssetEntity>> call(String symbol) async {
    return await repository.updatePrice(symbol);
  }
}
