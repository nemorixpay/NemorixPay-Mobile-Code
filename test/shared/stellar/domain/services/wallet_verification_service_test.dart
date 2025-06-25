import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';
import 'package:nemorixpay/core/services/wallet_verification/wallet_verification_service.dart';
import 'package:nemorixpay/core/services/wallet_verification/wallet_verification_result.dart';

import 'wallet_verification_service_test.mocks.dart';

/// @file        wallet_verification_service_test.dart
/// @brief       Tests for WalletVerificationService.
/// @details     This file contains unit tests for the WalletVerificationService
///              to ensure the hybrid verification logic works correctly.
/// @author      Miguel Fagundez
/// @date        06/21/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

@GenerateMocks([StellarAccountProvider, StellarSecureStorageDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WalletVerificationService', () {
    late WalletVerificationService verificationService;
    late MockStellarAccountProvider mockAccountProvider;
    late MockStellarSecureStorageDataSource mockSecureStorage;

    setUp(() {
      mockAccountProvider = MockStellarAccountProvider();
      mockSecureStorage = MockStellarSecureStorageDataSource();
      verificationService = WalletVerificationService(
        accountProvider: mockAccountProvider,
        secureStorage: mockSecureStorage,
      );
    });

    group('verifyWalletStatus', () {
      test('should return hasWallet when account exists in memory', () async {
        // Arrange
        const userId = 'test_user';
        const publicKey = 'GABC123456789';

        final mockAccount = StellarAccountModel(
          publicKey: publicKey,
          secretKey: 'test_secret',
          balance: 100.0,
          mnemonic: 'test mnemonic',
          createdAt: DateTime.now(),
        );

        when(mockAccountProvider.currentAccount).thenReturn(mockAccount);
        when(mockAccountProvider.getPublicKey()).thenReturn(publicKey);

        // Act
        final result = await verificationService.verifyWalletStatus(userId);

        // Assert
        expect(result.status, WalletVerificationStatus.hasWallet);
        expect(result.publicKey, publicKey);
        expect(result.route, 'home_2');
        expect(result.message, 'Wallet found in memory');

        verify(mockAccountProvider.currentAccount).called(1);
        verify(mockAccountProvider.getPublicKey()).called(1);
        verifyNever(mockSecureStorage.getAllPublicKeys());
      });

      test('should return hasWallet when wallet exists in secure storage',
          () async {
        // Arrange
        const userId = 'test_user';
        const publicKey = 'GABC123456789';
        const privateKey = 'private_key_123';

        when(mockAccountProvider.currentAccount).thenReturn(null);
        when(mockSecureStorage.getAllPublicKeys())
            .thenAnswer((_) async => [publicKey]);
        when(mockSecureStorage.getPrivateKey(publicKey: publicKey))
            .thenAnswer((_) async => privateKey);

        // Act
        final result = await verificationService.verifyWalletStatus(userId);

        // Assert
        expect(result.status, WalletVerificationStatus.hasWallet);
        expect(result.publicKey, publicKey);
        expect(result.route, 'home_2');
        expect(result.message, 'Wallet found in secure storage');

        verify(mockAccountProvider.currentAccount).called(1);
        verify(mockSecureStorage.getAllPublicKeys()).called(1);
        verify(mockSecureStorage.getPrivateKey(publicKey: publicKey)).called(1);
      });

      test('should return noWallet when no wallet exists', () async {
        // Arrange
        const userId = 'test_user';

        when(mockAccountProvider.currentAccount).thenReturn(null);
        when(mockSecureStorage.getAllPublicKeys()).thenAnswer((_) async => []);

        // Act
        final result = await verificationService.verifyWalletStatus(userId);

        // Assert
        expect(result.status, WalletVerificationStatus.noWallet);
        expect(result.publicKey, isNull);
        expect(result.route, 'wallet_setup');
        expect(result.message, 'No wallet configured');

        verify(mockAccountProvider.currentAccount).called(1);
        verify(mockSecureStorage.getAllPublicKeys()).called(1);
      });

      test('should return noWallet when public keys exist but no private key',
          () async {
        // Arrange
        const userId = 'test_user';
        const publicKey = 'GABC123456789';

        when(mockAccountProvider.currentAccount).thenReturn(null);
        when(mockSecureStorage.getAllPublicKeys())
            .thenAnswer((_) async => [publicKey]);
        when(mockSecureStorage.getPrivateKey(publicKey: publicKey))
            .thenAnswer((_) async => null);

        // Act
        final result = await verificationService.verifyWalletStatus(userId);

        // Assert
        expect(result.status, WalletVerificationStatus.noWallet);
        expect(result.publicKey, isNull);
        expect(result.route, 'wallet_setup');
        expect(result.message, 'No wallet configured');
      });

      test('should return noWallet when error occurs', () async {
        // Arrange
        const userId = 'test_user';

        when(mockAccountProvider.currentAccount)
            .thenThrow(Exception('Test error'));

        // Act
        final result = await verificationService.verifyWalletStatus(userId);

        // Assert
        expect(result.status, WalletVerificationStatus.noWallet);
        expect(result.publicKey, isNull);
        expect(result.route, 'wallet_setup');
        expect(result.message, contains('Error verifying wallet'));
      });
    });

    group('hasWalletConfigured', () {
      test('should return true when account exists in memory', () async {
        // Arrange
        const userId = 'test_user';
        final mockAccount = StellarAccountModel(
          publicKey: 'test_public',
          secretKey: 'test_secret',
          balance: 100.0,
          mnemonic: 'test mnemonic',
          createdAt: DateTime.now(),
        );
        when(mockAccountProvider.currentAccount).thenReturn(mockAccount);

        // Act
        final result = await verificationService.hasWalletConfigured(userId);

        // Assert
        expect(result, true);
        verify(mockAccountProvider.currentAccount).called(1);
        verifyNever(mockSecureStorage.getAllPublicKeys());
      });

      test('should return true when wallet exists in secure storage', () async {
        // Arrange
        const userId = 'test_user';
        const publicKey = 'GABC123456789';

        when(mockAccountProvider.currentAccount).thenReturn(null);
        when(mockSecureStorage.getAllPublicKeys())
            .thenAnswer((_) async => [publicKey]);
        when(mockSecureStorage.hasPrivateKey(publicKey: publicKey))
            .thenAnswer((_) async => true);

        // Act
        final result = await verificationService.hasWalletConfigured(userId);

        // Assert
        expect(result, true);
        verify(mockSecureStorage.getAllPublicKeys()).called(1);
        verify(mockSecureStorage.hasPrivateKey(publicKey: publicKey)).called(1);
      });

      test('should return false when no wallet exists', () async {
        // Arrange
        const userId = 'test_user';

        when(mockAccountProvider.currentAccount).thenReturn(null);
        when(mockSecureStorage.getAllPublicKeys()).thenAnswer((_) async => []);

        // Act
        final result = await verificationService.hasWalletConfigured(userId);

        // Assert
        expect(result, false);
      });
    });

    group('getStoredPublicKey', () {
      test('should return public key from memory first', () async {
        // Arrange
        const userId = 'test_user';
        const publicKey = 'GABC123456789';

        when(mockAccountProvider.getPublicKey()).thenReturn(publicKey);

        // Act
        final result = await verificationService.getStoredPublicKey(userId);

        // Assert
        expect(result, publicKey);
        verify(mockAccountProvider.getPublicKey()).called(1);
        verifyNever(mockSecureStorage.getAllPublicKeys());
      });

      test('should return public key from secure storage when not in memory',
          () async {
        // Arrange
        const userId = 'test_user';
        const publicKey = 'GABC123456789';

        when(mockAccountProvider.getPublicKey()).thenReturn(null);
        when(mockSecureStorage.getAllPublicKeys())
            .thenAnswer((_) async => [publicKey]);
        when(mockSecureStorage.hasPrivateKey(publicKey: publicKey))
            .thenAnswer((_) async => true);

        // Act
        final result = await verificationService.getStoredPublicKey(userId);

        // Assert
        expect(result, publicKey);
        verify(mockAccountProvider.getPublicKey()).called(1);
        verify(mockSecureStorage.getAllPublicKeys()).called(1);
        verify(mockSecureStorage.hasPrivateKey(publicKey: publicKey)).called(1);
      });

      test('should return null when no wallet exists', () async {
        // Arrange
        const userId = 'test_user';

        when(mockAccountProvider.getPublicKey()).thenReturn(null);
        when(mockSecureStorage.getAllPublicKeys()).thenAnswer((_) async => []);

        // Act
        final result = await verificationService.getStoredPublicKey(userId);

        // Assert
        expect(result, isNull);
      });
    });
  });
}
