import 'package:nemorixpay/features/auth/domain/entities/user_entity.dart';

/// @file        user_model.dart
/// @brief       User model for NemorixPay auth feature.
/// @details     This class represents the user model in the data layer.
///              It is dependant of any external service implementation like Firebase or SQLite database.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
/// @copyright   Apache 2.0 License
class UserModel {
  /// Unique identifier of the user
  final String id;

  /// Email address of the user
  final String email;

  /// Whether the user's email has been verified
  final bool isEmailVerified;

  /// When the user was created
  final DateTime createdAt;

  /// When the user was last updated
  final DateTime? updatedAt;

  /// Creates a new [UserModel] instance
  ///
  /// All parameters are required except [updatedAt]
  const UserModel({
    required this.id,
    required this.email,
    required this.isEmailVerified,
    required this.createdAt,
    this.updatedAt,
  });

  /// Creates a copy of this [UserModel] with the given fields replaced with the new values
  UserModel copyWith({
    String? id,
    String? email,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Creates a new [UserEntity] with the given fields
  UserEntity toUserEntity({
    String? id,
    String? email,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.isEmailVerified == isEmailVerified &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        isEmailVerified.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, isEmailVerified: $isEmailVerified, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
