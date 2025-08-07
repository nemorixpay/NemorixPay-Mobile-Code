// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'didit_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiditSessionModel _$DiditSessionModelFromJson(Map<String, dynamic> json) =>
    DiditSessionModel(
      sessionId: json['session_id'] as String,
      sessionNumber: (json['session_number'] as num).toInt(),
      sessionToken: json['session_token'] as String?,
      vendorData: json['vendor_data'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: json['status'] as String,
      workflowId: json['workflow_id'] as String,
      callback: json['callback'] as String?,
      url: json['url'] as String,
      createdAt: json['created_at'] as String?,
      expiresAt: json['expires_at'] as String?,
      completedAt: json['completed_at'] as String?,
      decision: json['decision'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      qrCode: json['qr_code'] as String?,
    );

Map<String, dynamic> _$DiditSessionModelToJson(DiditSessionModel instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'session_number': instance.sessionNumber,
      'session_token': instance.sessionToken,
      'vendor_data': instance.vendorData,
      'metadata': instance.metadata,
      'status': instance.status,
      'workflow_id': instance.workflowId,
      'callback': instance.callback,
      'url': instance.url,
      'created_at': instance.createdAt,
      'expires_at': instance.expiresAt,
      'completed_at': instance.completedAt,
      'decision': instance.decision,
      'confidence': instance.confidence,
      'qr_code': instance.qrCode,
    };
