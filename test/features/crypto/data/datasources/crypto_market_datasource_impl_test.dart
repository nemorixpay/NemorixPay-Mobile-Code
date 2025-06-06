import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/data/datasources/crypto_market_datasource_impl.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';
import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'package:nemorixpay/features/crypto/data/models/market_data_model.dart';
import 'crypto_market_datasource_impl_test.mocks.dart';

@GenerateMocks([AssetCacheManager])
void main() {
  late CryptoMarketDataSourceImpl dataSource;
  late MockAssetCacheManager mockAssetCacheManager;

  setUp(() {
    mockAssetCacheManager = MockAssetCacheManager();
    dataSource = CryptoMarketDataSourceImpl(
      useMockData: true,
      assetCacheManager: mockAssetCacheManager,
    );
  });

  group('getCryptoAssets', () {
    test('should return list of crypto assets with market data', () async {
      // Arrange
      final mockAssets = [
        AssetModel(
          id: 'xlm-1',
          assetCode: 'XLM',
          name: 'Stellar Lumens',
          assetType: 'native',
          network: 'stellar',
          decimals: 7,
          assetIssuer: null,
        ),
        AssetModel(
          id: 'usdc-1',
          assetCode: 'USDC',
          name: 'USD Coin',
          assetType: 'credit_alphanum4',
          network: 'stellar',
          decimals: 7,
          assetIssuer:
              'GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN',
        ),
      ];

      when(
        mockAssetCacheManager.getAllAssets(),
      ).thenAnswer((_) async => mockAssets);

      // Act
      final result = await dataSource.getCryptoAssets();

      // Assert
      expect(result, isNotEmpty);
      expect(result.length, equals(2));
      expect(result[0].asset.assetCode, equals('XLM'));
      expect(result[1].asset.assetCode, equals('USDC'));
      expect(result[0].marketData, isA<MarketDataModel>());
      expect(result[1].marketData, isA<MarketDataModel>());
    });

    test('should throw AssetFailure when getting assets fails', () async {
      // Arrange
      when(
        mockAssetCacheManager.getAllAssets(),
      ).thenThrow(Exception('Failed to get assets'));

      // Act & Assert
      expect(() => dataSource.getCryptoAssets(), throwsA(isA<AssetFailure>()));
    });
  });

  group('getCryptoAssetDetails', () {
    test('should return crypto asset details with market data', () async {
      // Arrange
      final mockAsset = AssetModel(
        id: 'xlm-1',
        assetCode: 'XLM',
        name: 'Stellar Lumens',
        assetType: 'native',
        network: 'stellar',
        decimals: 7,
        assetIssuer: null,
      );

      when(
        mockAssetCacheManager.getAssetByCode('XLM'),
      ).thenAnswer((_) async => mockAsset);

      // Act
      final result = await dataSource.getCryptoAssetDetails('XLM');

      // Assert
      expect(result.asset.assetCode, equals('XLM'));
      expect(result.marketData, isA<MarketDataModel>());
      expect(result.isFavorite, isFalse);
    });

    test(
      'should throw AssetFailure when getting asset details fails',
      () async {
        // Arrange
        when(
          mockAssetCacheManager.getAssetByCode('XLM'),
        ).thenThrow(Exception('Failed to get asset details'));

        // Act & Assert
        expect(
          () => dataSource.getCryptoAssetDetails('XLM'),
          throwsA(isA<AssetFailure>()),
        );
      },
    );
  });

  group('getMarketData', () {
    test('should return market data for a symbol', () async {
      // Act
      final result = await dataSource.getMarketData('XLM');

      // Assert
      expect(result, isA<MarketDataModel>());
      expect(result.currentPrice, isPositive);
      expect(result.priceChange, isNotNull);
      expect(result.priceChangePercentage, isNotNull);
    });

    test('should throw AssetFailure when getting market data fails', () async {
      // Arrange
      dataSource = CryptoMarketDataSourceImpl(
        useMockData: false,
        assetCacheManager: mockAssetCacheManager,
        apiBaseUrl: 'invalid-url',
      );

      // Act & Assert
      expect(
        () => dataSource.getMarketData('XLM'),
        throwsA(isA<AssetFailure>()),
      );
    });
  });

  group('updateMarketData', () {
    test('should update and return new market data', () async {
      // Act
      final result = await dataSource.updateMarketData('XLM');

      // Assert
      expect(result, isA<MarketDataModel>());
      expect(result.lastUpdated, isNotNull);
    });

    test('should throw AssetFailure when updating market data fails', () async {
      // Arrange
      dataSource = CryptoMarketDataSourceImpl(
        useMockData: false,
        assetCacheManager: mockAssetCacheManager,
        apiBaseUrl: 'invalid-url',
      );

      // Act & Assert
      expect(
        () => dataSource.updateMarketData('XLM'),
        throwsA(isA<AssetFailure>()),
      );
    });
  });
}
