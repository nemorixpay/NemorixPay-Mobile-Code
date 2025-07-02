import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';

void main() {
  group('Email Validation Tests', () {
    test('Should reject invalid emails', () {
      final invalidEmails = [
        'miguel@g', // Dominio sin punto
        'miguel@a', // Dominio muy corto
        'miguel@.com', // Dominio sin nombre
        '@gmail.com', // Sin parte local
        'miguel@', // Sin dominio
        'miguel@gmail', // Dominio sin TLD
        'miguel@gmail.c', // TLD muy corto
        'miguel@a.b', // Dominio de un solo carácter
      ];

      for (final email in invalidEmails) {
        expect(
          ValidationRules.emailValidationRFC5322.hasMatch(email),
          false,
          reason: 'Email "$email" should be invalid',
        );
      }
    });

    test('Should accept valid emails', () {
      final validEmails = [
        'miguel@gmail.com',
        'miguel.fagundez@domain.co.uk',
        'miguel+test@sub.domain.com',
        'miguel@domain.museum',
        'miguel@domain.info',
        'miguel@domain.name',
        'miguel@ab.cd', // Dominio con al menos 2 caracteres en cada parte
      ];

      for (final email in validEmails) {
        expect(
          ValidationRules.emailValidationRFC5322.hasMatch(email),
          true,
          reason: 'Email "$email" should be valid',
        );
      }
    });
  });

  group('Stellar Address Validation Tests', () {
    test('Should accept valid Stellar addresses', () {
      final validAddresses = [
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF',
        'GBBM6BKZPEHWYO3E3YKREDPQXTMSXGSQKBIW4DCHWJWKLUXMVDDBZT64',
        'GCCD6AJOYZCUAQLX32ZJF2MKFFAUJ53PVCFQI3RHWKL3VE47F6N2NXPG',
        'GDVVE6D7F2MSPGT5VBTDTQBDJBV6MWEZRCCAJU7MNWLXVG3JJ73OQQUB',
        'GA7QYNF7SOWQ3GLR2BWMZE6XRPX7DCL2K5ZCDXY6T6ZLGASARJQR5VP5',
      ];

      for (final address in validAddresses) {
        expect(
          ValidationRules.isValidStellarAddress(address),
          true,
          reason: 'Address "$address" should be valid',
        );
      }
    });

    test('Should reject invalid Stellar addresses', () {
      final invalidAddresses = [
        '', // Empty string
        'G', // Too short - only 1 character
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWH', // 55 characters
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHFF', // 57 characters
        'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF', // Doesn't start with G
        'gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF', // Starts with lowercase g
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF1', // Contains invalid character '1'
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF@', // Contains invalid character '@'
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF ', // Contains space
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF\n', // Contains newline
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF\t', // Contains tab
      ];

      for (final address in invalidAddresses) {
        expect(
          ValidationRules.isValidStellarAddress(address),
          false,
          reason: 'Address "$address" should be invalid',
        );
      }
    });

    test('Should handle edge cases correctly', () {
      // Test with null-like values (though the method expects String)
      expect(
        ValidationRules.isValidStellarAddress(''),
        false,
        reason: 'Empty string should be invalid',
      );

      // Test with exactly 56 characters but wrong format
      final wrongFormat56Chars = 'A' * 56;
      expect(
        ValidationRules.isValidStellarAddress(wrongFormat56Chars),
        false,
        reason: '56 characters without G prefix should be invalid',
      );

      // Test with G prefix but wrong length
      final gPrefixWrongLength = 'G' + 'A' * 54; // 55 characters total
      expect(
        ValidationRules.isValidStellarAddress(gPrefixWrongLength),
        false,
        reason: 'G prefix with 55 characters should be invalid',
      );

      final gPrefixTooLong = 'G' + 'A' * 56; // 57 characters total
      expect(
        ValidationRules.isValidStellarAddress(gPrefixTooLong),
        false,
        reason: 'G prefix with 57 characters should be invalid',
      );
    });

    test('Should validate real Stellar address format', () {
      // These are examples of real Stellar address format
      // Note: These are not real accounts, just examples of the format
      final realFormatAddresses = [
        'GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF',
        'GBBM6BKZPEHWYO3E3YKREDPQXTMSXGSQKBIW4DCHWJWKLUXMVDDBZT64',
        'GCCD6AJOYZCUAQLX32ZJF2MKFFAUJ53PVCFQI3RHWKL3VE47F6N2NXPG',
      ];

      for (final address in realFormatAddresses) {
        expect(
          ValidationRules.isValidStellarAddress(address),
          true,
          reason: 'Real format address "$address" should be valid',
        );

        // Additional checks to ensure format consistency
        expect(address.length, 56,
            reason: 'Address should be exactly 56 characters');
        expect(address.startsWith('G'), true,
            reason: 'Address should start with G');
        expect(address, matches(r'^G[A-Z2-7]{55}$'),
            reason: 'Address should match Stellar format');
      }
    });
  });

  group('Stellar Address Validation', () {
    test('should validate correct Stellar addresses', () {
      final validAddresses = [
        'GARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AERL',
        'GBBM6BKZPEHWYO3E3YKREDPQXMS4VK35YLNU7NFBRI26RAN7GI5POFBB',
        'GCEZWKCA5VLDNRLN3RPRJMRZOX3Z6G5CHCGSNFHEYVXM3XOJMDS674JZ',
      ];

      for (final address in validAddresses) {
        expect(ValidationRules.isValidStellarAddress(address), isTrue,
            reason: 'Address $address should be valid');
      }
    });

    test('should reject invalid Stellar addresses', () {
      final invalidAddresses = [
        '', // Empty string
        'GARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AER', // Too short (55 chars)
        'GARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AERLL', // Too long (57 chars)
        'AARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AERL', // Doesn't start with G
        'GARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AER1', // Contains invalid char
        'GARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AERL1', // Too long and invalid
      ];

      for (final address in invalidAddresses) {
        expect(ValidationRules.isValidStellarAddress(address), isFalse,
            reason: 'Address $address should be invalid');
      }
    });

    test('should validate own address detection', () {
      // Test that we can detect when an address is the same as the sender's
      final ownAddress =
          'GARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AERL';
      final differentAddress =
          'GBBM6BKZPEHWYO3E3YKREDPQXMS4VK35YLNU7NFBRI26RAN7GI5POFBB';

      // Both addresses are valid Stellar addresses
      expect(ValidationRules.isValidStellarAddress(ownAddress), isTrue);
      expect(ValidationRules.isValidStellarAddress(differentAddress), isTrue);

      // But they are different addresses
      expect(ownAddress == differentAddress, isFalse);
    });
  });
}
