/// @file        transaction_analytics_model.dart
/// @brief       Data model for transaction analytics tracking.
/// @details     This model represents transaction data that will be sent to Firebase
///              for analytics purposes. It includes transaction details, amounts,
///              location, platform, and timing information for comprehensive analytics.
/// @author      Miguel Fagundez
/// @date        04/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'dart:convert';

class TransactionAnalyticsModel {
  final String id;
  final double assetAmount;
  final String assetCode;
  final DateTime createdAt;
  final double feeCharged;
  final double fiatAmount;
  final String fiatSymbol;
  final String location;
  final String platform;
  final String type;

  const TransactionAnalyticsModel({
    required this.id,
    required this.assetAmount,
    required this.assetCode,
    required this.createdAt,
    required this.feeCharged,
    required this.fiatAmount,
    required this.fiatSymbol,
    required this.location,
    required this.platform,
    required this.type,
  });

  /// Creates a TransactionAnalyticsModel from a JSON map
  factory TransactionAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return TransactionAnalyticsModel(
      id: json['id'] as String,
      assetAmount: (json['assetAmount'] as num).toDouble(),
      assetCode: json['assetCode'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      feeCharged: (json['feeCharged'] as num).toDouble(),
      fiatAmount: (json['fiatAmount'] as num).toDouble(),
      fiatSymbol: json['fiatSymbol'] as String,
      location: json['location'] as String,
      platform: json['platform'] as String,
      type: json['type'] as String,
    );
  }

  /// Converts the TransactionAnalyticsModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assetAmount': assetAmount,
      'assetCode': assetCode,
      'createdAt': createdAt.toUtc().toIso8601String().replaceAll('.000Z', 'Z'),
      'feeCharged': feeCharged,
      'fiatAmount': fiatAmount,
      'fiatSymbol': fiatSymbol,
      'location': location,
      'platform': platform,
      'type': type,
    };
  }

  /// Converts the TransactionAnalyticsModel to a JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Creates a copy of this TransactionAnalyticsModel with the given fields replaced
  TransactionAnalyticsModel copyWith({
    String? id,
    double? assetAmount,
    String? assetCode,
    DateTime? createdAt,
    double? feeCharged,
    double? fiatAmount,
    String? fiatSymbol,
    String? location,
    String? platform,
    String? type,
  }) {
    return TransactionAnalyticsModel(
      id: id ?? this.id,
      assetAmount: assetAmount ?? this.assetAmount,
      assetCode: assetCode ?? this.assetCode,
      createdAt: createdAt ?? this.createdAt,
      feeCharged: feeCharged ?? this.feeCharged,
      fiatAmount: fiatAmount ?? this.fiatAmount,
      fiatSymbol: fiatSymbol ?? this.fiatSymbol,
      location: location ?? this.location,
      platform: platform ?? this.platform,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionAnalyticsModel &&
        other.id == id &&
        other.assetAmount == assetAmount &&
        other.assetCode == assetCode &&
        other.createdAt == createdAt &&
        other.feeCharged == feeCharged &&
        other.fiatAmount == fiatAmount &&
        other.fiatSymbol == fiatSymbol &&
        other.location == location &&
        other.platform == platform &&
        other.type == type;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      assetAmount,
      assetCode,
      createdAt,
      feeCharged,
      fiatAmount,
      fiatSymbol,
      location,
      platform,
      type,
    );
  }

  @override
  String toString() {
    return 'TransactionAnalyticsModel('
        'id: $id, '
        'assetAmount: $assetAmount, '
        'assetCode: $assetCode, '
        'createdAt: $createdAt, '
        'feeCharged: $feeCharged, '
        'fiatAmount: $fiatAmount, '
        'fiatSymbol: $fiatSymbol, '
        'location: $location, '
        'platform: $platform, '
        'type: $type'
        ')';
  }
}
