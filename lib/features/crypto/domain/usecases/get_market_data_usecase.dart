import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';

/// @file        get_market_data_usecase.dart
/// @brief       Get market data use case for NemorixPay Crypto feature.
/// @details     This use case handles retrieving all market data info for a specific crypto.
/// @author      Miguel Fagundez
/// @date        2025-06-06
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetMarketDataUseCase {
  final CryptoMarketRepository repository;

  GetMarketDataUseCase({required this.repository});

  /// Gets market data
  /// @return Either<Failure, MarketDataEntity> market data or error
  Future<Either<Failure, MarketDataEntity>> call(String symbol) async {
    debugPrint('GetMarketDataUseCase: Getting available market data');
    return await repository.getMarketData(symbol);
  }
}
