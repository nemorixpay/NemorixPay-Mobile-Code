import '../../domain/entities/onboarding_entity.dart';

/// @file        onboarding_model.dart
/// @brief       Data model for Onboarding feature.
/// @details     Implements the data model with mapping methods to/from entity.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class OnboardingModel extends OnboardingEntity {
  OnboardingModel({
    required super.language,
    super.isCompleted = false,
    super.hasWallet = false,
  });

  /// Creates a model from JSON
  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      language: json['language'] as String,
      isCompleted: json['is_completed'] as bool? ?? false,
      hasWallet: json['has_wallet'] as bool? ?? false,
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'is_completed': isCompleted,
      'has_wallet': hasWallet,
    };
  }

  /// Converts model to entity
  OnboardingEntity toEntity() {
    return OnboardingEntity(
      language: language,
      isCompleted: isCompleted,
      hasWallet: hasWallet,
    );
  }

  /// Creates model from entity
  factory OnboardingModel.fromEntity(OnboardingEntity entity) {
    return OnboardingModel(
      language: entity.language,
      isCompleted: entity.isCompleted,
      hasWallet: entity.hasWallet,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OnboardingModel &&
        other.language == language &&
        other.isCompleted == isCompleted &&
        other.hasWallet == hasWallet;
  }

  @override
  int get hashCode =>
      language.hashCode ^ isCompleted.hashCode ^ hasWallet.hashCode;
}
