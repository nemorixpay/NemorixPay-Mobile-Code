import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';

/// @file        stellar_secure_storage_datasource_test.dart
/// @brief       Tests for the StellarSecureStorageDataSource
/// @details     Verifies that the secure storage data source correctly handles
///              Stellar private and public keys with proper Android/iOS options.
/// @author      Miguel Fagundez
/// @date        07/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StellarSecureStorageDataSource dataSource;

  setUp(() {
    dataSource = StellarSecureStorageDataSource();
  });

  group('hasPublicKey', () {
    const tUserId = 'test_user_id';

    test('should return false when no public key exists', () async {
      // act
      final result = await dataSource.hasPublicKey(userId: tUserId);

      // assert
      expect(result, false);
    });

    test('should handle empty userId gracefully', () async {
      // act
      final result = await dataSource.hasPublicKey(userId: '');

      // assert
      expect(result, false);
    });
  });

  group('hasPrivateKey', () {
    const tPublicKey = 'GABC123456789';

    test('should return false when no private key exists', () async {
      // act
      final result = await dataSource.hasPrivateKey(publicKey: tPublicKey);

      // assert
      expect(result, false);
    });

    test('should handle empty public key gracefully', () async {
      // act
      final result = await dataSource.hasPrivateKey(publicKey: '');

      // assert
      expect(result, false);
    });
  });

  group('savePublicKey and getPublicKey', () {
    const tUserId = 'test_user_id';
    const tPublicKey = 'GABC123456789';

    test('should save and retrieve public key correctly', () async {
      // arrange & act
      final saved = await dataSource.savePublicKey(
        publicKey: tPublicKey,
        userId: tUserId,
      );

      // assert
      expect(saved, true);

      // act
      final retrieved = await dataSource.getPublicKey(userId: tUserId);

      // assert
      expect(retrieved, tPublicKey);
    });
  });

  group('savePrivateKey and getPrivateKey', () {
    const tPublicKey = 'GABC123456789';
    const tPrivateKey = 'SABC123456789';

    test('should save and retrieve private key correctly', () async {
      // arrange & act
      final saved = await dataSource.savePrivateKey(
        publicKey: tPublicKey,
        privateKey: tPrivateKey,
      );

      // assert
      expect(saved, true);

      // act
      final retrieved = await dataSource.getPrivateKey(publicKey: tPublicKey);

      // assert
      expect(retrieved, tPrivateKey);
    });
  });
}
