/// @file        didit_session_decision_model.dart
/// @brief       Model for Didit API session decision/status response
/// @details     Represents the response from checking session status and decision
/// @author      Miguel Fagundez
/// @date        08/04/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'package:json_annotation/json_annotation.dart';

part 'didit_session_decision_model.g.dart';

@JsonSerializable()
class DiditSessionDecisionModel {
  /// Session identifier
  @JsonKey(name: 'session_id')
  final String sessionId;

  /// Current status of the session
  @JsonKey(name: 'status')
  final String status;

  /// Final decision of the verification
  @JsonKey(name: 'decision')
  final String? decision;

  /// Confidence score of the verification
  @JsonKey(name: 'confidence')
  final double? confidence;

  /// Session completion timestamp
  @JsonKey(name: 'completed_at')
  final String? completedAt;

  /// Session expiration timestamp
  @JsonKey(name: 'expires_at')
  final String? expiresAt;

  /// Verification results and details
  @JsonKey(name: 'results')
  final Map<String, dynamic>? results;

  /// Error message if verification failed
  @JsonKey(name: 'error_message')
  final String? errorMessage;

  /// Error code if verification failed
  @JsonKey(name: 'error_code')
  final String? errorCode;

  /// Vendor data associated with the session
  @JsonKey(name: 'vendor_data')
  final String? vendorData;

  const DiditSessionDecisionModel({
    required this.sessionId,
    required this.status,
    this.decision,
    this.confidence,
    this.completedAt,
    this.expiresAt,
    this.results,
    this.errorMessage,
    this.errorCode,
    this.vendorData,
  });

  /// Create a copy of this decision with updated fields
  DiditSessionDecisionModel copyWith({
    String? sessionId,
    String? status,
    String? decision,
    double? confidence,
    String? completedAt,
    String? expiresAt,
    Map<String, dynamic>? results,
    String? errorMessage,
    String? errorCode,
    String? vendorData,
  }) {
    return DiditSessionDecisionModel(
      sessionId: sessionId ?? this.sessionId,
      status: status ?? this.status,
      decision: decision ?? this.decision,
      confidence: confidence ?? this.confidence,
      completedAt: completedAt ?? this.completedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
      vendorData: vendorData ?? this.vendorData,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$DiditSessionDecisionModelToJson(this);

  /// Create from JSON
  factory DiditSessionDecisionModel.fromJson(Map<String, dynamic> json) =>
      _$DiditSessionDecisionModelFromJson(json);

  /// Check if the session is active (not expired)
  bool get isActive {
    if (expiresAt == null) return true;
    final expires = DateTime.tryParse(expiresAt!);
    if (expires == null) return true;
    return DateTime.now().isBefore(expires);
  }

  /// Check if the session is completed
  bool get isCompleted => status.toLowerCase() == 'completed';

  /// Check if the session is approved
  bool get isApproved => decision?.toLowerCase() == 'approved';

  /// Check if the session failed
  bool get isFailed =>
      decision?.toLowerCase() == 'failed' ||
      decision?.toLowerCase() == 'rejected';

  /// Check if the session is under review
  bool get isUnderReview =>
      status.toLowerCase() == 'under_review' ||
      decision?.toLowerCase() == 'under_review';

  @override
  String toString() {
    return 'DiditSessionDecisionModel(sessionId: $sessionId, status: $status, decision: $decision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiditSessionDecisionModel &&
        other.sessionId == sessionId &&
        other.status == status &&
        other.decision == decision;
  }

  @override
  int get hashCode {
    return sessionId.hashCode ^ status.hashCode ^ decision.hashCode;
  }
}
