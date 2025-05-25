import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_price_point.dart';
import 'package:nemorixpay/features/asset/domain/repositories/asset_repository.dart';
import 'package:nemorixpay/features/asset/domain/usecases/get_price_history_usecase.dart';

@GenerateMocks([AssetRepository])
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
    AssetPricePoint(
      price: 50000.0,
      volume: 1000000.0,
      marketCap: 1000000000.0,
      timestamp: DateTime.utc(2025, 5, 24, 12, 0),
    ),
    AssetPricePoint(
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
    ).thenAnswer((_) async => tPriceHistory);

    // act
    final result = await useCase(tSymbol, start: tStart, end: tEnd);

    // assert
    expect(result, equals(tPriceHistory));
    verify(mockRepository.getPriceHistory(tSymbol, start: tStart, end: tEnd));
    verifyNoMoreInteractions(mockRepository);
  });
}
