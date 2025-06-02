import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_price_point.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_price_history_usecase.dart';

@GenerateMocks([CryptoRepository])
import 'get_price_history_usecase_test.mocks.dart';

/// @file        get_price_history_usecase_test.dart
/// @brief       Integration tests for GetPriceHistoryUseCase.
/// @details     Tests the business logic for retrieving asset price history.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  late GetPriceHistoryUseCase useCase;
  late MockAssetRepository mockRepository;

  setUp(() {
    mockRepository = MockAssetRepository();
    useCase = GetPriceHistoryUseCase(mockRepository);
  });

  final tSymbol = 'BTC';
  final tStart = DateTime.utc(2025, 5, 24, 0, 0);
  final tEnd = DateTime.utc(2025, 5, 24, 23, 59);
  final tPriceHistory = [
    CryptoPricePoint(
      price: 50000.0,
      volume: 1000000.0,
      marketCap: 1000000000.0,
      timestamp: DateTime.utc(2025, 5, 24, 12, 0),
    ),
    CryptoPricePoint(
      price: 51000.0,
      volume: 1100000.0,
      marketCap: 1100000000.0,
      timestamp: DateTime.utc(2025, 5, 24, 13, 0),
    ),
  ];

  test('should get price history from the repository', () async {
    // arrange
    when(
      mockRepository.getPriceHistory(tSymbol, start: tStart, end: tEnd),
    ).thenAnswer((_) async => Right(tPriceHistory));

    // act
    final result = await useCase(tSymbol, start: tStart, end: tEnd);

    // assert
    expect(result, equals(Right(tPriceHistory)));
    verify(mockRepository.getPriceHistory(tSymbol, start: tStart, end: tEnd));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    final failure = AssetFailure.priceHistoryNotFound('Error');
    when(
      mockRepository.getPriceHistory(tSymbol, start: tStart, end: tEnd),
    ).thenAnswer((_) async => Left(failure));

    // act
    final result = await useCase(tSymbol, start: tStart, end: tEnd);

    // assert
    expect(result, equals(Left(failure)));
    verify(mockRepository.getPriceHistory(tSymbol, start: tStart, end: tEnd));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure for invalid symbol', () async {
    // arrange
    final failure = AssetFailure.invalidSymbol('Invalid symbol');
    when(
      mockRepository.getPriceHistory('', start: tStart, end: tEnd),
    ).thenAnswer((_) async => Left(failure));

    // act
    final result = await useCase('', start: tStart, end: tEnd);

    // assert
    expect(result, equals(Left(failure)));
    verify(mockRepository.getPriceHistory('', start: tStart, end: tEnd));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure for invalid date range', () async {
    // arrange
    final failure = AssetFailure.priceHistoryNotFound('Invalid date range');
    when(
      mockRepository.getPriceHistory(tSymbol, start: tEnd, end: tStart),
    ).thenAnswer((_) async => Left(failure));

    // act
    final result = await useCase(tSymbol, start: tEnd, end: tStart);

    // assert
    expect(result, equals(Left(failure)));
    verify(mockRepository.getPriceHistory(tSymbol, start: tEnd, end: tStart));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should propagate network errors', () async {
    // arrange
    final failure = AssetFailure.networkError('Network error');
    when(
      mockRepository.getPriceHistory(tSymbol, start: tStart, end: tEnd),
    ).thenAnswer((_) async => Left(failure));

    // act
    final result = await useCase(tSymbol, start: tStart, end: tEnd);

    // assert
    expect(result, equals(Left(failure)));
    verify(mockRepository.getPriceHistory(tSymbol, start: tStart, end: tEnd));
    verifyNoMoreInteractions(mockRepository);
  });
}
