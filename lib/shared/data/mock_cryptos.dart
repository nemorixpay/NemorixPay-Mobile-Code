import 'package:nemorixpay/features/cryptocurrency/domain/entity/crypto_entity.dart';

/// @file        mock_cryptos.dart
/// @brief       Mock data list for various cryptocurrencies.
/// @details     This file contains a list of mocked cryptocurrency data for UI development and testing purposes.
/// @author      Miguel Fagundez
/// @date        2025-04-10
/// @version     1.1
/// @copyright   Apache 2.0 License
final List<Crypto> mockCryptos = [
  Crypto(
    name: 'Bitcoin',
    abbreviation: 'BTC',
    project: 'Bitcoin.org',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 65000.0,
    priceHistory: {
      '1D': [60000, 62000, 64000, 65000],
      '1W': [60000, 62000, 64000, 65000],
      '1M': [50000, 55000, 60000, 65000],
      '1Y': [30000, 40000, 50000, 65000],
      'All': [1, 100, 1000, 20000, 65000],
    },
    marketCap: 1200000000000,
    volume: 30000000000,
    circulatingSupply: 19000000,
    totalSupply: 21000000,
    allTimeHigh: 69000.0,
    performance: 120.0,
  ),
  Crypto(
    name: 'Ethereum',
    abbreviation: 'ETH',
    project: 'Ethereum.org',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 3300.0,
    priceHistory: {
      '1D': [3100, 3200, 3250, 3300],
      '1W': [3100, 3200, 3250, 3300],
      '1M': [2500, 2800, 3000, 3300],
      '1Y': [1000, 2000, 2800, 3300],
      'All': [1, 10, 100, 1000, 3300],
    },
    marketCap: 390000000000,
    volume: 15000000000,
    circulatingSupply: 120000000,
    totalSupply: 120000000,
    allTimeHigh: 4800.0,
    performance: 90.0,
  ),
  Crypto(
    name: 'Stellar Lumens',
    abbreviation: 'XLM',
    project: 'Stellar.org',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.13,
    priceHistory: {
      '1D': [0.11, 0.12, 0.125, 0.13],
      '1W': [0.11, 0.12, 0.125, 0.13],
      '1M': [0.09, 0.1, 0.12, 0.13],
      '1Y': [0.08, 0.09, 0.11, 0.13],
      'All': [0.002, 0.01, 0.05, 0.8, 0.13],
    },
    marketCap: 3500000000,
    volume: 50000000,
    circulatingSupply: 27000000000,
    totalSupply: 50000000000,
    allTimeHigh: 0.93,
    performance: 50.0,
  ),
  Crypto(
    name: 'Cardano',
    abbreviation: 'ADA',
    project: 'Cardano.org',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.45,
    priceHistory: {
      '1D': [0.40, 0.42, 0.44, 0.45],
      '1W': [0.40, 0.42, 0.44, 0.45],
      '1M': [0.35, 0.38, 0.42, 0.45],
      '1Y': [0.2, 0.3, 0.4, 0.45],
      'All': [0.02, 0.1, 0.9, 3.1, 0.45],
    },
    marketCap: 16000000000,
    volume: 600000000,
    circulatingSupply: 35000000000,
    totalSupply: 45000000000,
    allTimeHigh: 3.1,
    performance: 65.0,
  ),
  Crypto(
    name: 'Solana',
    abbreviation: 'SOL',
    project: 'Solana.com',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 150.0,
    priceHistory: {
      '1D': [130, 140, 145, 150],
      '1W': [130, 140, 145, 150],
      '1M': [110, 125, 140, 150],
      '1Y': [40, 90, 120, 150],
      'All': [1, 10, 30, 260, 150],
    },
    marketCap: 65000000000,
    volume: 4000000000,
    circulatingSupply: 430000000,
    totalSupply: 550000000,
    allTimeHigh: 260.0,
    performance: 110.0,
  ),
  Crypto(
    name: 'Ripple',
    abbreviation: 'XRP',
    project: 'Ripple.com',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.6,
    priceHistory: {
      '1D': [0.55, 0.57, 0.59, 0.6],
      '1W': [0.55, 0.57, 0.59, 0.6],
      '1M': [0.5, 0.52, 0.58, 0.6],
      '1Y': [0.3, 0.45, 0.55, 0.6],
      'All': [0.002, 0.01, 0.2, 3.4, 0.6],
    },
    marketCap: 32000000000,
    volume: 2000000000,
    circulatingSupply: 54000000000,
    totalSupply: 100000000000,
    allTimeHigh: 3.4,
    performance: 70.0,
  ),
  Crypto(
    name: 'USD Coin',
    abbreviation: 'USDC',
    project: 'centre.io',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 1.0,
    priceHistory: {
      '1D': [1.0, 1.0, 1.0, 1.0],
      '1W': [1.0, 1.0, 1.0, 1.0],
      '1M': [1.0, 1.0, 1.0, 1.0],
      '1Y': [1.0, 1.0, 1.0, 1.0],
      'All': [1.0, 1.0, 1.0, 1.0, 1.0],
    },
    marketCap: 27000000000,
    volume: 3000000000,
    circulatingSupply: 27000000000,
    totalSupply: 27000000000,
    allTimeHigh: 1.0,
    performance: 0.0,
  ),
  Crypto(
    name: 'Tether',
    abbreviation: 'USDT',
    project: 'tether.to',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 1.0,
    priceHistory: {
      '1D': [1.0, 1.0, 1.0, 1.0],
      '1W': [1.0, 1.0, 1.0, 1.0],
      '1M': [1.0, 1.0, 1.0, 1.0],
      '1Y': [1.0, 1.0, 1.0, 1.0],
      'All': [1.0, 1.0, 1.0, 1.0, 1.0],
    },
    marketCap: 86000000000,
    volume: 40000000000,
    circulatingSupply: 86000000000,
    totalSupply: 86000000000,
    allTimeHigh: 1.01,
    performance: 0.0,
  ),
  Crypto(
    name: 'Velo',
    abbreviation: 'VELO',
    project: 'velo.org',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.002,
    priceHistory: {
      '1D': [0.0018, 0.0019, 0.00195, 0.002],
      '1W': [0.0018, 0.0019, 0.00195, 0.002],
      '1M': [0.001, 0.0015, 0.0018, 0.002],
      '1Y': [0.0009, 0.0012, 0.0015, 0.002],
      'All': [0.005, 0.01, 0.02, 2.0, 0.002],
    },
    marketCap: 14000000,
    volume: 1000000,
    circulatingSupply: 7000000000,
    totalSupply: 30000000000,
    allTimeHigh: 2.0,
    performance: -80.0,
  ),
  Crypto(
    name: 'Stronghold Token',
    abbreviation: 'SHX',
    project: 'stronghold.co',
    logoPath: 'assets/logos/btc.png',
    currentPrice: 0.005,
    priceHistory: {
      '1D': [0.0045, 0.0047, 0.0049, 0.005],
      '1W': [0.0045, 0.0047, 0.0049, 0.005],
      '1M': [0.004, 0.0043, 0.0048, 0.005],
      '1Y': [0.003, 0.004, 0.0045, 0.005],
      'All': [0.001, 0.002, 0.005, 0.1, 0.005],
    },
    marketCap: 30000000,
    volume: 200000,
    circulatingSupply: 6000000000,
    totalSupply: 10000000000,
    allTimeHigh: 0.1,
    performance: -60.0,
  ),
];

List<Crypto> favoriteCryptos = [];
final timeFrameOptions = ['1D', '1W', '1M', '1Y', 'All'];
