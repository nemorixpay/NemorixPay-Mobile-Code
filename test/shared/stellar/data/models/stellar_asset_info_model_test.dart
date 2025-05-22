import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_asset_info_model.dart';

/// @file        stellar_asset_info_model_test.dart
/// @brief       Tests for StellarAssetInfoModel class.
/// @details     This file contains unit tests for the StellarAssetInfoModel class,
///              including tests for serialization, deserialization, and mapping.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  group('StellarAssetInfoModel', () {
    const tModel = StellarAssetInfoModel(
      code: 'USDC',
      name: 'USD Coin',
      description: 'USD Coin on Stellar',
      issuer: 'G...',
      issuerName: 'Circle',
      isVerified: true,
      logoUrl: 'https://example.com/usdc.png',
      decimals: 7,
      type: 'credit_alphanum4',
    );

    test('should be a subclass of StellarAssetInfoModel', () {
      expect(tModel, isA<StellarAssetInfoModel>());
    });

    test('should create a valid model from json', () {
      // arrange
      final json = {
        'code': 'USDC',
        'name': 'USD Coin',
        'description': 'USD Coin on Stellar',
        'issuer': 'G...',
        'issuerName': 'Circle',
        'isVerified': true,
        'logoUrl': 'https://example.com/usdc.png',
        'decimals': 7,
        'type': 'credit_alphanum4',
      };

      // act
      final result = StellarAssetInfoModel.fromJson(json);

      // assert
      expect(result, equals(tModel));
    });

    test('should convert model to json', () {
      // act
      final json = tModel.toJson();

      // assert
      expect(json, {
        'code': 'USDC',
        'name': 'USD Coin',
        'description': 'USD Coin on Stellar',
        'issuer': 'G...',
        'issuerName': 'Circle',
        'isVerified': true,
        'logoUrl': 'https://example.com/usdc.png',
        'decimals': 7,
        'type': 'credit_alphanum4',
      });
    });

    test('should convert model to entity', () {
      // act
      final entity = tModel.toEntity();

      // assert
      expect(entity.code, equals(tModel.code));
      expect(entity.name, equals(tModel.name));
      expect(entity.description, equals(tModel.description));
      expect(entity.issuer, equals(tModel.issuer));
      expect(entity.issuerName, equals(tModel.issuerName));
      expect(entity.isVerified, equals(tModel.isVerified));
      expect(entity.logoUrl, equals(tModel.logoUrl));
      expect(entity.decimals, equals(tModel.decimals));
      expect(entity.type, equals(tModel.type));
    });

    test('should create a copy with new values', () {
      // act
      final result = tModel.copyWith(
        name: 'New Name',
        description: 'New Description',
      );

      // assert
      expect(result.code, equals(tModel.code));
      expect(result.name, equals('New Name'));
      expect(result.description, equals('New Description'));
      expect(result.issuer, equals(tModel.issuer));
      expect(result.issuerName, equals(tModel.issuerName));
      expect(result.isVerified, equals(tModel.isVerified));
      expect(result.logoUrl, equals(tModel.logoUrl));
      expect(result.decimals, equals(tModel.decimals));
      expect(result.type, equals(tModel.type));
    });

    test('should return true when comparing equal models', () {
      // arrange
      final model1 = StellarAssetInfoModel(
        code: 'USDC',
        name: 'USD Coin',
        description: 'USD Coin on Stellar',
        issuer: 'G...',
        issuerName: 'Circle',
        isVerified: true,
        logoUrl: 'https://example.com/usdc.png',
        decimals: 7,
        type: 'credit_alphanum4',
      );

      final model2 = StellarAssetInfoModel(
        code: 'USDC',
        name: 'USD Coin',
        description: 'USD Coin on Stellar',
        issuer: 'G...',
        issuerName: 'Circle',
        isVerified: true,
        logoUrl: 'https://example.com/usdc.png',
        decimals: 7,
        type: 'credit_alphanum4',
      );

      // assert
      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
    });
  });
}
