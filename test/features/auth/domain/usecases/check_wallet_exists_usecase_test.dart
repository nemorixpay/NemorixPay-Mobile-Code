import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/auth/domain/usecases/check_wallet_exists_usecase.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';

import 'check_wallet_exists_usecase_test.mocks.dart';

@GenerateMocks([StellarSecureStorageDataSource])

/// @file        check_wallet_exists_usecase_test.dart
/// @brief       Tests for the CheckWalletExistsUseCase
/// @details     Verifies that the use case correctly checks if a wallet exists
///              for a specific user ID using the secure storage service.
/// @author      Miguel Fagundez
/// @date        2025-01-18
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  late CheckWalletExistsUseCase useCase;
  late MockStellarSecureStorageDataSource mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockStellarSecureStorageDataSource();
    useCase = CheckWalletExistsUseCase(mockSecureStorage);
  });

  const tUserId = 'test_user_id';

  group('call', () {
    test(
      'should return true when wallet exists for the user',
      () async {
        // arrange
        when(mockSecureStorage.hasPublicKey(userId: tUserId))
            .thenAnswer((_) async => true);

        // act
        final result = await useCase(tUserId);

        // assert
        expect(result, true);
        verify(mockSecureStorage.hasPublicKey(userId: tUserId));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test(
      'should return false when wallet does not exist for the user',
      () async {
        // arrange
        when(mockSecureStorage.hasPublicKey(userId: tUserId))
            .thenAnswer((_) async => false);

        // act
        final result = await useCase(tUserId);

        // assert
        expect(result, false);
        verify(mockSecureStorage.hasPublicKey(userId: tUserId));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test(
      'should return false when secure storage throws an exception',
      () async {
        // arrange
        when(mockSecureStorage.hasPublicKey(userId: tUserId))
            .thenThrow(Exception('Storage error'));

        // act
        final result = await useCase(tUserId);

        // assert
        expect(result, false);
        verify(mockSecureStorage.hasPublicKey(userId: tUserId));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test(
      'should handle empty userId gracefully',
      () async {
        // arrange
        when(mockSecureStorage.hasPublicKey(userId: ''))
            .thenAnswer((_) async => false);

        // act
        final result = await useCase('');

        // assert
        expect(result, false);
        verify(mockSecureStorage.hasPublicKey(userId: ''));
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );
  });
}
