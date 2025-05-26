import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
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
    when(
      mockRepository.updatePrice(tSymbol),
    ).thenAnswer((_) async => Right(tAsset));

    // act
    final result = await useCase(tSymbol);

    // assert
    expect(result, equals(Right(tAsset)));
    verify(mockRepository.updatePrice(tSymbol));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    final failure = AssetFailure.priceUpdateFailed('Error');
    when(
      mockRepository.updatePrice(tSymbol),
    ).thenAnswer((_) async => Left(failure));

    // act
    final result = await useCase(tSymbol);

    // assert
    expect(result, equals(Left(failure)));
    verify(mockRepository.updatePrice(tSymbol));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure for empty symbol', () async {
    // arrange
    final failure = AssetFailure.invalidSymbol('Symbol cannot be empty');
    when(mockRepository.updatePrice('')).thenAnswer((_) async => Left(failure));

    // act
    final result = await useCase('');

    // assert
    expect(result, equals(Left(failure)));
    verify(mockRepository.updatePrice(''));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should propagate network errors', () async {
    // arrange
    final failure = AssetFailure.networkError('Network error');
    when(
      mockRepository.updatePrice(tSymbol),
    ).thenAnswer((_) async => Left(failure));

    // act
    final result = await useCase(tSymbol);

    // assert
    expect(result, equals(Left(failure)));
    verify(mockRepository.updatePrice(tSymbol));
    verifyNoMoreInteractions(mockRepository);
  });
}
