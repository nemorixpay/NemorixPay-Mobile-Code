import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import '../entities/asset_entity.dart';
import '../repositories/asset_repository.dart';

/// @file        get_assets_list_usecase.dart
/// @brief       Get assets list use case for NemorixPay Asset feature.
/// @details     This use case handles retrieving all available assets.
/// @author      Miguel Fagundez
/// @date        2025-05-27
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetAssetsListUseCase {
  final AssetRepository repository;

  GetAssetsListUseCase({required this.repository});

  /// Gets all available assets
  /// @return Either<Failure, List<AssetEntity>> List of available assets or error
  Future<Either<Failure, List<AssetEntity>>> call() async {
    debugPrint('GetAssetsListUseCase: Getting available assets');
    return await repository.getAssetsList();
  }
}
