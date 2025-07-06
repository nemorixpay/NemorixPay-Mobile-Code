import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/features/terms/data/datasources/terms_local_datasource_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @file        terms_local_datasource_test.dart
/// @brief       Unit tests for TermsLocalDatasource.
/// @details     Tests the local storage functionality for terms acceptance using SharedPreferences.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  group('TermsLocalDatasource', () {
    late TermsLocalDatasourceImpl datasource;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      datasource = TermsLocalDatasourceImpl();
    });

    group('isTermsAccepted', () {
      test('should return false when terms are not accepted', () async {
        final result = await datasource.isTermsAccepted();
        expect(result, false);
      });

      test(
        'should return true when terms are accepted with current version',
        () async {
          await prefs.setBool('terms_accepted', true);
          await prefs.setString('terms_version', '1.0');

          final result = await datasource.isTermsAccepted();
          expect(result, true);
        },
      );

      test(
        'should return false when terms are accepted but with old version',
        () async {
          await prefs.setBool('terms_accepted', true);
          await prefs.setString('terms_version', '0.9');

          final result = await datasource.isTermsAccepted();
          expect(result, false);
        },
      );
    });

    group('saveTermsAcceptance', () {
      test('should save terms acceptance correctly', () async {
        final version = '1.0';
        final acceptedAt = DateTime(2025, 2, 7, 10, 30);

        await datasource.saveTermsAcceptance(version, acceptedAt);

        expect(prefs.getBool('terms_accepted'), true);
        expect(prefs.getString('terms_version'), version);
        expect(
          prefs.getString('terms_accepted_at'),
          acceptedAt.toIso8601String(),
        );
      });
    });

    group('getTermsAcceptance', () {
      test('should return not accepted model when no data exists', () async {
        final result = await datasource.getTermsAcceptance();

        expect(result.isAccepted, false);
        expect(result.version, '');
        expect(result.acceptedAt, null);
      });

      test('should return accepted model when data exists', () async {
        final version = '1.0';
        final acceptedAt = DateTime(2025, 2, 7, 10, 30);

        await prefs.setBool('terms_accepted', true);
        await prefs.setString('terms_version', version);
        await prefs.setString(
          'terms_accepted_at',
          acceptedAt.toIso8601String(),
        );

        final result = await datasource.getTermsAcceptance();

        expect(result.isAccepted, true);
        expect(result.version, version);
        expect(result.acceptedAt, acceptedAt);
      });
    });

    group('clearTermsAcceptance', () {
      test('should clear all terms acceptance data', () async {
        // First save some data
        await prefs.setBool('terms_accepted', true);
        await prefs.setString('terms_version', '1.0');
        await prefs.setString(
          'terms_accepted_at',
          DateTime.now().toIso8601String(),
        );

        // Clear the data
        await datasource.clearTermsAcceptance();

        // Verify data is cleared
        expect(prefs.getBool('terms_accepted'), null);
        expect(prefs.getString('terms_version'), null);
        expect(prefs.getString('terms_accepted_at'), null);
      });
    });

    group('currentTermsVersion', () {
      test('should return current terms version', () {
        expect(datasource.currentTermsVersion, '1.0');
      });
    });
  });
}
