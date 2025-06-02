import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import '../entities/asset_entity.dart';
import '../repositories/crypto_repository.dart';

/// @file        get_crypto_list_usecase.dart
/// @brief       Get crypto list use case for NemorixPay Crypto feature.
/// @details     This use case handles retrieving all available cryptos.
/// @author      Miguel Fagundez
/// @date        2025-05-27
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetCryptoListUseCase {
  final CryptoRepository repository;

  GetCryptoListUseCase({required this.repository});

  /// Gets all available cryptos
  /// @return Either<Failure, List<AssetEntity>> List of available cryptos or error
  Future<Either<Failure, List<AssetEntity>>> call() async {
    debugPrint('GetAssetsListUseCase: Getting available cryptos');
    return await repository.getAssetsList();
  }
}
