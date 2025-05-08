/// @file        failures.dart
/// @brief       Authentication failure interface for NemorixPay.
/// @details     This abstract defines the contract for app failures, for example, Firebase Auth failures.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class Failure {
  final String message;
  final String code;

  Failure({required this.message, required this.code});
}
