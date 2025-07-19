import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Stellar Assets Filtering Test', () {
    late StellarDataSourceImpl datasource;

    setUp(() {
      datasource = StellarDataSourceImpl();
    });

    test('should identify test assets correctly', () {
      // Test assets that should be identified as test assets
      expect(datasource.isTestAsset('00A'), true);
      expect(datasource.isTestAsset('013'), true);
      expect(datasource.isTestAsset('017'), true);
      expect(datasource.isTestAsset('01C'), true);
      expect(datasource.isTestAsset('026'), true);
      expect(datasource.isTestAsset('029'), true);
      expect(datasource.isTestAsset('123'), true);
      expect(datasource.isTestAsset('456'), true);

      // Real assets that should NOT be identified as test assets
      expect(datasource.isTestAsset('USDC'), false);
      expect(datasource.isTestAsset('USDT'), false);
      expect(datasource.isTestAsset('BTC'), false);
      expect(datasource.isTestAsset('ETH'), false);
      expect(datasource.isTestAsset('XLM'), false);
      expect(datasource.isTestAsset('EURC'), false);
      expect(datasource.isTestAsset('JPYC'), false);
      expect(datasource.isTestAsset('SGD'), false);
      expect(datasource.isTestAsset('BRL'), false);
      expect(datasource.isTestAsset('ARS'), false);
      expect(datasource.isTestAsset('MXN'), false);
      expect(datasource.isTestAsset('GBPT'), false);
      expect(datasource.isTestAsset('CADC'), false);
      expect(datasource.isTestAsset('CHFT'), false);
      expect(datasource.isTestAsset('AUROC'), false);
      expect(datasource.isTestAsset('NGNT'), false);
      expect(datasource.isTestAsset('NGNC'), false);
      expect(datasource.isTestAsset('RMT'), false);
      expect(datasource.isTestAsset('SLT'), false);
      expect(datasource.isTestAsset('MOBI'), false);
    });

    test('should get correct asset names', () {
      expect(datasource.getAssetName('XLM'), 'Stellar Lumens');
      expect(datasource.getAssetName('USDC'), 'USD Coin');
      expect(datasource.getAssetName('USDT'), 'Tether');
      expect(datasource.getAssetName('BTC'), 'Bitcoin');
      expect(datasource.getAssetName('ETH'), 'Ethereum');
      expect(datasource.getAssetName('EURC'), 'Euro Coin');
      expect(datasource.getAssetName('JPYC'), 'Japanese Yen Coin');
      expect(datasource.getAssetName('SGD'), 'Singapore Dollar');
      expect(datasource.getAssetName('BRL'), 'Brazilian Real');
      expect(datasource.getAssetName('ARS'), 'Argentine Peso');
      expect(datasource.getAssetName('MXN'), 'Mexican Peso');
      expect(datasource.getAssetName('GBPT'), 'British Pound Token');
      expect(datasource.getAssetName('CADC'), 'Canadian Dollar Coin');
      expect(datasource.getAssetName('CHFT'), 'Swiss Franc Token');
      expect(datasource.getAssetName('AUROC'), 'Australian Dollar Coin');
      expect(datasource.getAssetName('NGNT'), 'Nigerian Naira Token');
      expect(datasource.getAssetName('NGNC'), 'Nigerian Naira Coin');
      expect(datasource.getAssetName('RMT'), 'RMT Token');
      expect(datasource.getAssetName('SLT'), 'Smartlands Token');
      expect(datasource.getAssetName('MOBI'), 'Mobius Token');

      // Unknown assets should return the code as name
      expect(datasource.getAssetName('UNKNOWN'), 'UNKNOWN');
      expect(datasource.getAssetName('00A'), '00A');
    });

    test('should verify assets correctly', () {
      // Known assets should be verified
      expect(datasource.isAssetVerified('XLM', ''), true);
      expect(datasource.isAssetVerified('USDC', 'any_issuer'), true);
      expect(datasource.isAssetVerified('USDT', 'any_issuer'), true);
      expect(datasource.isAssetVerified('BTC', 'any_issuer'), true);
      expect(datasource.isAssetVerified('ETH', 'any_issuer'), true);
      expect(datasource.isAssetVerified('EURC', 'any_issuer'), true);
      expect(datasource.isAssetVerified('JPYC', 'any_issuer'), true);
      expect(datasource.isAssetVerified('SGD', 'any_issuer'), true);
      expect(datasource.isAssetVerified('BRL', 'any_issuer'), true);
      expect(datasource.isAssetVerified('ARS', 'any_issuer'), true);
      expect(datasource.isAssetVerified('MXN', 'any_issuer'), true);
      expect(datasource.isAssetVerified('GBPT', 'any_issuer'), true);
      expect(datasource.isAssetVerified('CADC', 'any_issuer'), true);
      expect(datasource.isAssetVerified('CHFT', 'any_issuer'), true);
      expect(datasource.isAssetVerified('AUROC', 'any_issuer'), true);
      expect(datasource.isAssetVerified('NGNT', 'any_issuer'), true);
      expect(datasource.isAssetVerified('NGNC', 'any_issuer'), true);
      expect(datasource.isAssetVerified('RMT', 'any_issuer'), true);
      expect(datasource.isAssetVerified('SLT', 'any_issuer'), true);
      expect(datasource.isAssetVerified('MOBI', 'any_issuer'), true);

      // Unknown assets should not be verified
      expect(datasource.isAssetVerified('UNKNOWN', 'any_issuer'), false);
      expect(datasource.isAssetVerified('00A', 'any_issuer'), false);
      expect(datasource.isAssetVerified('013', 'any_issuer'), false);
    });

    test('should handle testnet vs mainnet logic correctly', () {
      // Test that the datasource is configured for testnet
      expect(datasource.isAppInProduction, false);

      // Test that test assets are correctly identified
      expect(datasource.isTestAsset('00A'), true);
      expect(datasource.isTestAsset('013'), true);
      expect(datasource.isTestAsset('017'), true);

      // Test that real assets are not identified as test assets
      expect(datasource.isTestAsset('USDC'), false);
      expect(datasource.isTestAsset('XLM'), false);
    });
  });
}
