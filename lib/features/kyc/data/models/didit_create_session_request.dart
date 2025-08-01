import 'package:equatable/equatable.dart';

/// @file        didit_create_session_request.dart
/// @brief       Model for Didit API create session request
/// @details     Represents the request body for Didit Create Session API
///              with workflow_id, vendor_data and callback URL
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class DiditCreateSessionRequest extends Equatable {
  final String workflowId;
  final String? vendorData;
  final String? callback;

  const DiditCreateSessionRequest({
    required this.workflowId,
    this.vendorData,
    this.callback,
  });

  @override
  List<Object?> get props => [workflowId, vendorData, callback];

  /// Convert request to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'workflow_id': workflowId,
    };

    if (vendorData != null) {
      json['vendor_data'] = vendorData;
    }

    if (callback != null) {
      json['callback'] = callback;
    }

    return json;
  }

  /// Create a copy with updated fields
  DiditCreateSessionRequest copyWith({
    String? workflowId,
    String? vendorData,
    String? callback,
  }) {
    return DiditCreateSessionRequest(
      workflowId: workflowId ?? this.workflowId,
      vendorData: vendorData ?? this.vendorData,
      callback: callback ?? this.callback,
    );
  }
}
