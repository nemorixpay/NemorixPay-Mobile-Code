/// @file        user_analytics_model.dart
/// @brief       Data model for user analytics tracking.
/// @details     This model represents user registration data that will be sent to Firebase
///              for analytics purposes. It includes user identification, location, platform,
///              and dates in YYYY-MM-DD format for flexible querying and statistics generation.
/// @author      Miguel Fagundez
/// @date        02/10/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

import 'dart:convert';

class UserAnalyticsModel {
  final String id;
  final String name;
  final String country;
  final String platform;
  final String registrationDate; // Format: YYYY-MM-DD
  final String birthDate; // Format: YYYY-MM-DD

  const UserAnalyticsModel({
    required this.id,
    required this.name,
    required this.country,
    required this.platform,
    required this.registrationDate,
    required this.birthDate,
  });

  /// Creates a UserAnalyticsModel from a JSON map
  factory UserAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return UserAnalyticsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      platform: json['platform'] as String,
      registrationDate: json['registrationDate'] as String,
      birthDate: (json['birthDate'] ?? json['birthDate ']) as String, // Handle space issue
    );
  }

  /// Converts the UserAnalyticsModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'platform': platform,
      'registrationDate': registrationDate,
      'birthDate': birthDate,
    };
  }

  /// Converts the UserAnalyticsModel to a JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Creates a copy of this UserAnalyticsModel with the given fields replaced
  UserAnalyticsModel copyWith({
    String? id,
    String? name,
    String? country,
    String? platform,
    String? registrationDate,
    String? birthDate,
  }) {
    return UserAnalyticsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      platform: platform ?? this.platform,
      registrationDate: registrationDate ?? this.registrationDate,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserAnalyticsModel &&
        other.id == id &&
        other.name == name &&
        other.country == country &&
        other.platform == platform &&
        other.registrationDate == registrationDate &&
        other.birthDate == birthDate;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      country,
      platform,
      registrationDate,
      birthDate,
    );
  }

  @override
  String toString() {
    return 'UserAnalyticsModel(id: $id, name: $name, country: $country, platform: $platform, registrationDate: $registrationDate, birthDate: $birthDate)';
  }
}
