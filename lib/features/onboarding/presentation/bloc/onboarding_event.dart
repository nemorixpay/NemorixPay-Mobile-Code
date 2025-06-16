/// @file        onboarding_event.dart
/// @brief       Events for Onboarding feature.
/// @details     Defines the events for language selection, navigation, and completion of onboarding.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class OnboardingEvent {}

/// Event to check if onboarding is needed
class CheckOnboardingStatus extends OnboardingEvent {}

/// Event to check if onboarding was completed
class CheckOnboardingWasCompleted extends OnboardingEvent {}

/// Event to select a language
class SelectLanguage extends OnboardingEvent {
  final String language;
  SelectLanguage(this.language);
}

/// Event to move to the next slide
class NextSlide extends OnboardingEvent {}

/// Event to move to the previous slide
class PreviousSlide extends OnboardingEvent {}

/// Event to skip the onboarding process
class SkipOnboarding extends OnboardingEvent {}

/// Event to complete the onboarding process
class CompleteOnboarding extends OnboardingEvent {}
