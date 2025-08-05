// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'didit_create_session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiditCreateSessionRequest _$DiditCreateSessionRequestFromJson(
        Map<String, dynamic> json) =>
    DiditCreateSessionRequest(
      workflowId: json['workflow_id'] as String,
      vendorData: json['vendor_data'] as String,
      callback: json['callback'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      language: json['language'] as String?,
      country: json['country'] as String?,
      documentTypes: (json['document_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DiditCreateSessionRequestToJson(
        DiditCreateSessionRequest instance) =>
    <String, dynamic>{
      'workflow_id': instance.workflowId,
      'vendor_data': instance.vendorData,
      'callback': instance.callback,
      'metadata': instance.metadata,
      'language': instance.language,
      'country': instance.country,
      'document_types': instance.documentTypes,
    };
