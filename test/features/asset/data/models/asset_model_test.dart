import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/features/asset/data/models/asset_model.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_entity.dart';

/// @file        asset_model_test.dart
/// @brief       Unit tests for AssetModel.
/// @details     Tests the serialization, deserialization and conversion methods
///             of the AssetModel class.
/// @author      Miguel Fagundez
/// @date        05/24/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  final tAssetModel = AssetModel(
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
    atlChangePercentage: 73630.0,
    atlDate: DateTime.utc(2013, 7, 6),
    lastUpdated: DateTime.utc(2025, 5, 24),
    isFavorite: false,
  );

  final tJson = {
    'name': 'Bitcoin',
    'symbol': 'BTC',
    'logoPath': 'assets/images/btc.png',
    'currentPrice': 50000.0,
    'priceChange': 1000.0,
    'priceChangePercentage': 2.0,
    'marketCap': 1000000000.0,
    'volume': 500000000.0,
    'high24h': 51000.0,
    'low24h': 49000.0,
    'circulatingSupply': 19000000.0,
    'totalSupply': 21000000.0,
    'maxSupply': 21000000.0,
    'ath': 69000.0,
    'athChangePercentage': -27.5,
    'athDate': '2021-11-10T00:00:00.000Z',
    'atl': 67.81,
    'atlChangePercentage': 73630.0,
    'atlDate': '2013-07-06T00:00:00.000Z',
    'lastUpdated': '2025-05-24T00:00:00.000Z',
    'isFavorite': false,
  };

  group('AssetModel', () {
    group('fromJson', () {
      test('should return a valid model when the JSON is valid', () async {
        // act
        final result = AssetModel.fromJson(tJson);

        // assert
        expect(result, equals(tAssetModel));
      });

      test('should return a valid model when maxSupply is null', () async {
        // arrange
        final json = Map<String, dynamic>.from(tJson)..remove('maxSupply');

        // act
        final result = AssetModel.fromJson(json);

        // assert
        expect(result.maxSupply, null);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () async {
        // act
        final result = tAssetModel.toJson();

        // assert
        expect(result, equals(tJson));
      });
    });

    group('toEntity', () {
      test('should return a valid entity with the same data', () async {
        // act
        final result = tAssetModel.toEntity();

        // assert
        expect(result, isA<AssetEntity>());
        expect(result.name, equals(tAssetModel.name));
        expect(result.symbol, equals(tAssetModel.symbol));
        expect(result.currentPrice, equals(tAssetModel.currentPrice));
        expect(result.priceChange, equals(tAssetModel.priceChange));
        expect(
          result.priceChangePercentage,
          equals(tAssetModel.priceChangePercentage),
        );
        expect(result.marketCap, equals(tAssetModel.marketCap));
        expect(result.volume, equals(tAssetModel.volume));
        expect(result.high24h, equals(tAssetModel.high24h));
        expect(result.low24h, equals(tAssetModel.low24h));
        expect(result.circulatingSupply, equals(tAssetModel.circulatingSupply));
        expect(result.totalSupply, equals(tAssetModel.totalSupply));
        expect(result.maxSupply, equals(tAssetModel.maxSupply));
        expect(result.ath, equals(tAssetModel.ath));
        expect(
          result.athChangePercentage,
          equals(tAssetModel.athChangePercentage),
        );
        expect(result.athDate, equals(tAssetModel.athDate));
        expect(result.atl, equals(tAssetModel.atl));
        expect(
          result.atlChangePercentage,
          equals(tAssetModel.atlChangePercentage),
        );
        expect(result.atlDate, equals(tAssetModel.atlDate));
        expect(result.lastUpdated, equals(tAssetModel.lastUpdated));
        expect(result.isFavorite, equals(tAssetModel.isFavorite));
      });
    });

    group('copyWith', () {
      test('should return a new model with the updated values', () async {
        // arrange
        const newName = 'Ethereum';
        const newSymbol = 'ETH';
        const newIsFavorite = true;

        // act
        final result = tAssetModel.copyWith(
          name: newName,
          symbol: newSymbol,
          isFavorite: newIsFavorite,
        );

        // assert
        expect(result.name, equals(newName));
        expect(result.symbol, equals(newSymbol));
        expect(result.isFavorite, equals(newIsFavorite));
        expect(
          result.currentPrice,
          equals(tAssetModel.currentPrice),
        ); // unchanged
        expect(result.marketCap, equals(tAssetModel.marketCap)); // unchanged
      });

      test(
        'should return a new model with the same values when no parameters are provided',
        () async {
          // act
          final result = tAssetModel.copyWith();

          // assert
          expect(result, equals(tAssetModel));
        },
      );
    });
  });
}
