import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/core/errors/firebase_error_codes.dart';
import 'package:nemorixpay/core/errors/firebase_failure.dart';

void main() {
  group('FirebaseFailure Tests', () {
    test('should create failure with provided message and code', () {
      // Arrange
      const message = 'Test error message';
      const code = 'test-error-code';

      // Act
      final failure = FirebaseFailure(
        firebaseMessage: message,
        firebaseCode: code,
      );

      // Assert
      expect(failure.firebaseMessage, equals(message));
      expect(failure.firebaseCode, equals(code));
      expect(failure.message, equals(message));
      expect(failure.code, equals(code));
    });

    test('should correctly identify error type', () {
      // Arrange
      final failure = FirebaseFailure(
        firebaseMessage: 'Test message',
        firebaseCode: 'user-not-found',
      );

      // Act & Assert
      expect(failure.isErrorType(FirebaseErrorCode.userNotFound), isTrue);
      expect(failure.isErrorType(FirebaseErrorCode.wrongPassword), isFalse);
    });

    test('should handle FirebaseAuthException code', () {
      // Arrange
      final exception = FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found',
      );

      // Act & Assert
      expect(exception.code, equals('user-not-found'));
      expect(FirebaseErrorCode.isValidCode(exception.code), isTrue);
    });

    test('should handle unknown error code', () {
      // Arrange & Act
      final isValid = FirebaseErrorCode.isValidCode('non-existent-code');

      // Assert
      expect(isValid, isFalse);
    });
  });
}
