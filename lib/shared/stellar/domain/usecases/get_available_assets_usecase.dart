import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/stellar_repository.dart';

/// @file        get_available_assets_usecase.dart
/// @brief       Get available assets use case for NemorixPay Stellar feature.
/// @details     This use case handles retrieving all available assets in the
///              Stellar network.
/// @author      Miguel Fagundez
/// @date        2025-05-21
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetAvailableAssetsUseCase {
  final StellarRepository repository;

  GetAvailableAssetsUseCase({required this.repository});

  /// Gets all available assets in the Stellar network
  /// @return Either<Failure, List<AssetEntity>> List of available assets or error
  Future<Either<Failure, List<AssetEntity>>> call() async {
    debugPrint('GetAvailableAssetsUseCase: Getting available assets');
    return await repository.getAvailableAssets();
  }
}
