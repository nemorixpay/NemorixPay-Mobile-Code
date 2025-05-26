import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_price_point.dart';
import 'package:nemorixpay/features/asset/domain/repositories/asset_repository.dart';

/// @file        get_price_history_usecase.dart
/// @brief       Use case for retrieving asset price history.
/// @details     This use case handles the business logic for retrieving
///             historical price data for a specific asset.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetPriceHistoryUseCase {
  final AssetRepository repository;

  GetPriceHistoryUseCase(this.repository);

  Future<Either<Failure, List<AssetPricePoint>>> call(
    String symbol, {
    required DateTime start,
    required DateTime end,
  }) async {
    return await repository.getPriceHistory(symbol, start: start, end: end);
  }
}
