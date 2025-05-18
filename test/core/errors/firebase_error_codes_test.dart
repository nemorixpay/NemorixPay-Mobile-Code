import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/core/errors/auth/firebase_error_codes.dart';

void main() {
  group('FirebaseErrorCode Tests', () {
    test('should validate existing error codes', () {
      // Arrange
      const validCode = 'user-not-found';
      const invalidCode = 'invalid-code';

      // Act & Assert
      expect(FirebaseErrorCode.isValidCode(validCode), isTrue);
      expect(FirebaseErrorCode.isValidCode(invalidCode), isFalse);
    });

    test('should return correct error code for enum values', () {
      // Test that all enum values have corresponding codes
      for (final errorCode in FirebaseErrorCode.values) {
        // Act & Assert
        expect(errorCode.code, isNotNull);
        expect(errorCode.code, isNotEmpty);
      }
    });

    test('should have unique error codes', () {
      // Get all error codes
      final codes = FirebaseErrorCode.values.map((e) => e.code).toList();

      // Check for duplicates
      final uniqueCodes = codes.toSet();
      expect(
        codes.length,
        equals(uniqueCodes.length),
        reason: 'All error codes should be unique',
      );
    });

    test('should have consistent error code format', () {
      // Check that all error codes follow the same format
      for (final errorCode in FirebaseErrorCode.values) {
        // Act & Assert
        expect(
          errorCode.code,
          matches(RegExp(r'^[a-z-]+$')),
          reason: 'Error codes should be lowercase with hyphens',
        );
      }
    });
  });
}
