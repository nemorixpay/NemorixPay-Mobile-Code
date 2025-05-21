import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_transaction_model.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_transaction.dart';

/// @file        stellar_transaction_model_test.dart
/// @brief       Tests for the StellarTransactionModel class.
/// @details     This file contains tests for the StellarTransactionModel class,
///              including serialization, deserialization, and entity mapping.
/// @author      Miguel Fagundez
/// @date        2025-05-20
/// @version     1.0
/// @copyright   Apache 2.0 License

void main() {
  group('StellarTransactionModel', () {
    final tTransactionModel = StellarTransactionModel(
      hash: 'test_hash',
      sourceAccount: 'source_account',
      destinationAccount: 'destination_account',
      amount: 100.0,
      memo: 'test memo',
      successful: true,
      ledger: 12345,
      createdAt: DateTime.parse('2025-05-20T10:00:00Z'),
      feeCharged: '0.00001',
    );

    test('should be a subclass of StellarTransactionModel', () {
      expect(tTransactionModel, isA<StellarTransactionModel>());
    });

    test('should create a valid model from JSON', () {
      // arrange
      final json = {
        'hash': 'test_hash',
        'sourceAccount': 'source_account',
        'destinationAccount': 'destination_account',
        'amount': 100.0,
        'memo': 'test memo',
        'successful': true,
        'ledger': 12345,
        'createdAt': '2025-05-20T10:00:00Z',
        'feeCharged': '0.00001',
      };

      // act
      final result = StellarTransactionModel.fromJson(json);

      // assert
      expect(result, equals(tTransactionModel));
    });

    test('should convert model to JSON', () {
      // act
      final result = tTransactionModel.toJson();

      // assert
      expect(result, {
        'hash': 'test_hash',
        'sourceAccount': 'source_account',
        'destinationAccount': 'destination_account',
        'amount': 100.0,
        'memo': 'test memo',
        'successful': true,
        'ledger': 12345,
        'createdAt': '2025-05-20T10:00:00Z',
        'feeCharged': '0.00001',
      });
    });

    test('should convert model to entity', () {
      // act
      final result = tTransactionModel.toEntity();

      // assert
      expect(result, isA<StellarTransaction>());
      expect(result.hash, equals('test_hash'));
      expect(result.sourceAccount, equals('source_account'));
      expect(result.destinationAccount, equals('destination_account'));
      expect(result.amount, equals(100.0));
      expect(result.memo, equals('test memo'));
      expect(result.successful, isTrue);
      expect(result.ledger, equals(12345));
      expect(result.createdAt, equals(DateTime.parse('2025-05-20T10:00:00Z')));
      expect(result.feeCharged, equals('0.00001'));
    });

    test('should handle null memo and ledger in JSON', () {
      // arrange
      final json = {
        'hash': 'test_hash',
        'sourceAccount': 'source_account',
        'destinationAccount': 'destination_account',
        'amount': 100.0,
        'memo': null,
        'successful': true,
        'ledger': null,
        'createdAt': '2025-05-20T10:00:00Z',
        'feeCharged': '0.00001',
      };

      // act
      final result = StellarTransactionModel.fromJson(json);

      // assert
      expect(result.memo, isNull);
      expect(result.ledger, isNull);
    });

    test('should handle null memo and ledger in toJson', () {
      // arrange
      final model = StellarTransactionModel(
        hash: 'test_hash',
        sourceAccount: 'source_account',
        destinationAccount: 'destination_account',
        amount: 100.0,
        memo: null,
        successful: true,
        ledger: null,
        createdAt: DateTime.parse('2025-05-20T10:00:00Z'),
        feeCharged: '0.00001',
      );

      // act
      final result = model.toJson();

      // assert
      expect(result['memo'], isNull);
      expect(result['ledger'], isNull);
    });
  });
}
