import 'package:equatable/equatable.dart';

/// @file        onboarding_state.dart
/// @brief       States for Onboarding feature.
/// @details     Defines all possible states for the onboarding process.
/// @author      Miguel Fagundez
/// @date        06/1/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the app is first launched
class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

/// State when checking onboarding status
class OnboardingChecking extends OnboardingState {
  const OnboardingChecking();
}

/// State when showing language selection
class LanguageSelection extends OnboardingState {
  final String currentLanguage;

  const LanguageSelection({required this.currentLanguage});

  @override
  List<Object?> get props => [currentLanguage];
}

/// State when onboarding is in progress
class OnboardingInProgress extends OnboardingState {
  final int currentSlide;
  final int totalSlides;
  final String currentLanguage;

  const OnboardingInProgress({
    required this.currentSlide,
    required this.totalSlides,
    required this.currentLanguage,
  });

  @override
  List<Object?> get props => [currentSlide, totalSlides, currentLanguage];
}

/// State when onboarding is completed
class OnboardingCompleted extends OnboardingState {
  final String selectedLanguage;

  const OnboardingCompleted({required this.selectedLanguage});

  @override
  List<Object?> get props => [selectedLanguage];
}

/// State when onboarding was previously completed
class OnboardingAlreadyCompleted extends OnboardingState {
  final String? selectedLanguage;

  const OnboardingAlreadyCompleted({this.selectedLanguage});

  @override
  List<Object?> get props => [selectedLanguage];
}

/// State when an error occurs
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
