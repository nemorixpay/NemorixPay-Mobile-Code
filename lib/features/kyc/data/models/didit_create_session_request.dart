/// @file        didit_create_session_request.dart
/// @brief       Model for Didit API create session request
/// @details     Represents the request body for creating a verification session with Didit
/// @author      Miguel Fagundez
/// @date        08/04/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

import 'package:json_annotation/json_annotation.dart';

part 'didit_create_session_request.g.dart';

@JsonSerializable()
class DiditCreateSessionRequest {
  /// The workflow ID that defines the verification steps
  @JsonKey(name: 'workflow_id')
  final String workflowId;

  /// Vendor data to associate with the session (e.g., user email)
  @JsonKey(name: 'vendor_data')
  final String vendorData;

  /// Callback URL for webhook notifications
  @JsonKey(name: 'callback')
  final String? callback;

  /// Additional metadata for the session
  @JsonKey(name: 'metadata')
  final Map<String, dynamic>? metadata;

  /// Language preference for the verification UI
  @JsonKey(name: 'language')
  final String? language;

  /// Country code for document verification
  @JsonKey(name: 'country')
  final String? country;

  /// Document types to accept
  @JsonKey(name: 'document_types')
  final List<String>? documentTypes;

  const DiditCreateSessionRequest({
    required this.workflowId,
    required this.vendorData,
    this.callback,
    this.metadata,
    this.language,
    this.country,
    this.documentTypes,
  });

  /// Create a copy of this request with updated fields
  DiditCreateSessionRequest copyWith({
    String? workflowId,
    String? vendorData,
    String? callback,
    Map<String, dynamic>? metadata,
    String? language,
    String? country,
    List<String>? documentTypes,
  }) {
    return DiditCreateSessionRequest(
      workflowId: workflowId ?? this.workflowId,
      vendorData: vendorData ?? this.vendorData,
      callback: callback ?? this.callback,
      metadata: metadata ?? this.metadata,
      language: language ?? this.language,
      country: country ?? this.country,
      documentTypes: documentTypes ?? this.documentTypes,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$DiditCreateSessionRequestToJson(this);

  /// Create from JSON
  factory DiditCreateSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$DiditCreateSessionRequestFromJson(json);

  @override
  String toString() {
    return 'DiditCreateSessionRequest(workflowId: $workflowId, vendorData: $vendorData, callback: $callback)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiditCreateSessionRequest &&
        other.workflowId == workflowId &&
        other.vendorData == vendorData &&
        other.callback == callback;
  }

  @override
  int get hashCode {
    return workflowId.hashCode ^ vendorData.hashCode ^ callback.hashCode;
  }
}
