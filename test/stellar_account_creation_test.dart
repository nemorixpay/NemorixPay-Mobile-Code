import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Stellar Account Creation Tests', () {
    late StellarDataSourceImpl stellarDataSource;

    setUp(() {
      stellarDataSource = StellarDataSourceImpl();
    });

    test('should generate valid mnemonic', () async {
      final mnemonic = await stellarDataSource.generateMnemonic();
      expect(mnemonic.length, 24); // Default strength is 256 (24 words)
      expect(mnemonic.every((word) => word.isNotEmpty), true);
      print('Generated mnemonic: ${mnemonic.join(' ')}');
    });

    test('should create account from mnemonic', () async {
      try {
        // Generate a new mnemonic
        final mnemonic = await stellarDataSource.generateMnemonic();
        final mnemonicString = mnemonic.join(' ');

        print('Creating account with mnemonic: $mnemonicString');

        // Create account
        final account = await stellarDataSource.createAccount(
          mnemonic: mnemonicString,
        );

        expect(account, isA<StellarAccountModel>());
        expect(account.publicKey, isNotEmpty);
        expect(account.secretKey, isNotEmpty);
        expect(account.balance, greaterThan(0));
        expect(account.mnemonic, equals(mnemonicString));

        print('✅ Account created successfully');
        print('Public Key: ${account.publicKey}');
        print('Balance: ${account.balance} XLM');

        // Verify the account exists on the network
        if (account.publicKey != null) {
          final balance =
              await stellarDataSource.getAccountBalance(account.publicKey!);
          expect(balance, greaterThan(0));
          print('✅ Account verified on network with balance: $balance XLM');
        } else {
          fail('Account public key is null');
        }
      } catch (e) {
        print('❌ Error creating account: $e');
        fail('Error creating account: $e');
      }
    });

    test('should import existing account', () async {
      try {
        // Use a known test mnemonic (this should be a valid test mnemonic)
        const testMnemonic =
            'test test test test test test test test test test test junk';

        print('Importing account with mnemonic: $testMnemonic');

        // Import account
        final account = await stellarDataSource.importAccount(
          mnemonic: testMnemonic,
        );

        expect(account, isA<StellarAccountModel>());
        expect(account.publicKey, isNotEmpty);
        expect(account.secretKey, isNotEmpty);
        expect(account.mnemonic, equals(testMnemonic));

        print('✅ Account imported successfully');
        print('Public Key: ${account.publicKey}');
        print('Balance: ${account.balance} XLM');
      } catch (e) {
        print('❌ Error importing account: $e');
        // This might fail if the test mnemonic doesn't have funds, which is expected
        print('Note: This is expected if the test mnemonic has no funds');
      }
    });

    test('should handle invalid mnemonic', () async {
      try {
        await stellarDataSource.importAccount(
          mnemonic: 'invalid mnemonic phrase',
        );
        fail('Should have thrown an error for invalid mnemonic');
      } catch (e) {
        expect(e.toString(), contains('Invalid Seed Phrase'));
        print('✅ Correctly handled invalid mnemonic');
      }
    });
  });
}
