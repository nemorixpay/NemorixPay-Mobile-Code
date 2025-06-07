import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';

/// @file        update_market_data_usecase.dart
/// @brief       Update market data use case for NemorixPay Crypto feature.
/// @details     This use case handles updating all market data info for a specific crypto.
/// @author      Miguel Fagundez
/// @date        2025-06-06
/// @version     1.0
/// @copyright   Apache 2.0 License

class UpdateMarketDataUseCase {
  final CryptoMarketRepository repository;

  UpdateMarketDataUseCase({required this.repository});

  /// Updates market data
  /// @return Either<Failure, MarketDataEntity> market data or error
  Future<Either<Failure, MarketDataEntity>> call(String symbol) async {
    debugPrint('UpdateMarketDataUseCase: Update/Getting available market data');
    return await repository.updateMarketData(symbol);
  }
}
