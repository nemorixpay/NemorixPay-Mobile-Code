/// @file        terms_acceptance.dart
/// @brief       Entity representing the acceptance of Terms and Conditions.
/// @details     Contains information about the version and acceptance date of the terms.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class TermsAcceptance {
  final String version;
  final DateTime acceptedAt;
  final bool isAccepted;

  TermsAcceptance({
    required this.version,
    required this.acceptedAt,
    required this.isAccepted,
  });
}
