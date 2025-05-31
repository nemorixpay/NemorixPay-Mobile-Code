import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset.dart';

void main() {
  late AssetCacheManager cacheManager;
  late Asset testAsset1;
  late Asset testAsset2;

  setUp(() {
    cacheManager = AssetCacheManager(
      expirationDuration: const Duration(seconds: 1),
    );
    cacheManager.clearAssets();

    // Crear assets de prueba
    testAsset1 = Asset(
      id: '1',
      asset_code: 'XLM',
      name: 'Stellar Lumens',
      symbol: 'XLM',
      asset_type: 'native',
      asset_issuer: '',
      network: 'stellar',
      balance: 100.0,
      limit: 0.0,
      buying_liabilities: 0.0,
      selling_liabilities: 0.0,
      last_modified_ledger: 1,
      last_modified_time: DateTime.now(),
      is_authorized: true,
      is_authorized_to_maintain_liabilities: true,
      is_clawback_enabled: false,
    );

    testAsset2 = Asset(
      id: '2',
      asset_code: 'USDC',
      name: 'USD Coin',
      symbol: 'USDC',
      asset_type: 'credit_alphanum4',
      asset_issuer: 'ISSUER123',
      network: 'stellar',
      balance: 50.0,
      limit: 1000.0,
      buying_liabilities: 0.0,
      selling_liabilities: 0.0,
      last_modified_ledger: 1,
      last_modified_time: DateTime.now(),
      is_authorized: true,
      is_authorized_to_maintain_liabilities: true,
      is_clawback_enabled: false,
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
      expect(cacheManager.getAsset('1'), equals(testAsset1));
      expect(cacheManager.getAsset('2'), equals(testAsset2));
    });

    test('should clear cache', () {
      cacheManager.clearAssets();
      expect(cacheManager.assetCount, equals(0));
      expect(cacheManager.getAsset('1'), isNull);
    });

    test('should remove specific asset', () async {
      await cacheManager.updateAssets([testAsset1, testAsset2]);
      cacheManager.removeAsset('1');
      expect(cacheManager.assetCount, equals(1));
      expect(cacheManager.getAsset('1'), isNull);
      expect(cacheManager.getAsset('2'), equals(testAsset2));
    });
  });

  group('Filtering Operations', () {
    setUp(() async {
      await cacheManager.updateAssets([testAsset1, testAsset2]);
    });

    test('should get native assets', () {
      final nativeAssets = cacheManager.nativeAssets;
      expect(nativeAssets.length, equals(1));
      expect(nativeAssets.first.asset_code, equals('XLM'));
    });

    test('should get assets by network', () {
      final stellarAssets = cacheManager.getAssetsByNetwork('stellar');
      expect(stellarAssets.length, equals(2));
    });

    test('should get assets by type', () {
      final nativeAssets = cacheManager.getAssetsByType('native');
      expect(nativeAssets.length, equals(1));
      expect(nativeAssets.first.asset_code, equals('XLM'));
    });

    test('should get assets by issuer', () {
      final issuerAssets = cacheManager.getAssetsByIssuer('ISSUER123');
      expect(issuerAssets.length, equals(1));
      expect(issuerAssets.first.asset_code, equals('USDC'));
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
      expect(assets.first.asset_code, equals('USDC'));
    });
  });

  group('Concurrent Operations', () {
    test('should handle concurrent updates', () async {
      final futures = List.generate(
        5,
        (index) => cacheManager.updateAssets([
          Asset(
            id: index.toString(),
            asset_code: 'TEST$index',
            name: 'Test Asset $index',
            symbol: 'TEST$index',
            asset_type: 'credit_alphanum4',
            asset_issuer: 'ISSUER$index',
            network: 'stellar',
            balance: 100.0,
            limit: 0.0,
            buying_liabilities: 0.0,
            selling_liabilities: 0.0,
            last_modified_ledger: 1,
            last_modified_time: DateTime.now(),
            is_authorized: true,
            is_authorized_to_maintain_liabilities: true,
            is_clawback_enabled: false,
          ),
        ]),
      );

      await Future.wait(futures);
      expect(cacheManager.assetCount, equals(5));
    });
  });
}
