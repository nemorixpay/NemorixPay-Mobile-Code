import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/save_public_key_usecase.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';

import 'save_public_key_usecase_test.mocks.dart';

@GenerateMocks([StellarSecureStorageDataSource])

/// @file        save_public_key_usecase_test.dart
/// @brief       Tests for the SavePublicKeyUseCase
/// @details     Verifies that the use case correctly saves a public key
///              for a specific user ID using the secure storage service.
/// @author      Miguel Fagundez
/// @date        2025-01-18
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  late SavePublicKeyUseCase useCase;
  late MockStellarSecureStorageDataSource mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockStellarSecureStorageDataSource();
    useCase = SavePublicKeyUseCase(mockSecureStorage);
  });

  const tPublicKey = 'test_public_key';
  const tUserId = 'test_user_id';

  group('call', () {
    test(
      'should return true when public key is saved successfully',
      () async {
        // arrange
        when(mockSecureStorage.savePublicKey(
          publicKey: tPublicKey,
          userId: tUserId,
        )).thenAnswer((_) async => true);

        // act
        final result = await useCase(tPublicKey, tUserId);

        // assert
        expect(result, true);
        verify(mockSecureStorage.savePublicKey(
          publicKey: tPublicKey,
          userId: tUserId,
        ));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test(
      'should return false when secure storage fails to save',
      () async {
        // arrange
        when(mockSecureStorage.savePublicKey(
          publicKey: tPublicKey,
          userId: tUserId,
        )).thenAnswer((_) async => false);

        // act
        final result = await useCase(tPublicKey, tUserId);

        // assert
        expect(result, false);
        verify(mockSecureStorage.savePublicKey(
          publicKey: tPublicKey,
          userId: tUserId,
        ));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test(
      'should return false when secure storage throws an exception',
      () async {
        // arrange
        when(mockSecureStorage.savePublicKey(
          publicKey: tPublicKey,
          userId: tUserId,
        )).thenThrow(Exception('Storage error'));

        // act
        final result = await useCase(tPublicKey, tUserId);

        // assert
        expect(result, false);
        verify(mockSecureStorage.savePublicKey(
          publicKey: tPublicKey,
          userId: tUserId,
        ));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test(
      'should handle empty public key gracefully',
      () async {
        // arrange
        when(mockSecureStorage.savePublicKey(
          publicKey: '',
          userId: tUserId,
        )).thenAnswer((_) async => true);

        // act
        final result = await useCase('', tUserId);

        // assert
        expect(result, true);
        verify(mockSecureStorage.savePublicKey(
          publicKey: '',
          userId: tUserId,
        ));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test(
      'should handle empty userId gracefully',
      () async {
        // arrange
        when(mockSecureStorage.savePublicKey(
          publicKey: tPublicKey,
          userId: '',
        )).thenAnswer((_) async => true);

        // act
        final result = await useCase(tPublicKey, '');

        // assert
        expect(result, true);
        verify(mockSecureStorage.savePublicKey(
          publicKey: tPublicKey,
          userId: '',
        ));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );
  });
}
