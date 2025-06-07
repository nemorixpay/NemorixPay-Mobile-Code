import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_assets_usecase.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';
import 'get_crypto_assets_usecase_test.mocks.dart';

@GenerateMocks([CryptoMarketRepository])
void main() {
  late GetCryptoAssetsUseCase useCase;
  late MockCryptoMarketRepository mockRepository;

  setUp(() {
    mockRepository = MockCryptoMarketRepository();
    useCase = GetCryptoAssetsUseCase(repository: mockRepository);
  });

  test('should get list of crypto assets from repository', () async {
    // arrange
    final tAssets = [
      CryptoAssetWithMarketData(
        asset: AssetEntity(
          id: '1',
          assetCode: 'BTC',
          assetType: 'crypto',
          name: 'Bitcoin',
          network: 'stellar',
          decimals: 7,
        ),
        marketData: MarketDataEntity(
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

    when(
      mockRepository.getCryptoAssets(),
    ).thenAnswer((_) async => Right(tAssets));

    // act
    final result = await useCase();

    // assert
    expect(result.isRight(), true);
    result.fold((l) => fail('should not return failure'), (r) {
      expect(r.length, 1);
      expect(r[0].asset.assetCode, 'BTC');
      expect(r[0].marketData.currentPrice, 50000.0);
    });
    verify(mockRepository.getCryptoAssets());
    verifyNoMoreInteractions(mockRepository);
  });

  test(
    'should return AssetFailure when repository call is unsuccessful',
    () async {
      // arrange
      when(
        mockRepository.getCryptoAssets(),
      ).thenAnswer((_) async => Left(AssetFailure.assetsListFailed('Error')));

      // act
      final result = await useCase();

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<AssetFailure>()),
        (r) => fail('should not return success'),
      );
      verify(mockRepository.getCryptoAssets());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
