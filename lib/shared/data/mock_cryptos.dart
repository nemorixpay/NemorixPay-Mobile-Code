import 'package:nemorixpay/features/cryptocurrency/domain/entity/crypto_entity.dart';

/// @file        mock_cryptos.dart
/// @brief       Mock data for cryptocurrencies.
/// @details     This file contains a list of mocked cryptocurrency data for UI development and testing purposes.
/// @author      Miguel Fagundez
/// @date        2025-04-10
/// @version     1.0
/// @copyright   Apache 2.0 License
final List<Crypto> mockCryptos = [
  Crypto(
    name: 'Bitcoin',
    abbreviation: 'BTC',
    project: 'Bitcoin Network',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 68790.25,
    priceHistory: {
      '1D': [67000, 67200, 67500, 68000, 68500, 68790],
      '1W': [64000, 65000, 66000, 67000, 68000, 68790],
      '1M': [62000, 63000, 64000, 66000, 67000, 68790],
      '1Y': [30000, 40000, 50000, 60000, 65000, 68790],
    },
  ),
  Crypto(
    name: 'Ethereum',
    abbreviation: 'ETH',
    project: 'Ethereum Network',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 3420.15,
    priceHistory: {
      '1D': [3300, 3350, 3380, 3400, 3410, 3420],
      '1W': [3100, 3150, 3200, 3300, 3400, 3420],
      '1M': [2800, 2900, 3000, 3200, 3400, 3420],
      '1Y': [1000, 1500, 2000, 2500, 3000, 3420],
    },
  ),
  Crypto(
    name: 'Tether',
    abbreviation: 'USDT',
    project: 'Tether',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 1.00,
    priceHistory: {
      '1D': [1, 1, 1, 1, 1, 1],
      '1W': [1, 1, 1, 1, 1, 1],
      '1M': [1, 1, 1, 1, 1, 1],
      '1Y': [1, 1, 1, 1, 1, 1],
    },
  ),
  Crypto(
    name: 'Cardano',
    abbreviation: 'ADA',
    project: 'Cardano Network',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.58,
    priceHistory: {
      '1D': [0.55, 0.56, 0.57, 0.58],
      '1W': [0.50, 0.52, 0.54, 0.56, 0.58],
      '1M': [0.40, 0.45, 0.50, 0.55, 0.58],
      '1Y': [0.25, 0.30, 0.40, 0.50, 0.58],
    },
  ),
  Crypto(
    name: 'Ripple',
    abbreviation: 'XRP',
    project: 'RippleNet',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.62,
    priceHistory: {
      '1D': [0.60, 0.61, 0.62],
      '1W': [0.58, 0.60, 0.62],
      '1M': [0.50, 0.55, 0.60, 0.62],
      '1Y': [0.30, 0.40, 0.50, 0.60, 0.62],
    },
  ),
  Crypto(
    name: 'Stellar Lumens',
    abbreviation: 'XLM',
    project: 'Stellar Network',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.135,
    priceHistory: {
      '1D': [0.12, 0.125, 0.13, 0.135],
      '1W': [0.11, 0.12, 0.13, 0.135],
      '1M': [0.10, 0.11, 0.12, 0.135],
      '1Y': [0.07, 0.09, 0.11, 0.13, 0.135],
    },
  ),
  Crypto(
    name: 'USD Coin',
    abbreviation: 'USDC',
    project: 'Centre Consortium',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 1.00,
    priceHistory: {
      '1D': [1, 1, 1, 1, 1, 1],
      '1W': [1, 1, 1, 1, 1, 1],
      '1M': [1, 1, 1, 1, 1, 1],
      '1Y': [1, 1, 1, 1, 1, 1],
    },
  ),
  Crypto(
    name: 'Velo Protocol',
    abbreviation: 'VELO',
    project: 'Velo',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.015,
    priceHistory: {
      '1D': [0.014, 0.0145, 0.015],
      '1W': [0.013, 0.014, 0.015],
      '1M': [0.010, 0.012, 0.014, 0.015],
      '1Y': [0.005, 0.01, 0.012, 0.015],
    },
  ),
  Crypto(
    name: 'Stronghold Token',
    abbreviation: 'SHX',
    project: 'Stronghold',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.003,
    priceHistory: {
      '1D': [0.0028, 0.0029, 0.003],
      '1W': [0.0025, 0.0027, 0.003],
      '1M': [0.002, 0.0025, 0.003],
      '1Y': [0.0015, 0.002, 0.0025, 0.003],
    },
  ),
];
