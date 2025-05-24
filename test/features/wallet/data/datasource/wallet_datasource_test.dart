import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/features/wallet/data/datasources/wallet_datasource_impl.dart';
import 'package:nemorixpay/features/wallet/data/models/wallet_model.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';
import 'package:nemorixpay/core/errors/wallet/wallet_failure.dart';

@GenerateMocks([StellarDataSource])
import 'wallet_datasource_test.mocks.dart';

void main() {
  late WalletDataSourceImpl walletDataSource;
  late MockStellarDataSource mockStellarDataSource;

  setUp(() {
    mockStellarDataSource = MockStellarDataSource();
    walletDataSource = WalletDataSourceImpl(
      stellarDatasource: mockStellarDataSource,
    );
  });

  group('WalletDataSource', () {
    test('should create wallet successfully', () async {
      // Arrange
      const mnemonic = 'test mnemonic phrase';
      const publicKey = 'test_public_key';
      const secretKey = 'test_secret_key';
      const balance = 100.0;

      when(
        mockStellarDataSource.generateMnemonic(),
      ).thenAnswer((_) async => mnemonic.split(' '));
      when(mockStellarDataSource.createAccount(mnemonic: mnemonic)).thenAnswer(
        (_) async => StellarAccountModel(
          publicKey: publicKey,
          secretKey: secretKey,
          balance: balance,
          mnemonic: mnemonic,
          createdAt: DateTime.now(),
        ),
      );

      // Act
      final result = await walletDataSource.createWallet(mnemonic);

      // Assert
      expect(result, isA<WalletModel>());
      expect(result.publicKey, equals(publicKey));
      expect(result.secretKey, equals(secretKey));
      expect(result.balance, equals(balance));
      expect(result.mnemonic, equals(mnemonic));
      expect(result.createdAt, isA<DateTime>());
    });

    test('should import wallet successfully', () async {
      // Arrange
      const mnemonic = 'test mnemonic phrase';
      const publicKey = 'test_public_key';
      const secretKey = 'test_secret_key';
      const balance = 100.0;

      when(mockStellarDataSource.importAccount(mnemonic: mnemonic)).thenAnswer(
        (_) async => StellarAccountModel(
          publicKey: publicKey,
          secretKey: secretKey,
          balance: balance,
          mnemonic: mnemonic,
          createdAt: DateTime.now(),
        ),
      );

      // Act
      final result = await walletDataSource.importWallet(mnemonic);

      // Assert
      expect(result, isA<WalletModel>());
      expect(result.publicKey, equals(publicKey));
      expect(result.secretKey, equals(secretKey));
      expect(result.balance, equals(balance));
      expect(result.mnemonic, equals(mnemonic));
      expect(result.createdAt, isA<DateTime>());
    });

    test(
      'should throw WalletFailure when importing invalid mnemonic',
      () async {
        // Arrange
        const mnemonic = 'invalid mnemonic';

        when(
          mockStellarDataSource.importAccount(mnemonic: mnemonic),
        ).thenThrow(Exception('invalid mnemonic'));

        // Act & Assert
        expect(
          () => walletDataSource.importWallet(mnemonic),
          throwsA(isA<WalletFailure>()),
        );
      },
    );

    test('should get wallet balance successfully', () async {
      // Arrange
      const publicKey = 'test_public_key';
      const balance = 100.0;

      when(
        mockStellarDataSource.getAccountBalance(publicKey),
      ).thenAnswer((_) async => balance);

      // Act
      final result = await walletDataSource.getWalletBalance(publicKey);

      // Assert
      expect(result, equals(balance));
    });

    test(
      'should throw WalletFailure when getting balance for invalid account',
      () async {
        // Arrange
        const publicKey = 'invalid_public_key';

        when(
          mockStellarDataSource.getAccountBalance(publicKey),
        ).thenThrow(Exception('account not found'));

        // Act & Assert
        expect(
          () => walletDataSource.getWalletBalance(publicKey),
          throwsA(isA<WalletFailure>()),
        );
      },
    );
  });
}
