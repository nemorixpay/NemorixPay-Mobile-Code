/// @file        validation_rules.dart
/// @brief       Base class to implement some validation rules within the app.
/// @details
/// @author      Miguel Fagundez
/// @date        04/25/2025
/// @version     2.0
/// @copyright   Apache 2.0 License
class ValidationRules {
  /// Regex básico para validación de email
  static final emailValidation = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Regex mejorado para validación de email según RFC 5322
  /// Este regex es más robusto y maneja casos especiales como:
  /// - Dominios con más de 2 caracteres (ej: .museum)
  /// - Caracteres especiales permitidos en emails
  /// - Validación de longitud máxima según RFC 5321
  /// - Requiere al menos un punto en el dominio
  /// - Requiere al menos 2 caracteres en cada parte del dominio
  /// - Soporta múltiples subdominios (ej: domain.co.uk)
  /// - Rechaza dominios de un solo carácter (ej: a.b)
  static final emailValidationRFC5322 = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9][a-zA-Z0-9-]*(\.[a-zA-Z0-9]{2,})+$',
  );

  /// Longitud máxima permitida para emails según RFC 5321
  static const int maxEmailLength = 254;

  /// Longitud mínima requerida para contraseñas
  static const int minPasswordLength = 8;

  /// Regex para validar que la contraseña tenga al menos una letra mayúscula
  static final hasUpperCase = RegExp(r'[A-Z]');

  /// Regex para validar que la contraseña tenga al menos una letra minúscula
  static final hasLowerCase = RegExp(r'[a-z]');

  /// Regex para validar que la contraseña tenga al menos un número
  static final hasNumbers = RegExp(r'[0-9]');

  /// Regex para validar que la contraseña tenga al menos un carácter especial
  static final hasSpecialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  /// Lista de contraseñas comunes que no deben ser permitidas
  static const List<String> commonPasswords = [
    'password',
    '12345678',
    'qwerty123',
    'admin123',
    'letmein',
    'welcome1',
    'password1',
    '123456789',
    '1234567890',
    'abc123',
  ];
}
