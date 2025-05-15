import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/features/stellar/data/datasources/stellar_datasource.dart';
import 'package:nemorixpay/features/stellar/domain/entities/stellar_account.dart';
import 'package:nemorixpay/features/stellar/domain/entities/stellar_transaction.dart';
import 'package:nemorixpay/core/errors/stellar_failure.dart';

/// @file        stellar_datasource_test.dart
/// @brief       Unit tests for StellarDatasource implementation.
/// @details     Tests the functionality of mnemonic generation, account creation,
///              account import, balance checking and transaction handling.
/// @author      Miguel Fagundez
/// @date        2025-05-15
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  late StellarDatasource datasource;

  // Test accounts
  const testAccount1Mnemonic =
      'rule topic trick clutch sketch same filter myself material option flee leave';
  const testAccount1SecretSeed =
      'SDQATWWCEQ7IJ65E6GHGZYPQZQFXOUIEGHYYECXLD75Z66DFUVWQ4XUR';
  const testAccount1PublicKey =
      'GCDILZUJ5QR2MYSE4JSNANNKGTRSGOJ7WGMRDCJX6EBEVG6Z4VOVJ5Y4';

  const testAccount2Mnemonic =
      'climb depart hold member earth evoke fat clog birth already fluid ill';
  const testAccount2SecretSeed =
      'SDTGHUGSIIGQZDXWVJEB3TNX4YV74WH3L4FFBFZ6RXHEJWJLRPHC74FJ';
  const testAccount2PublicKey =
      'GDM23BBTRM7ZYLRVKK473RN374WOXP4B7IOQNFMBE7Y4YTDZW6BJZVJG';

  setUp(() {
    datasource = StellarDatasource();
  });

  group('StellarDatasource', () {
    test('should generate valid mnemonic with default strength', () async {
      // Act
      final mnemonic = await datasource.generateMnemonic();

      // Assert
      expect(mnemonic, isNotEmpty);
      expect(mnemonic.length, 24); // Default is 24 words (256 bits)
    });

    test('should generate valid mnemonic with custom strength', () async {
      // Act
      final mnemonic = await datasource.generateMnemonic(strength: 128);

      // Assert
      expect(mnemonic, isNotEmpty);
      expect(mnemonic.length, 12); // 128 bits = 12 words
    });

    test(
      'should throw StellarFailure when importing invalid mnemonic',
      () async {
        // Arrange
        const invalidMnemonic = 'invalid mnemonic phrase';

        // Act & Assert
        expect(
          () => datasource.importAccount(mnemonic: invalidMnemonic),
          throwsA(isA<StellarFailure>()),
        );
      },
    );

    test('should successfully import valid mnemonic', () async {
      // Act
      final account = await datasource.importAccount(
        mnemonic: testAccount1Mnemonic,
      );

      // Assert
      expect(account, isA<StellarAccount>());
      expect(account.publicKey, equals(testAccount1PublicKey));
      expect(account.secretKey, equals(testAccount1SecretSeed));
      expect(account.mnemonic, equals(testAccount1Mnemonic));
    });

    test('should get correct balance for account', () async {
      // Act
      final accountWithBalance = await datasource.getAccountBalance(
        testAccount1PublicKey,
      );

      // Assert
      expect(accountWithBalance, isA<StellarAccount>());
      expect(accountWithBalance.publicKey, equals(testAccount1PublicKey));
      expect(accountWithBalance.balance, isA<double>());
      expect(accountWithBalance.balance, isNonNegative);
    });

    test(
      'should throw StellarFailure when getting balance for invalid account',
      () async {
        // Arrange
        const invalidPublicKey = 'invalid_public_key';

        // Act & Assert
        expect(
          () => datasource.getAccountBalance(invalidPublicKey),
          throwsA(isA<StellarFailure>()),
        );
      },
    );

    test('should successfully send payment', () async {
      // Act
      final transaction = await datasource.sendPayment(
        sourceSecretKey: testAccount1SecretSeed,
        destinationPublicKey: testAccount2PublicKey,
        amount: 1.0,
        memo: 'Test',
      );

      // Assert
      expect(transaction, isA<StellarTransaction>());
      expect(transaction.hash, isNotEmpty);
      expect(transaction.sourceAccount, equals(testAccount1PublicKey));
      expect(transaction.destinationAccount, equals(testAccount2PublicKey));
      expect(transaction.amount, equals(1.0));
      expect(transaction.memo, equals('Test'));
    });

    test(
      'should throw StellarFailure when sending payment with invalid amount',
      () async {
        // Act & Assert
        expect(
          () => datasource.sendPayment(
            sourceSecretKey: testAccount1SecretSeed,
            destinationPublicKey: testAccount2PublicKey,
            amount: -1.0, // Invalid amount
            memo: 'Test',
          ),
          throwsA(isA<StellarFailure>()),
        );
      },
    );

    test(
      'should throw StellarFailure when sending payment with memo too long',
      () async {
        // Act & Assert
        expect(
          () => datasource.sendPayment(
            sourceSecretKey: testAccount1SecretSeed,
            destinationPublicKey: testAccount2PublicKey,
            amount: 1.0,
            memo:
                'This memo is too long and should cause an error', // Memo demasiado largo
          ),
          throwsA(isA<StellarFailure>()),
        );
      },
    );
  });
}
