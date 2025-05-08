import 'package:nemorixpay/features/auth/data/models/user_model.dart';

/// @file        user_entity.dart
/// @brief       User entity for NemorixPay auth feature.
/// @details     This class represents the user entity in the domain layer.
///              It is independent of any external service implementation.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
/// @copyright   Apache 2.0 License
class UserEntity {
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

  /// Creates a new [UserEntity] instance
  ///
  /// All parameters are required except [updatedAt]
  const UserEntity({
    required this.id,
    required this.email,
    required this.isEmailVerified,
    required this.createdAt,
    this.updatedAt,
  });

  /// Creates a copy of this [UserEntity] with the given fields replaced with the new values
  UserEntity copyWith({
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

  /// Creates a new [UserModel] with the given fields
  UserModel toUserModel({
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
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
