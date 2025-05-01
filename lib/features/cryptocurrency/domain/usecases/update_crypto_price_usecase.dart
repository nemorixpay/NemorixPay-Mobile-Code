import 'package:equatable/equatable.dart';
import '../entities/crypto_entity.dart';
import '../repositories/crypto_repository.dart';

/// @file        update_crypto_price_usecase.dart
/// @brief       Use case for updating cryptocurrency prices.
/// @details     Handles the business logic for updating cryptocurrency prices.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class UpdateCryptoPriceUseCase {
  final CryptoRepository repository;

  UpdateCryptoPriceUseCase(this.repository);

  /// Updates the price for a given cryptocurrency symbol
  Future<CryptoEntity> call(String symbol) async {
    return await repository.updatePrice(symbol);
  }
}
