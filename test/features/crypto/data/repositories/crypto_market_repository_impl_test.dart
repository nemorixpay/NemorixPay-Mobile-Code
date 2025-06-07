import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/data/datasources/crypto_market_datasource.dart';
import 'package:nemorixpay/features/crypto/data/models/crypto_asset_with_market_data_model.dart';
import 'package:nemorixpay/features/crypto/data/models/market_data_model.dart';
import 'package:nemorixpay/features/crypto/data/repositories/crypto_market_repository_impl.dart';
import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'crypto_market_repository_impl_test.mocks.dart';

@GenerateMocks([CryptoMarketDataSource])
void main() {
  late CryptoMarketRepositoryImpl repository;
  late MockCryptoMarketDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCryptoMarketDataSource();
    repository = CryptoMarketRepositoryImpl(mockDataSource);
  });

  group('getCryptoAssets', () {
    final tAssets = [
      CryptoAssetWithMarketDataModel(
        asset: AssetModel(
          id: '1',
          assetCode: 'BTC',
          assetType: 'crypto',
          name: 'Bitcoin',
          network: 'stellar',
          decimals: 7,
        ),
        marketData: MarketDataModel(
          currentPrice: 50000.0,
          priceChange: 1000.0,
          priceChangePercentage: 2.0,
          marketCap: 1000000000.0,
          volume: 50000000.0,
          high24h: 51000.0,
          low24h: 49000.0,
          circulatingSupply: 19000000.0,
          totalSupply: 21000000.0,
          maxSupply: 21000000.0,
          ath: 69000.0,
          athChangePercentage: -27.54,
          athDate: DateTime.now(),
          atl: 3000.0,
          atlChangePercentage: 1566.67,
          atlDate: DateTime.now(),
          lastUpdated: DateTime.now(),
        ),
        isFavorite: false,
      ),
    ];

    test(
      'should return list of crypto assets when data source call is successful',
      () async {
        // arrange
        when(mockDataSource.getCryptoAssets()).thenAnswer((_) async => tAssets);

        // act
        final result = await repository.getCryptoAssets();

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('should not return failure'), (r) {
          expect(r.length, 1);
          expect(r[0].asset.assetCode, 'BTC');
          expect(r[0].marketData.currentPrice, 50000.0);
        });
        verify(mockDataSource.getCryptoAssets());
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return AssetFailure when data source call is unsuccessful',
      () async {
        // arrange
        when(
          mockDataSource.getCryptoAssets(),
        ).thenThrow(AssetFailure.assetsListFailed('Error'));

        // act
        final result = await repository.getCryptoAssets();

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<AssetFailure>()),
          (r) => fail('should not return success'),
        );
        verify(mockDataSource.getCryptoAssets());
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('getMarketData', () {
    const tSymbol = 'BTC';
    final tMarketData = MarketDataModel(
      currentPrice: 50000.0,
      priceChange: 1000.0,
      priceChangePercentage: 2.0,
      marketCap: 1000000000.0,
      volume: 50000000.0,
      high24h: 51000.0,
      low24h: 49000.0,
      circulatingSupply: 19000000.0,
      totalSupply: 21000000.0,
      maxSupply: 21000000.0,
      ath: 69000.0,
      athChangePercentage: -27.54,
      athDate: DateTime.now(),
      atl: 3000.0,
      atlChangePercentage: 1566.67,
      atlDate: DateTime.now(),
      lastUpdated: DateTime.now(),
    );

    test(
      'should return market data when data source call is successful',
      () async {
        // arrange
        when(
          mockDataSource.getMarketData(tSymbol),
        ).thenAnswer((_) async => tMarketData);

        // act
        final result = await repository.getMarketData(tSymbol);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('should not return failure'), (r) {
          expect(r.currentPrice, 50000.0);
          expect(r.priceChange, 1000.0);
        });
        verify(mockDataSource.getMarketData(tSymbol));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return AssetFailure when data source call is unsuccessful',
      () async {
        // arrange
        when(
          mockDataSource.getMarketData(tSymbol),
        ).thenThrow(AssetFailure.marketDataNotFound('Error'));

        // act
        final result = await repository.getMarketData(tSymbol);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<AssetFailure>()),
          (r) => fail('should not return success'),
        );
        verify(mockDataSource.getMarketData(tSymbol));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('getCryptoAssetDetails', () {
    const tSymbol = 'BTC';
    final tAsset = CryptoAssetWithMarketDataModel(
      asset: AssetModel(
        id: '1',
        assetCode: 'BTC',
        assetType: 'crypto',
        name: 'Bitcoin',
        network: 'stellar',
        decimals: 7,
      ),
      marketData: MarketDataModel(
        currentPrice: 50000.0,
        priceChange: 1000.0,
        priceChangePercentage: 2.0,
        marketCap: 1000000000.0,
        volume: 50000000.0,
        high24h: 51000.0,
        low24h: 49000.0,
        circulatingSupply: 19000000.0,
        totalSupply: 21000000.0,
        maxSupply: 21000000.0,
        ath: 69000.0,
        athChangePercentage: -27.54,
        athDate: DateTime.now(),
        atl: 3000.0,
        atlChangePercentage: 1566.67,
        atlDate: DateTime.now(),
        lastUpdated: DateTime.now(),
      ),
      isFavorite: false,
    );

    test(
      'should return crypto asset details when data source call is successful',
      () async {
        // arrange
        when(
          mockDataSource.getCryptoAssetDetails(tSymbol),
        ).thenAnswer((_) async => tAsset);

        // act
        final result = await repository.getCryptoAssetDetails(tSymbol);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('should not return failure'), (r) {
          expect(r.asset.assetCode, 'BTC');
          expect(r.marketData.currentPrice, 50000.0);
        });
        verify(mockDataSource.getCryptoAssetDetails(tSymbol));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return AssetFailure when data source call is unsuccessful',
      () async {
        // arrange
        when(
          mockDataSource.getCryptoAssetDetails(tSymbol),
        ).thenThrow(AssetFailure.assetDetailsNotFound('Error'));

        // act
        final result = await repository.getCryptoAssetDetails(tSymbol);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<AssetFailure>()),
          (r) => fail('should not return success'),
        );
        verify(mockDataSource.getCryptoAssetDetails(tSymbol));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('updateMarketData', () {
    const tSymbol = 'BTC';
    final tMarketData = MarketDataModel(
      currentPrice: 50000.0,
      priceChange: 1000.0,
      priceChangePercentage: 2.0,
      marketCap: 1000000000.0,
      volume: 50000000.0,
      high24h: 51000.0,
      low24h: 49000.0,
      circulatingSupply: 19000000.0,
      totalSupply: 21000000.0,
      maxSupply: 21000000.0,
      ath: 69000.0,
      athChangePercentage: -27.54,
      athDate: DateTime.now(),
      atl: 3000.0,
      atlChangePercentage: 1566.67,
      atlDate: DateTime.now(),
      lastUpdated: DateTime.now(),
    );

    test(
      'should return updated market data when data source call is successful',
      () async {
        // arrange
        when(
          mockDataSource.updateMarketData(tSymbol),
        ).thenAnswer((_) async => tMarketData);

        // act
        final result = await repository.updateMarketData(tSymbol);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('should not return failure'), (r) {
          expect(r.currentPrice, 50000.0);
          expect(r.priceChange, 1000.0);
        });
        verify(mockDataSource.updateMarketData(tSymbol));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return AssetFailure when data source call is unsuccessful',
      () async {
        // arrange
        when(
          mockDataSource.updateMarketData(tSymbol),
        ).thenThrow(AssetFailure.marketDataUpdateFailed('Error'));

        // act
        final result = await repository.updateMarketData(tSymbol);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isA<AssetFailure>()),
          (r) => fail('should not return success'),
        );
        verify(mockDataSource.updateMarketData(tSymbol));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}
