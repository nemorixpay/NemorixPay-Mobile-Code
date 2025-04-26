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
}
