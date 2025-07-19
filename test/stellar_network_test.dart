import 'package:flutter_test/flutter_test.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:dio/dio.dart';

void main() {
  group('Stellar Network Connectivity Tests', () {
    late StellarSDK sdk;
    late Dio dio;

    setUp(() {
      sdk = StellarSDK.TESTNET;
      dio = Dio();
    });

    test('should connect to Stellar testnet server', () async {
      try {
        // Test basic connectivity to Horizon testnet
        final response = await dio.get('https://horizon-testnet.stellar.org/');
        expect(response.statusCode, 200);
        print('✅ Stellar testnet server is accessible');
      } catch (e) {
        print('❌ Cannot connect to Stellar testnet server: $e');
        fail('Cannot connect to Stellar testnet server');
      }
    });

    test('should connect to Friendbot', () async {
      try {
        // Test Friendbot connectivity
        final response = await dio.get('https://friendbot.stellar.org/');
        expect(response.statusCode, 200);
        print('✅ Friendbot is accessible');
      } catch (e) {
        print('❌ Cannot connect to Friendbot: $e');
        fail('Cannot connect to Friendbot');
      }
    });

    test('should create a test account via Friendbot', () async {
      try {
        // Generate a test keypair
        final keyPair = KeyPair.random();
        final publicKey = keyPair.accountId;

        print('Generated test public key: $publicKey');

        // Try to fund the account via Friendbot
        final response =
            await dio.get('https://friendbot.stellar.org/?addr=$publicKey');

        if (response.statusCode == 200) {
          print('✅ Account funded successfully via Friendbot');

          // Wait a moment for the transaction to be processed
          await Future.delayed(Duration(seconds: 2));

          // Try to get the account details
          try {
            final account = await sdk.accounts.account(publicKey);
            print(
                '✅ Account exists on testnet with balance: ${account.balances.firstWhere((b) => b.assetType == 'native').balance} XLM');
          } catch (e) {
            print('❌ Account not found on testnet: $e');
            fail('Account was funded but not found on testnet');
          }
        } else {
          print('❌ Friendbot returned status: ${response.statusCode}');
          print('Response: ${response.data}');
          fail('Friendbot failed to fund account');
        }
      } catch (e) {
        print('❌ Error creating test account: $e');
        fail('Error creating test account: $e');
      }
    });
  });
}
