/// @file        onboarding_entity.dart
/// @brief       Entity representing the onboarding data.
/// @details     Contains information about language selection and onboarding completion status.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class OnboardingEntity {
  final String language;
  final bool isCompleted;
  final bool hasWallet;

  OnboardingEntity({
    required this.language,
    this.isCompleted = false,
    this.hasWallet = false,
  });

  OnboardingEntity copyWith({
    String? language,
    bool? isCompleted,
    bool? hasWallet,
  }) {
    return OnboardingEntity(
      language: language ?? this.language,
      isCompleted: isCompleted ?? this.isCompleted,
      hasWallet: hasWallet ?? this.hasWallet,
    );
  }
}
