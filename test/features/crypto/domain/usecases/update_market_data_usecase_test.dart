import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/update_market_data_usecase.dart';
import 'update_market_data_usecase_test.mocks.dart';

@GenerateMocks([CryptoMarketRepository])
void main() {
  late UpdateMarketDataUseCase useCase;
  late MockCryptoMarketRepository mockRepository;

  setUp(() {
    mockRepository = MockCryptoMarketRepository();
    useCase = UpdateMarketDataUseCase(repository: mockRepository);
  });

  const tSymbol = 'BTC';
  final tMarketData = MarketDataEntity(
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

  test('should update market data from repository', () async {
    // arrange
    when(
      mockRepository.updateMarketData(tSymbol),
    ).thenAnswer((_) async => Right(tMarketData));

    // act
    final result = await useCase(tSymbol);

    // assert
    expect(result.isRight(), true);
    result.fold((l) => fail('should not return failure'), (r) {
      expect(r.currentPrice, 50000.0);
      expect(r.priceChange, 1000.0);
    });
    verify(mockRepository.updateMarketData(tSymbol));
    verifyNoMoreInteractions(mockRepository);
  });

  test(
    'should return AssetFailure when repository call is unsuccessful',
    () async {
      // arrange
      when(mockRepository.updateMarketData(tSymbol)).thenAnswer(
        (_) async => Left(AssetFailure.marketDataUpdateFailed('Error')),
      );

      // act
      final result = await useCase(tSymbol);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<AssetFailure>()),
        (r) => fail('should not return success'),
      );
      verify(mockRepository.updateMarketData(tSymbol));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
