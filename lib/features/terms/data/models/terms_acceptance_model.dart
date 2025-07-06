/// @file        terms_acceptance_model.dart
/// @brief       Model for storing terms and conditions acceptance data.
/// @details     Contains information about when and which version of terms
///              the user has accepted. Used for local storage with SharedPreferences.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TermsAcceptanceModel {
  /// Whether the user has accepted the terms and conditions
  final bool isAccepted;

  /// Version of the terms that were accepted
  final String version;

  /// Date and time when the terms were accepted (null if not accepted)
  final DateTime? acceptedAt;

  const TermsAcceptanceModel({
    required this.isAccepted,
    required this.version,
    this.acceptedAt,
  });

  /// Creates a default model for when terms haven't been accepted
  factory TermsAcceptanceModel.notAccepted() {
    return const TermsAcceptanceModel(
      isAccepted: false,
      version: '',
    );
  }

  /// Creates a model for accepted terms
  factory TermsAcceptanceModel.accepted({
    required String version,
    required DateTime acceptedAt,
  }) {
    return TermsAcceptanceModel(
      isAccepted: true,
      version: version,
      acceptedAt: acceptedAt,
    );
  }

  /// Converts the model to a Map for SharedPreferences storage
  Map<String, dynamic> toJson() {
    return {
      'isAccepted': isAccepted,
      'version': version,
      'acceptedAt': acceptedAt?.toIso8601String(),
    };
  }

  /// Creates a model from a Map (from SharedPreferences)
  factory TermsAcceptanceModel.fromJson(Map<String, dynamic> json) {
    return TermsAcceptanceModel(
      isAccepted: json['isAccepted'] ?? false,
      version: json['version'] ?? '',
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.parse(json['acceptedAt'])
          : null,
    );
  }

  @override
  String toString() {
    return 'TermsAcceptanceModel(isAccepted: $isAccepted, version: $version, acceptedAt: $acceptedAt)';
  }
}
