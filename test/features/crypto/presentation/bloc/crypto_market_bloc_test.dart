import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/domain/entities/market_data_entity.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_assets_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_crypto_asset_details_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/get_market_data_usecase.dart';
import 'package:nemorixpay/features/crypto/domain/usecases/update_market_data_usecase.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_market_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_market_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_market_state.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';
import 'crypto_market_bloc_test.mocks.dart';

@GenerateMocks([
  GetCryptoAssetsUseCase,
  GetCryptoAssetDetailsUseCase,
  GetMarketDataUseCase,
  UpdateMarketDataUseCase,
])
void main() {
  late CryptoMarketBloc bloc;
  late MockGetCryptoAssetsUseCase mockGetCryptoAssetsUseCase;
  late MockGetCryptoAssetDetailsUseCase mockGetCryptoAssetDetailsUseCase;
  late MockGetMarketDataUseCase mockGetMarketDataUseCase;
  late MockUpdateMarketDataUseCase mockUpdateMarketDataUseCase;

  final tAsset = AssetEntity(
    id: 'btc',
    assetCode: 'BTC',
    name: 'Bitcoin',
    assetType: 'crypto',
    network: 'bitcoin',
    decimals: 8,
  );

  final tMarketData = MarketDataEntity(
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
    athDate: DateTime(2021, 11, 10),
    atl: 67.81,
    atlChangePercentage: 73630.0,
    atlDate: DateTime(2013, 7, 5),
    lastUpdated: DateTime.now(),
  );

  final tCryptoAsset = CryptoAssetWithMarketData(
    asset: tAsset,
    marketData: tMarketData,
  );

  setUp(() {
    mockGetCryptoAssetsUseCase = MockGetCryptoAssetsUseCase();
    mockGetCryptoAssetDetailsUseCase = MockGetCryptoAssetDetailsUseCase();
    mockGetMarketDataUseCase = MockGetMarketDataUseCase();
    mockUpdateMarketDataUseCase = MockUpdateMarketDataUseCase();

    bloc = CryptoMarketBloc(
      getCryptoAssetsUseCase: mockGetCryptoAssetsUseCase,
      getCryptoAssetDetailsUseCase: mockGetCryptoAssetDetailsUseCase,
      getMarketDataUseCase: mockGetMarketDataUseCase,
      updateMarketDataUseCase: mockUpdateMarketDataUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be CryptoMarketInitial', () {
    expect(bloc.state, equals(CryptoMarketInitial()));
  });

  group('GetCryptoAssets', () {
    final tAssets = [tCryptoAsset];

    test(
      'should emit [loading, loaded] when data is gotten successfully',
      () async {
        // arrange
        when(
          mockGetCryptoAssetsUseCase.call(),
        ).thenAnswer((_) async => Right(tAssets));

        // assert later
        final expected = [CryptoMarketLoading(), CryptoAssetsLoaded(tAssets)];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetCryptoAssets());
      },
    );

    test(
      'should emit [loading, error] when data is gotten unsuccessfully',
      () async {
        // arrange
        when(
          mockGetCryptoAssetsUseCase.call(),
        ).thenAnswer((_) async => Left(AssetFailure.unknown('Error')));

        // assert later
        expectLater(
          bloc.stream,
          emitsInOrder([CryptoMarketLoading(), isA<CryptoMarketError>()]),
        );

        // act
        bloc.add(GetCryptoAssets());
      },
    );
  });

  group('GetCryptoAssetDetails', () {
    const tSymbol = 'BTC';

    test(
      'should emit [loading, loaded] when data is gotten successfully',
      () async {
        // arrange
        when(
          mockGetCryptoAssetDetailsUseCase.call(tSymbol),
        ).thenAnswer((_) async => Right(tCryptoAsset));

        // assert later
        final expected = [
          CryptoMarketLoading(),
          CryptoAssetDetailsLoaded(tCryptoAsset),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetCryptoAssetDetails(tSymbol));
      },
    );

    test(
      'should emit [loading, error] when data is gotten unsuccessfully',
      () async {
        // arrange
        when(
          mockGetCryptoAssetDetailsUseCase.call(tSymbol),
        ).thenAnswer((_) async => Left(AssetFailure.unknown('Error')));

        // assert later
        expectLater(
          bloc.stream,
          emitsInOrder([CryptoMarketLoading(), isA<CryptoMarketError>()]),
        );

        // act
        bloc.add(GetCryptoAssetDetails(tSymbol));
      },
    );
  });

  group('GetMarketData', () {
    const tSymbol = 'BTC';

    test(
      'should emit [loading, loaded] when data is gotten successfully',
      () async {
        // arrange
        when(
          mockGetMarketDataUseCase.call(tSymbol),
        ).thenAnswer((_) async => Right(tMarketData));

        // assert later
        final expected = [CryptoMarketLoading(), MarketDataLoaded(tMarketData)];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetMarketData(tSymbol));
      },
    );

    test(
      'should emit [loading, error] when data is gotten unsuccessfully',
      () async {
        // arrange
        when(
          mockGetMarketDataUseCase.call(tSymbol),
        ).thenAnswer((_) async => Left(AssetFailure.unknown('Error')));

        // assert later
        expectLater(
          bloc.stream,
          emitsInOrder([CryptoMarketLoading(), isA<CryptoMarketError>()]),
        );

        // act
        bloc.add(GetMarketData(tSymbol));
      },
    );
  });

  group('UpdateMarketData', () {
    const tSymbol = 'BTC';

    test(
      'should emit [loading, updated] when data is updated successfully',
      () async {
        // arrange
        when(
          mockUpdateMarketDataUseCase.call(tSymbol),
        ).thenAnswer((_) async => Right(tMarketData));

        // assert later
        final expected = [
          CryptoMarketLoading(),
          MarketDataUpdated(tMarketData),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(UpdateMarketData(tSymbol));
      },
    );

    test(
      'should emit [loading, error] when data update is unsuccessful',
      () async {
        // arrange
        when(
          mockUpdateMarketDataUseCase.call(tSymbol),
        ).thenAnswer((_) async => Left(AssetFailure.unknown('Error')));

        // assert later
        expectLater(
          bloc.stream,
          emitsInOrder([CryptoMarketLoading(), isA<CryptoMarketError>()]),
        );

        // act
        bloc.add(UpdateMarketData(tSymbol));
      },
    );
  });

  group('AutoUpdate', () {
    const tSymbol = 'BTC';

    test('should start auto update and emit states', () async {
      // arrange
      when(
        mockUpdateMarketDataUseCase.call(tSymbol),
      ).thenAnswer((_) async => Right(tMarketData));

      // assert later
      expectLater(
        bloc.stream,
        emitsInOrder([CryptoMarketLoading(), MarketDataUpdated(tMarketData)]),
      );

      // act
      bloc.add(StartAutoUpdate(symbol: tSymbol));
    });

    test('should stop auto update', () {
      // act
      bloc.add(StopAutoUpdate());

      // assert
      expect(bloc.state, isA<CryptoMarketInitial>());
    });
  });
}
