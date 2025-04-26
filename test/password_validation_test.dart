import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';

void main() {
  group('Password Validation Tests', () {
    test('Should reject passwords that are too short', () {
      final shortPasswords = [
        '',
        'a',
        'ab',
        'abc',
        'abcd',
        'abcde',
        'abcdef',
        'abcdefg',
      ];

      for (final password in shortPasswords) {
        expect(
          password.length >= ValidationRules.minPasswordLength,
          false,
          reason: 'Password "$password" should be rejected for being too short',
        );
      }
    });

    test('Should reject passwords without uppercase letters', () {
      final passwords = [
        'password123!',
        'abcdefgh1!',
        '12345678!',
        r'!@#$%^&*()',
      ];

      for (final password in passwords) {
        expect(
          ValidationRules.hasUpperCase.hasMatch(password),
          false,
          reason:
              'Password "$password" should be rejected for missing uppercase',
        );
      }
    });

    test('Should reject passwords without lowercase letters', () {
      final passwords = [
        'PASSWORD123!',
        'ABCDEFGH1!',
        '12345678!',
        r'!@#$%^&*()',
      ];

      for (final password in passwords) {
        expect(
          ValidationRules.hasLowerCase.hasMatch(password),
          false,
          reason:
              'Password "$password" should be rejected for missing lowercase',
        );
      }
    });

    test('Should reject passwords without numbers', () {
      final passwords = ['Password!', 'Abcdefgh!', r'!@#$%^&*()', 'ABCDEFGH!'];

      for (final password in passwords) {
        expect(
          ValidationRules.hasNumbers.hasMatch(password),
          false,
          reason: 'Password "$password" should be rejected for missing numbers',
        );
      }
    });

    test('Should reject passwords without special characters', () {
      final passwords = ['Password123', 'Abcdefgh1', '12345678', 'ABCDEFGH1'];

      for (final password in passwords) {
        expect(
          ValidationRules.hasSpecialChars.hasMatch(password),
          false,
          reason:
              'Password "$password" should be rejected for missing special chars',
        );
      }
    });

    test('Should reject common passwords', () {
      for (final password in ValidationRules.commonPasswords) {
        expect(
          ValidationRules.commonPasswords.contains(password),
          true,
          reason:
              'Password "$password" should be rejected for being too common',
        );
      }
    });

    test('Should accept valid passwords', () {
      final validPasswords = [
        'Password123!',
        'Abcdefgh1!',
        'Test123A!',
        r'Complex1@Pass',
        'P@ssw0rd123',
        'Str0ngP@ssword',
        'C0mpl3xP@ssword',
      ];

      for (final password in validPasswords) {
        expect(
          password.length >= ValidationRules.minPasswordLength,
          true,
          reason: 'Password "$password" should meet length requirement',
        );
        expect(
          ValidationRules.hasUpperCase.hasMatch(password),
          true,
          reason: 'Password "$password" should have uppercase',
        );
        expect(
          ValidationRules.hasLowerCase.hasMatch(password),
          true,
          reason: 'Password "$password" should have lowercase',
        );
        expect(
          ValidationRules.hasNumbers.hasMatch(password),
          true,
          reason: 'Password "$password" should have numbers',
        );
        expect(
          ValidationRules.hasSpecialChars.hasMatch(password),
          true,
          reason: 'Password "$password" should have special chars',
        );
        expect(
          ValidationRules.commonPasswords.contains(password),
          false,
          reason: 'Password "$password" should not be in common passwords list',
        );
      }
    });
  });
}
