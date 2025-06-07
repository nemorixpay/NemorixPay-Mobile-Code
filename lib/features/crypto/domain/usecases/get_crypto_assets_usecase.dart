import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';

/// @file        get_crypto_assets_usecase.dart
/// @brief       Get crypto list use case for NemorixPay Crypto feature.
/// @details     This use case handles retrieving all available cryptos.
/// @author      Miguel Fagundez
/// @date        2025-06-06
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetCryptoAssetsUseCase {
  final CryptoMarketRepository repository;

  GetCryptoAssetsUseCase({required this.repository});

  /// Gets all available cryptos
  /// @return Either<Failure, List<CryptoAssetWithMarketData>> List of available cryptos or error
  Future<Either<Failure, List<CryptoAssetWithMarketData>>> call() async {
    debugPrint('GetCryptoAssetsUseCase: Getting available cryptos');
    return await repository.getCryptoAssets();
  }
}
