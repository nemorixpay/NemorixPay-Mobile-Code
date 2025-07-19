import 'package:flutter_test/flutter_test.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Stellar Assets Alternative Methods Test', () {
    late StellarSDK sdk;

    setUp(() {
      sdk = StellarSDK.TESTNET;
    });

    test('should test different methods to get assets', () async {
      try {
        print('Testing different methods to get assets...');

        // Method 1: Basic assets endpoint (current method)
        print('\n1. Testing basic assets endpoint...');
        try {
          final assetsResponse = await sdk.assets.execute();
          print(
              'Assets response: ${assetsResponse != null ? 'NOT NULL' : 'NULL'}');
          if (assetsResponse != null && assetsResponse.records != null) {
            print('Assets count: ${assetsResponse.records!.length}');
          }
        } catch (e) {
          print('Error with basic assets: $e');
        }

        // Method 2: Assets with limit
        print('\n2. Testing assets with limit...');
        try {
          final assetsWithLimit = await sdk.assets.limit(5).execute();
          print(
              'Assets with limit: ${assetsWithLimit != null ? 'NOT NULL' : 'NULL'}');
        } catch (e) {
          print('Error with assets limit: $e');
        }

        // Method 3: Assets with order
        print('\n3. Testing assets with order...');
        try {
          final assetsWithOrder =
              await sdk.assets.order(RequestBuilderOrder.ASC).execute();
          print(
              'Assets with order: ${assetsWithOrder != null ? 'NOT NULL' : 'NULL'}');
        } catch (e) {
          print('Error with assets order: $e');
        }

        // Method 4: Get account and check balances
        print('\n4. Testing account balances...');
        try {
          const testAccount =
              'GBHB3XOW5AWMF4OWL5AQERRN6CZUGI3KZDQZ4AIEU6ULM6EKYPWWLMOA';
          final account = await sdk.accounts.account(testAccount);
          print('Account balances count: ${account.balances.length}');
          for (var balance in account.balances) {
            print(
                '  - Asset: ${balance.assetCode ?? 'XLM'}, Balance: ${balance.balance}');
          }
        } catch (e) {
          print('Error with account balances: $e');
        }

        // Method 5: Try to get specific asset
        print('\n5. Testing specific asset...');
        try {
          // Try to get XLM (native asset) information
          final nativeAsset = await sdk.assets.assetCode('XLM').execute();
          print('Native asset: ${nativeAsset != null ? 'NOT NULL' : 'NULL'}');
        } catch (e) {
          print('Error with specific asset: $e');
        }

        // Method 6: Try to get assets by issuer
        print('\n6. Testing assets by issuer...');
        try {
          // Try to get assets by a known issuer
          final assetsByIssuer = await sdk.assets
              .assetIssuer(
                  'GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7')
              .execute();
          print(
              'Assets by issuer: ${assetsByIssuer != null ? 'NOT NULL' : 'NULL'}');
        } catch (e) {
          print('Error with assets by issuer: $e');
        }
      } catch (e) {
        print('❌ General error: $e');
      }
    });

    test('should test direct HTTP call to compare', () async {
      try {
        print('\nTesting direct HTTP call to Horizon...');

        // Test direct HTTP call to see if the API works
        final response = await sdk.accounts.account(
            'GBHB3XOW5AWMF4OWL5AQERRN6CZUGI3KZDQZ4AIEU6ULM6EKYPWWLMOA');
        print('Direct account call works: ${response.accountId}');

        // Try to get some basic info about the network
        print('Account sequence: ${response.sequenceNumber}');
        print('Account balances: ${response.balances.length}');
      } catch (e) {
        print('❌ Error with direct call: $e');
      }
    });
  });
}
