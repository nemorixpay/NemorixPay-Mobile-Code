import '../entities/crypto_entity.dart';
import '../entities/crypto_price_point.dart';

/// @file        crypto_repository.dart
/// @brief       Repository interface for cryptocurrency operations.
/// @details     Defines the contract for cryptocurrency data operations.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class CryptoRepository {
  /// Get current price for a cryptocurrency
  Future<CryptoEntity> getCurrentPrice(String symbol);

  /// Update price for a cryptocurrency
  Future<CryptoEntity> updatePrice(String symbol);

  /// Get price history for a cryptocurrency
  Future<List<CryptoPricePoint>> getPriceHistory(
    String symbol, {
    required DateTime start,
    required DateTime end,
  });
}
