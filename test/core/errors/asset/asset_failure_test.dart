import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/core/errors/asset/asset_failure.dart';
import 'package:nemorixpay/core/errors/asset/asset_error_codes.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        asset_failure_test.dart
/// @brief       Tests for AssetFailure class.
/// @details     This file contains tests to verify the correct behavior
///              of the AssetFailure class and its error handling.
/// @author      Miguel Fagundez
/// @date        2025-05-25
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  group('AssetFailure', () {
    test('should create a price update failed failure', () {
      // arrange
      const message = 'Failed to update price';

      // act
      final failure = AssetFailure.priceUpdateFailed(message);

      // assert
      expect(failure.assetMessage, equals(message));
      expect(failure.assetCode, equals(AssetErrorCode.priceUpdateFailed.code));
      expect(failure.message, equals(message));
      expect(failure.code, equals(AssetErrorCode.priceUpdateFailed.code));
    });

    test('should create an invalid price data failure', () {
      // arrange
      const message = 'Invalid price data';

      // act
      final failure = AssetFailure.invalidPriceData(message);

      // assert
      expect(failure.assetMessage, equals(message));
      expect(failure.assetCode, equals(AssetErrorCode.invalidPriceData.code));
      expect(failure.message, equals(message));
      expect(failure.code, equals(AssetErrorCode.invalidPriceData.code));
    });

    test('should create a price history not found failure', () {
      // arrange
      const message = 'Price history not found';

      // act
      final failure = AssetFailure.priceHistoryNotFound(message);

      // assert
      expect(failure.assetMessage, equals(message));
      expect(
        failure.assetCode,
        equals(AssetErrorCode.priceHistoryNotFound.code),
      );
      expect(failure.message, equals(message));
      expect(failure.code, equals(AssetErrorCode.priceHistoryNotFound.code));
    });

    test('should create a network error failure', () {
      // arrange
      const message = 'Network error occurred';

      // act
      final failure = AssetFailure.networkError(message);

      // assert
      expect(failure.assetMessage, equals(message));
      expect(failure.assetCode, equals(AssetErrorCode.networkError.code));
      expect(failure.message, equals(message));
      expect(failure.code, equals(AssetErrorCode.networkError.code));
    });

    test('should create a timeout error failure', () {
      // arrange
      const message = 'Request timed out';

      // act
      final failure = AssetFailure.timeoutError(message);

      // assert
      expect(failure.assetMessage, equals(message));
      expect(failure.assetCode, equals(AssetErrorCode.timeoutError.code));
      expect(failure.message, equals(message));
      expect(failure.code, equals(AssetErrorCode.timeoutError.code));
    });

    test('should create an invalid symbol failure', () {
      // arrange
      const message = 'Invalid symbol';

      // act
      final failure = AssetFailure.invalidSymbol(message);

      // assert
      expect(failure.assetMessage, equals(message));
      expect(failure.assetCode, equals(AssetErrorCode.invalidSymbol.code));
      expect(failure.message, equals(message));
      expect(failure.code, equals(AssetErrorCode.invalidSymbol.code));
    });

    test('should create a data parsing error failure', () {
      // arrange
      const message = 'Failed to parse data';

      // act
      final failure = AssetFailure.dataParsingError(message);

      // assert
      expect(failure.assetMessage, equals(message));
      expect(failure.assetCode, equals(AssetErrorCode.dataParsingError.code));
      expect(failure.message, equals(message));
      expect(failure.code, equals(AssetErrorCode.dataParsingError.code));
    });

    test('should create an unknown error failure', () {
      // arrange
      const message = 'Unknown error occurred';

      // act
      final failure = AssetFailure.unknown(message);

      // assert
      expect(failure.assetMessage, equals(message));
      expect(failure.assetCode, equals(AssetErrorCode.unknown.code));
      expect(failure.message, equals(message));
      expect(failure.code, equals(AssetErrorCode.unknown.code));
    });

    test('should check error type correctly', () {
      // arrange
      final failure = AssetFailure.priceUpdateFailed('test');

      // act & assert
      expect(failure.isErrorType(AssetErrorCode.priceUpdateFailed), isTrue);
      expect(failure.isErrorType(AssetErrorCode.unknown), isFalse);
    });

    testWidgets('should get localized message', (WidgetTester tester) async {
      // arrange
      final failure = AssetFailure.priceUpdateFailed('test');
      final app = MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Text(failure.getLocalizedMessage(context)),
        ),
      );

      // act
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(Text), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.data, isNotNull);
    });
  });
}
