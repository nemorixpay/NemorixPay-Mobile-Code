import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';

/// @file        stellar_asset_info_test.dart
/// @brief       Tests for StellarAssetInfo entity.
/// @details     This file contains unit tests for the StellarAssetInfo entity,
///              including tests for equality, props, and mapping.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  group('StellarAssetInfo', () {
    const tEntity = AssetEntity(
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

    test('should be a subclass of StellarAssetInfo', () {
      expect(tEntity, isA<AssetEntity>());
    });

    test('should convert entity to model', () {
      // act
      final model = tEntity.toModel();

      // assert
      expect(model.assetCode, equals(tEntity.assetCode));
      expect(model.name, equals(tEntity.name));
      expect(model.description, equals(tEntity.description));
      expect(model.assetIssuer, equals(tEntity.assetIssuer));
      expect(model.issuerName, equals(tEntity.issuerName));
      expect(model.isVerified, equals(tEntity.isVerified));
      expect(model.logoUrl, equals(tEntity.logoUrl));
      expect(model.decimals, equals(tEntity.decimals));
      expect(model.assetType, equals(tEntity.assetType));
    });

    test('should create a copy with new values', () {
      // act
      final result = tEntity.copyWith(
        name: 'New Name',
        description: 'New Description',
      );

      // assert
      expect(result.assetCode, equals(tEntity.assetCode));
      expect(result.name, equals('New Name'));
      expect(result.description, equals('New Description'));
      expect(result.assetIssuer, equals(tEntity.assetIssuer));
      expect(result.issuerName, equals(tEntity.issuerName));
      expect(result.isVerified, equals(tEntity.isVerified));
      expect(result.logoUrl, equals(tEntity.logoUrl));
      expect(result.decimals, equals(tEntity.decimals));
      expect(result.assetType, equals(tEntity.assetType));
    });

    test('should return true when comparing equal entities', () {
      // arrange
      final entity1 = AssetEntity(
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

      final entity2 = AssetEntity(
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
      expect(entity1, equals(entity2));
      expect(entity1.props, equals(entity2.props));
    });

    test('should return false when comparing different entities', () {
      // arrange
      final entity1 = AssetEntity(
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

      final entity2 = AssetEntity(
        assetCode: 'USDT',
        name: 'Tether',
        description: 'Tether on Stellar',
        assetIssuer: 'G...',
        issuerName: 'Tether',
        isVerified: true,
        logoUrl: 'https://example.com/usdt.png',
        decimals: 7,
        assetType: 'credit_alphanum4',
        id: '',
        network: '',
      );

      // assert
      expect(entity1, isNot(equals(entity2)));
      expect(entity1.props, isNot(equals(entity2.props)));
    });
  });
}
