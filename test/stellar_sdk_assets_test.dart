import 'package:flutter_test/flutter_test.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Stellar SDK 2.0.0 Assets Test', () {
    late StellarSDK sdk;

    setUp(() {
      sdk = StellarSDK.TESTNET;
    });

    test('should get assets from Stellar testnet', () async {
      try {
        print('Testing Stellar SDK 2.0.0 assets endpoint...');

        // Test 1: Basic assets request
        print('1. Testing basic assets request...');
        final response =
            await sdk.assets.order(RequestBuilderOrder.DESC).limit(5).execute();

        print('Response received: ${response != null ? 'NOT NULL' : 'NULL'}');

        if (response != null) {
          print('Records: ${response.records != null ? 'NOT NULL' : 'NULL'}');
          if (response.records != null) {
            print('Records length: ${response.records!.length}');
            if (response.records!.isNotEmpty) {
              print('First asset: ${response.records!.first.assetCode}');
            }
          }
        }

        // Test 2: Try different parameters
        print('\n2. Testing with different parameters...');
        try {
          final response2 = await sdk.assets.execute();
          print('Response2: ${response2 != null ? 'NOT NULL' : 'NULL'}');
        } catch (e) {
          print('Error with basic execute: $e');
        }

        // Test 3: Try with limit only
        print('\n3. Testing with limit only...');
        try {
          final response3 = await sdk.assets.limit(1).execute();
          print('Response3: ${response3 != null ? 'NOT NULL' : 'NULL'}');
        } catch (e) {
          print('Error with limit only: $e');
        }
      } catch (e) {
        print('❌ Error testing assets: $e');
        print('Error type: ${e.runtimeType}');
        if (e.toString().contains('null')) {
          print('Error contains null reference');
        }
      }
    });

    test('should test account endpoint for comparison', () async {
      try {
        print('\nTesting account endpoint for comparison...');

        // Use a known test account
        const testAccount =
            'GBHB3XOW5AWMF4OWL5AQERRN6CZUGI3KZDQZ4AIEU6ULM6EKYPWWLMOA';

        final account = await sdk.accounts.account(testAccount);
        print('Account endpoint works: ${account.accountId}');
        print('Account balances: ${account.balances.length}');
      } catch (e) {
        print('❌ Error testing account endpoint: $e');
      }
    });
  });
}
