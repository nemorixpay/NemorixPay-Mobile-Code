/// @file        didit_session_model.dart
/// @brief       Model for Didit API session response
/// @details     Represents the response from creating a verification session with Didit
/// @author      Miguel Fagundez
/// @date        08/04/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

import 'package:json_annotation/json_annotation.dart';

part 'didit_session_model.g.dart';

@JsonSerializable()
class DiditSessionModel {
  /// Unique session identifier
  @JsonKey(name: 'session_id')
  final String sessionId;

  /// Sequential session number
  @JsonKey(name: 'session_number')
  final int sessionNumber;

  /// Vendor data associated with the session
  @JsonKey(name: 'vendor_data')
  final String? vendorData;

  /// Additional metadata for the session
  @JsonKey(name: 'metadata')
  final Map<String, dynamic>? metadata;

  /// Current status of the session
  @JsonKey(name: 'status')
  final String status;

  /// Workflow ID used for this session
  @JsonKey(name: 'workflow_id')
  final String workflowId;

  /// Callback URL for webhook notifications
  @JsonKey(name: 'callback')
  final String? callback;

  /// Unique verification URL for the user
  @JsonKey(name: 'url')
  final String url;

  /// Session creation timestamp
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// Session expiration timestamp
  @JsonKey(name: 'expires_at')
  final String? expiresAt;

  /// Session completion timestamp
  @JsonKey(name: 'completed_at')
  final String? completedAt;

  /// Final decision of the verification
  @JsonKey(name: 'decision')
  final String? decision;

  /// Confidence score of the verification
  @JsonKey(name: 'confidence')
  final double? confidence;

  /// QR code data for mobile verification
  @JsonKey(name: 'qr_code')
  final String? qrCode;

  const DiditSessionModel({
    required this.sessionId,
    required this.sessionNumber,
    this.vendorData,
    this.metadata,
    required this.status,
    required this.workflowId,
    this.callback,
    required this.url,
    this.createdAt,
    this.expiresAt,
    this.completedAt,
    this.decision,
    this.confidence,
    this.qrCode,
  });

  /// Create a copy of this session with updated fields
  DiditSessionModel copyWith({
    String? sessionId,
    int? sessionNumber,
    String? vendorData,
    Map<String, dynamic>? metadata,
    String? status,
    String? workflowId,
    String? callback,
    String? url,
    String? createdAt,
    String? expiresAt,
    String? completedAt,
    String? decision,
    double? confidence,
    String? qrCode,
  }) {
    return DiditSessionModel(
      sessionId: sessionId ?? this.sessionId,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      vendorData: vendorData ?? this.vendorData,
      metadata: metadata ?? this.metadata,
      status: status ?? this.status,
      workflowId: workflowId ?? this.workflowId,
      callback: callback ?? this.callback,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      completedAt: completedAt ?? this.completedAt,
      decision: decision ?? this.decision,
      confidence: confidence ?? this.confidence,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$DiditSessionModelToJson(this);

  /// Create from JSON
  factory DiditSessionModel.fromJson(Map<String, dynamic> json) =>
      _$DiditSessionModelFromJson(json);

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

  @override
  String toString() {
    return 'DiditSessionModel(sessionId: $sessionId, status: $status, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiditSessionModel &&
        other.sessionId == sessionId &&
        other.status == status &&
        other.url == url;
  }

  @override
  int get hashCode {
    return sessionId.hashCode ^ status.hashCode ^ url.hashCode;
  }
}
