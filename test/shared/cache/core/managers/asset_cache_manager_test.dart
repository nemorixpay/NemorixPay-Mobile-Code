import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';
import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';

void main() {
  late AssetCacheManager cacheManager;
  late AssetModel testAsset1;
  late AssetModel testAsset2;

  setUp(() {
    cacheManager = AssetCacheManager(
      expirationDuration: const Duration(seconds: 1),
    );
    cacheManager.clearCache();

    // Crear assets de prueba
    testAsset1 = AssetModel(
      id: '1',
      assetCode: 'XLM',
      name: 'Stellar Lumens',
      assetType: 'native',
      assetIssuer: '',
      network: 'stellar',
      balance: 100.0,
      limit: 0.0,
      decimals: 7,
    );

    testAsset2 = AssetModel(
      id: '2',
      assetCode: 'USDC',
      name: 'USD Coin',
      assetType: 'credit_alphanum4',
      assetIssuer: 'ISSUER123',
      network: 'stellar',
      balance: 50.0,
      limit: 1000.0,
      decimals: 7,
    );
  });

  group('Singleton Pattern', () {
    test('should return the same instance', () {
      final instance1 = AssetCacheManager();
      final instance2 = AssetCacheManager();
      expect(instance1, equals(instance2));
    });
  });

  group('Cache Operations', () {
    test('should update assets in cache', () async {
      await cacheManager.updateAssets([testAsset1, testAsset2]);
      expect(cacheManager.assetCount, equals(2));
      expect(cacheManager.getAssetByCode('1'), equals(testAsset1));
      expect(cacheManager.getAssetByCode('2'), equals(testAsset2));
    });

    test('should clear cache', () {
      cacheManager.clearCache();
      expect(cacheManager.assetCount, equals(0));
      expect(cacheManager.getAssetByCode('1'), isNull);
    });

    test('should remove specific asset', () async {
      await cacheManager.updateAssets([testAsset1, testAsset2]);
      cacheManager.removeAsset('1');
      expect(cacheManager.assetCount, equals(1));
      expect(cacheManager.getAssetByCode('1'), isNull);
      expect(cacheManager.getAssetByCode('2'), equals(testAsset2));
    });
  });

  group('Filtering Operations', () {
    setUp(() async {
      await cacheManager.updateAssets([testAsset1, testAsset2]);
    });

    test('should get native assets', () {
      final nativeAssets = cacheManager.nativeAssets;
      expect(nativeAssets.length, equals(1));
      expect(nativeAssets.first.assetCode, equals('XLM'));
    });

    test('should get assets by network', () async {
      final stellarAssets = await cacheManager.getAssetsByNetwork('stellar');
      expect(stellarAssets.length, equals(2));
    });

    test('should get assets by type', () async {
      final nativeAssets = await cacheManager.getAssetsByType('native');
      expect(nativeAssets.length, equals(1));
      expect(nativeAssets.first.assetCode, equals('XLM'));
    });

    test('should get assets by issuer', () async {
      final issuerAssets = await cacheManager.getAssetsByIssuer('ISSUER123');
      expect(issuerAssets.length, equals(1));
      expect(issuerAssets.first.assetCode, equals('USDC'));
    });
  });

  group('Cache Refresh', () {
    test('should indicate need for refresh when empty', () {
      expect(cacheManager.needsRefresh, isTrue);
    });

    test('should not need refresh immediately after update', () async {
      await cacheManager.updateAssets([testAsset1]);
      expect(cacheManager.needsRefresh, isFalse);
    });

    test('should get assets from cache if not stale', () async {
      await cacheManager.updateAssets([testAsset1]);

      var fetchCount = 0;
      final assets = await cacheManager.getAssetsIfNeeded(() async {
        fetchCount++;
        return [testAsset1];
      });

      expect(fetchCount, equals(0));
      expect(assets.length, equals(1));
    });

    test('should fetch new assets if cache is stale', () async {
      await cacheManager.updateAssets([testAsset1]);

      // Simular que el caché está obsoleto (usando 1 segundo en lugar de 6 minutos)
      await Future.delayed(const Duration(seconds: 1));

      var fetchCount = 0;
      final assets = await cacheManager.getAssetsIfNeeded(() async {
        fetchCount++;
        return [testAsset2];
      });

      expect(fetchCount, equals(1));
      expect(assets.length, equals(1));
      expect(assets.first.assetCode, equals('USDC'));
    });
  });

  group('Concurrent Operations', () {
    test('should handle concurrent updates', () async {
      final futures = List.generate(
        5,
        (index) => cacheManager.updateAssets([
          AssetModel(
            id: index.toString(),
            assetCode: 'TEST$index',
            name: 'Test Asset $index',
            assetType: 'credit_alphanum4',
            assetIssuer: 'ISSUER$index',
            network: 'stellar',
            balance: 100.0,
            limit: 0.0,
            decimals: 7,
          ),
        ]),
      );

      await Future.wait(futures);
      expect(cacheManager.assetCount, equals(5));
    });
  });
}
