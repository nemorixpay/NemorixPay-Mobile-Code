// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'didit_session_decision_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiditSessionDecisionModel _$DiditSessionDecisionModelFromJson(
        Map<String, dynamic> json) =>
    DiditSessionDecisionModel(
      sessionId: json['session_id'] as String,
      status: json['status'] as String,
      decision: json['decision'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      completedAt: json['completed_at'] as String?,
      expiresAt: json['expires_at'] as String?,
      results: json['results'] as Map<String, dynamic>?,
      errorMessage: json['error_message'] as String?,
      errorCode: json['error_code'] as String?,
      vendorData: json['vendor_data'] as String?,
    );

Map<String, dynamic> _$DiditSessionDecisionModelToJson(
        DiditSessionDecisionModel instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'status': instance.status,
      'decision': instance.decision,
      'confidence': instance.confidence,
      'completed_at': instance.completedAt,
      'expires_at': instance.expiresAt,
      'results': instance.results,
      'error_message': instance.errorMessage,
      'error_code': instance.errorCode,
      'vendor_data': instance.vendorData,
    };
