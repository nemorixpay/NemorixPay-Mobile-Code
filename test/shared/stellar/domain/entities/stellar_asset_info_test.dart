import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_asset_info.dart';

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
    const tEntity = StellarAssetInfo(
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

    test('should be a subclass of StellarAssetInfo', () {
      expect(tEntity, isA<StellarAssetInfo>());
    });

    test('should convert entity to model', () {
      // act
      final model = tEntity.toModel();

      // assert
      expect(model.code, equals(tEntity.code));
      expect(model.name, equals(tEntity.name));
      expect(model.description, equals(tEntity.description));
      expect(model.issuer, equals(tEntity.issuer));
      expect(model.issuerName, equals(tEntity.issuerName));
      expect(model.isVerified, equals(tEntity.isVerified));
      expect(model.logoUrl, equals(tEntity.logoUrl));
      expect(model.decimals, equals(tEntity.decimals));
      expect(model.type, equals(tEntity.type));
    });

    test('should create a copy with new values', () {
      // act
      final result = tEntity.copyWith(
        name: 'New Name',
        description: 'New Description',
      );

      // assert
      expect(result.code, equals(tEntity.code));
      expect(result.name, equals('New Name'));
      expect(result.description, equals('New Description'));
      expect(result.issuer, equals(tEntity.issuer));
      expect(result.issuerName, equals(tEntity.issuerName));
      expect(result.isVerified, equals(tEntity.isVerified));
      expect(result.logoUrl, equals(tEntity.logoUrl));
      expect(result.decimals, equals(tEntity.decimals));
      expect(result.type, equals(tEntity.type));
    });

    test('should return true when comparing equal entities', () {
      // arrange
      final entity1 = StellarAssetInfo(
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

      final entity2 = StellarAssetInfo(
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
      expect(entity1, equals(entity2));
      expect(entity1.props, equals(entity2.props));
    });

    test('should return false when comparing different entities', () {
      // arrange
      final entity1 = StellarAssetInfo(
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

      final entity2 = StellarAssetInfo(
        code: 'USDT',
        name: 'Tether',
        description: 'Tether on Stellar',
        issuer: 'G...',
        issuerName: 'Tether',
        isVerified: true,
        logoUrl: 'https://example.com/usdt.png',
        decimals: 7,
        type: 'credit_alphanum4',
      );

      // assert
      expect(entity1, isNot(equals(entity2)));
      expect(entity1.props, isNot(equals(entity2.props)));
    });
  });
}
