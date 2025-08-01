import 'package:equatable/equatable.dart';

/// @file        didit_session_model.dart
/// @brief       Model for Didit API session response
/// @details     Represents the response from Didit Create Session API
///              with all required fields for KYC verification
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class DiditSessionModel extends Equatable {
  final String sessionId;
  final int sessionNumber;
  final String sessionToken;
  final String? vendorData;
  final Map<String, dynamic>? metadata;
  final String status;
  final String workflowId;
  final String? callback;
  final String url;

  const DiditSessionModel({
    required this.sessionId,
    required this.sessionNumber,
    required this.sessionToken,
    this.vendorData,
    this.metadata,
    required this.status,
    required this.workflowId,
    this.callback,
    required this.url,
  });

  @override
  List<Object?> get props => [
        sessionId,
        sessionNumber,
        sessionToken,
        vendorData,
        metadata,
        status,
        workflowId,
        callback,
        url,
      ];

  /// Create model from JSON response
  factory DiditSessionModel.fromJson(Map<String, dynamic> json) {
    return DiditSessionModel(
      sessionId: json['session_id'] as String,
      sessionNumber: json['session_number'] as int,
      sessionToken: json['session_token'] as String,
      vendorData: json['vendor_data'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: json['status'] as String,
      workflowId: json['workflow_id'] as String,
      callback: json['callback'] as String?,
      url: json['url'] as String,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'session_number': sessionNumber,
      'session_token': sessionToken,
      'vendor_data': vendorData,
      'metadata': metadata,
      'status': status,
      'workflow_id': workflowId,
      'callback': callback,
      'url': url,
    };
  }

  /// Create a copy with updated fields
  DiditSessionModel copyWith({
    String? sessionId,
    int? sessionNumber,
    String? sessionToken,
    String? vendorData,
    Map<String, dynamic>? metadata,
    String? status,
    String? workflowId,
    String? callback,
    String? url,
  }) {
    return DiditSessionModel(
      sessionId: sessionId ?? this.sessionId,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      sessionToken: sessionToken ?? this.sessionToken,
      vendorData: vendorData ?? this.vendorData,
      metadata: metadata ?? this.metadata,
      status: status ?? this.status,
      workflowId: workflowId ?? this.workflowId,
      callback: callback ?? this.callback,
      url: url ?? this.url,
    );
  }
}
