/// @file        crypto_entity.dart
/// @brief       Crypto structure.
/// @details     This file contains a base structure for building crypto data for UI development and testing purposes.
/// @author      Miguel Fagundez
/// @date        2025-04-10
/// @version     1.0
/// @copyright   Apache 2.0 License
class Crypto {
  final String name;
  final String abbreviation;
  final String project;
  final String logoPath;
  final double currentPrice;
  final Map<String, List<double>> priceHistory;

  Crypto({
    required this.name,
    required this.abbreviation,
    required this.project,
    required this.logoPath,
    required this.currentPrice,
    required this.priceHistory,
  });
}
