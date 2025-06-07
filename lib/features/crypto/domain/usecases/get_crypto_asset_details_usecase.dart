import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';

/// @file        get_crypto_asset_details_usecase.dart
/// @brief       Get specific crypto info use case for NemorixPay Crypto feature.
/// @details     This use case handles retrieving one specific crypto details.
/// @author      Miguel Fagundez
/// @date        2025-06-06
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetCryptoAssetDetailsUseCase {
  final CryptoMarketRepository repository;

  GetCryptoAssetDetailsUseCase({required this.repository});

  /// Gets one crypto info
  /// @return Either<Failure, List<CryptoAssetWithMarketData>> specific crypto or error
  Future<Either<Failure, CryptoAssetWithMarketData>> call(String symbol) async {
    debugPrint('GetCryptoAssetDetailsUseCase: Getting one specific crypto');
    return await repository.getCryptoAssetDetails(symbol);
  }
}
