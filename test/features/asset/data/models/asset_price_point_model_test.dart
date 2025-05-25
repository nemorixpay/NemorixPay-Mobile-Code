import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/features/asset/data/models/asset_price_point_model.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_price_point.dart';

/// @file        asset_price_point_model_test.dart
/// @brief       Unit tests for AssetPricePointModel.
/// @details     Tests the serialization, deserialization and conversion methods
///             of the AssetPricePointModel class.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  final tAssetPricePointModel = AssetPricePointModel(
    price: 50000.0,
    volume: 1000000.0,
    marketCap: 1000000000.0,
    timestamp: DateTime.utc(2025, 5, 24, 12, 0),
  );

  final tJson = {
    'price': 50000.0,
    'volume': 1000000.0,
    'marketCap': 1000000000.0,
    'timestamp': '2025-05-24T12:00:00.000Z',
  };

  group('AssetPricePointModel', () {
    group('fromJson', () {
      test('should return a valid model when the JSON is valid', () async {
        // act
        final result = AssetPricePointModel.fromJson(tJson);

        // assert
        expect(result, equals(tAssetPricePointModel));
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () async {
        // act
        final result = tAssetPricePointModel.toJson();

        // assert
        expect(result, equals(tJson));
      });
    });

    group('toEntity', () {
      test('should return a valid entity with the same data', () async {
        // act
        final result = tAssetPricePointModel.toEntity();

        // assert
        expect(result, isA<AssetPricePoint>());
        expect(result.price, equals(tAssetPricePointModel.price));
        expect(result.volume, equals(tAssetPricePointModel.volume));
        expect(result.marketCap, equals(tAssetPricePointModel.marketCap));
        expect(result.timestamp, equals(tAssetPricePointModel.timestamp));
      });
    });

    group('copyWith', () {
      test('should return a new model with the updated values', () async {
        // arrange
        const newPrice = 51000.0;
        const newVolume = 1100000.0;

        // act
        final result = tAssetPricePointModel.copyWith(
          price: newPrice,
          volume: newVolume,
        );

        // assert
        expect(result.price, equals(newPrice));
        expect(result.volume, equals(newVolume));
        expect(
          result.marketCap,
          equals(tAssetPricePointModel.marketCap),
        ); // unchanged
        expect(
          result.timestamp,
          equals(tAssetPricePointModel.timestamp),
        ); // unchanged
      });

      test(
        'should return a new model with the same values when no parameters are provided',
        () async {
          // act
          final result = tAssetPricePointModel.copyWith();

          // assert
          expect(result, equals(tAssetPricePointModel));
        },
      );
    });
  });
}
