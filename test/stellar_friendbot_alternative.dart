import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Friendbot Alternative Tests', () {
    late Dio dio;
    late StellarSDK sdk;

    setUp(() {
      dio = Dio();
      sdk = StellarSDK.TESTNET;
    });

    test('should test alternative Friendbot endpoints', () async {
      final keyPair = KeyPair.random();
      final publicKey = keyPair.accountId;

      print('Testing with public key: $publicKey');

      // Test different Friendbot endpoints
      final endpoints = [
        'https://friendbot.stellar.org/?addr=$publicKey',
        'https://friendbot.stellar.org/?addr=$publicKey&amount=10000',
        'https://friendbot.stellar.org/?addr=$publicKey&amount=1000',
      ];

      for (int i = 0; i < endpoints.length; i++) {
        try {
          print('Testing endpoint $i: ${endpoints[i]}');
          final response = await dio.get(endpoints[i]);
          print('  Status: ${response.statusCode}');
          print('  Success!');
          break;
        } catch (e) {
          print('  Failed: $e');
          if (e is DioException) {
            print('    Status: ${e.response?.statusCode}');
            print('    Data: ${e.response?.data}');
          }
        }
      }
    });

    test('should check if Friendbot is accessible', () async {
      try {
        // Try to access Friendbot homepage
        final response = await dio.get('https://friendbot.stellar.org/');
        print('Friendbot homepage status: ${response.statusCode}');
        print('Friendbot homepage accessible: ${response.statusCode == 200}');
      } catch (e) {
        print('Friendbot homepage not accessible: $e');
      }
    });

    test('should test manual account creation', () async {
      try {
        final keyPair = KeyPair.random();
        final publicKey = keyPair.accountId;

        print('Manual account creation test with: $publicKey');

        // Try to create account manually using Stellar SDK
        // This would require funding from an existing account
        print(
            'Note: Manual account creation requires funding from existing account');
        print('This test is for demonstration only');
      } catch (e) {
        print('Error in manual account creation: $e');
      }
    });

    test('should check Stellar testnet status', () async {
      try {
        // Check if testnet is accessible
        final response = await dio.get('https://horizon-testnet.stellar.org/');
        print('Testnet status: ${response.statusCode}');

        if (response.statusCode == 200) {
          print('✅ Testnet is accessible');

          // Try to get some basic info
          final response2 = await dio
              .get('https://horizon-testnet.stellar.org/ledgers?limit=1');
          print('Latest ledger info: ${response2.statusCode}');
        }
      } catch (e) {
        print('❌ Testnet not accessible: $e');
      }
    });
  });
}
