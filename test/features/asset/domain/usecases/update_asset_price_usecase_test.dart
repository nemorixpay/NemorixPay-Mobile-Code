import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_entity.dart';
import 'package:nemorixpay/features/asset/domain/repositories/asset_repository.dart';
import 'package:nemorixpay/features/asset/domain/usecases/update_asset_price_usecase.dart';

@GenerateMocks([AssetRepository])
import 'update_asset_price_usecase_test.mocks.dart';

/// @file        update_asset_price_usecase_test.dart
/// @brief       Integration tests for UpdateAssetPriceUseCase.
/// @details     Tests the business logic for updating asset prices.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  late UpdateAssetPriceUseCase useCase;
  late MockAssetRepository mockRepository;

  setUp(() {
    mockRepository = MockAssetRepository();
    useCase = UpdateAssetPriceUseCase(mockRepository);
  });

  final tSymbol = 'BTC';
  final tAsset = AssetEntity(
    name: 'Bitcoin',
    symbol: 'BTC',
    logoPath: 'assets/images/btc.png',
    currentPrice: 50000.0,
    priceChange: 1000.0,
    priceChangePercentage: 2.0,
    marketCap: 1000000000.0,
    volume: 500000000.0,
    high24h: 51000.0,
    low24h: 49000.0,
    circulatingSupply: 19000000.0,
    totalSupply: 21000000.0,
    maxSupply: 21000000.0,
    ath: 69000.0,
    athChangePercentage: -27.5,
    athDate: DateTime.utc(2021, 11, 10),
    atl: 67.81,
    atlChangePercentage: 73650.0,
    atlDate: DateTime.utc(2013, 7, 6),
    lastUpdated: DateTime.utc(2025, 5, 24),
    isFavorite: false,
  );

  test('should update asset price from the repository', () async {
    // arrange
    when(mockRepository.updatePrice(tSymbol)).thenAnswer((_) async => tAsset);

    // act
    final result = await useCase(tSymbol);

    // assert
    expect(result, equals(tAsset));
    verify(mockRepository.updatePrice(tSymbol));
    verifyNoMoreInteractions(mockRepository);
  });
}
