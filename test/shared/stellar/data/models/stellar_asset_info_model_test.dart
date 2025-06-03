import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/shared/common/data/models/asset_model.dart';

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
    const tModel = AssetModel(
      assetCode: 'USDC',
      name: 'USD Coin',
      description: 'USD Coin on Stellar',
      assetIssuer: 'G...',
      issuerName: 'Circle',
      isVerified: true,
      logoUrl: 'https://example.com/usdc.png',
      decimals: 7,
      assetType: 'credit_alphanum4',
      id: '',
      network: '',
    );

    test('should be a subclass of StellarAssetInfoModel', () {
      expect(tModel, isA<AssetModel>());
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
      final result = AssetModel.fromJson(json);

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
      expect(entity.assetCode, equals(tModel.assetCode));
      expect(entity.name, equals(tModel.name));
      expect(entity.description, equals(tModel.description));
      expect(entity.assetIssuer, equals(tModel.assetIssuer));
      expect(entity.issuerName, equals(tModel.issuerName));
      expect(entity.isVerified, equals(tModel.isVerified));
      expect(entity.logoUrl, equals(tModel.logoUrl));
      expect(entity.decimals, equals(tModel.decimals));
      expect(entity.assetType, equals(tModel.assetType));
    });

    test('should create a copy with new values', () {
      // act
      final result = tModel.copyWith(
        name: 'New Name',
        description: 'New Description',
      );

      // assert
      expect(result.assetCode, equals(tModel.assetCode));
      expect(result.name, equals('New Name'));
      expect(result.description, equals('New Description'));
      expect(result.assetIssuer, equals(tModel.assetIssuer));
      expect(result.issuerName, equals(tModel.issuerName));
      expect(result.isVerified, equals(tModel.isVerified));
      expect(result.logoUrl, equals(tModel.logoUrl));
      expect(result.decimals, equals(tModel.decimals));
      expect(result.assetType, equals(tModel.assetType));
    });

    test('should return true when comparing equal models', () {
      // arrange
      final model1 = AssetModel(
        assetCode: 'USDC',
        name: 'USD Coin',
        description: 'USD Coin on Stellar',
        assetIssuer: 'G...',
        issuerName: 'Circle',
        isVerified: true,
        logoUrl: 'https://example.com/usdc.png',
        decimals: 7,
        assetType: 'credit_alphanum4',
        id: '',
        network: '',
      );

      final model2 = AssetModel(
        assetCode: 'USDC',
        name: 'USD Coin',
        description: 'USD Coin on Stellar',
        assetIssuer: 'G...',
        issuerName: 'Circle',
        isVerified: true,
        logoUrl: 'https://example.com/usdc.png',
        decimals: 7,
        assetType: 'credit_alphanum4',
        id: '',
        network: '',
      );

      // assert
      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
    });
  });
}
