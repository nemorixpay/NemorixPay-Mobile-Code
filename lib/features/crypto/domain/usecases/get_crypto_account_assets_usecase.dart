import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';

/// @file        get_crypto_account_assets_usecase.dart
/// @brief       Get crypto list use case for NemorixPay Crypto feature.
/// @details     This use case handles retrieving all available cryptos.
/// @author      Miguel Fagundez
/// @date        2025-06-08
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetCryptoAccountAssetsUseCase {
  final CryptoMarketRepository repository;

  GetCryptoAccountAssetsUseCase({required this.repository});

  /// Gets all account cryptos
  /// @return Either<Failure, List<CryptoAssetWithMarketData>> List of the account cryptos or error
  Future<Either<Failure, List<CryptoAssetWithMarketData>>> call() async {
    debugPrint('GetCryptoAccountAssetsUseCase: Getting account cryptos');
    return await repository.getCryptoAccountAssets();
  }
}
