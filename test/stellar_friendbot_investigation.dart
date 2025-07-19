import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Friendbot Investigation', () {
    late Dio dio;
    late StellarSDK sdk;

    setUp(() {
      dio = Dio();
      sdk = StellarSDK.TESTNET;
    });

    test('should investigate Friendbot error 400', () async {
      try {
        // Generate a new keypair
        final keyPair = KeyPair.random();
        final publicKey = keyPair.accountId;

        print('Testing with public key: $publicKey');

        // First, check if the account already exists
        try {
          final account = await sdk.accounts.account(publicKey);
          print(
              '❌ Account already exists with balance: ${account.balances.firstWhere((b) => b.assetType == 'native').balance} XLM');
          return; // Skip this test if account already exists
        } catch (e) {
          print('✅ Account does not exist yet (expected)');
        }

        // Try to fund the account
        final url = 'https://friendbot.stellar.org/?addr=$publicKey';
        print('Requesting funding from: $url');

        final response = await dio.get(url);
        print('Response status: ${response.statusCode}');
        print('Response data: ${response.data}');

        if (response.statusCode == 200) {
          print('✅ Account funded successfully');

          // Wait and verify
          await Future.delayed(Duration(seconds: 3));

          try {
            final account = await sdk.accounts.account(publicKey);
            final balance = account.balances
                .firstWhere((b) => b.assetType == 'native')
                .balance;
            print('✅ Account verified with balance: $balance XLM');
          } catch (e) {
            print('❌ Account not found after funding: $e');
          }
        } else {
          print('❌ Friendbot failed with status: ${response.statusCode}');
          print('Response: ${response.data}');
        }
      } catch (e) {
        print('❌ Error: $e');
        if (e is DioException) {
          print('DioException details:');
          print('  Status: ${e.response?.statusCode}');
          print('  Data: ${e.response?.data}');
          print('  Headers: ${e.response?.headers}');
        }
      }
    });

    test('should check rate limiting', () async {
      // Try to create multiple accounts quickly to see if there's rate limiting
      for (int i = 0; i < 3; i++) {
        try {
          final keyPair = KeyPair.random();
          final publicKey = keyPair.accountId;

          print('Attempt $i - Public key: $publicKey');

          final response =
              await dio.get('https://friendbot.stellar.org/?addr=$publicKey');
          print('  Status: ${response.statusCode}');

          if (response.statusCode == 200) {
            print('  ✅ Success');
          } else {
            print('  ❌ Failed: ${response.data}');
          }

          // Wait between requests
          await Future.delayed(Duration(seconds: 2));
        } catch (e) {
          print('  ❌ Error: $e');
        }
      }
    });

    test('should check if specific account exists', () async {
      // Check a specific account that was mentioned in the logs
      const testPublicKey =
          'GDVVWNJKMLXF2CQMIZ3AAXWMYLZN2WUZSGBJLX5MEWJ5K7TYZDNLSJZQ';

      try {
        final account = await sdk.accounts.account(testPublicKey);
        final balance =
            account.balances.firstWhere((b) => b.assetType == 'native').balance;
        print('✅ Account $testPublicKey exists with balance: $balance XLM');
      } catch (e) {
        print('❌ Account $testPublicKey does not exist: $e');
      }
    });
  });
}
