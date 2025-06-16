import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/save_language_usecase.dart';
import '../../domain/usecases/get_language_usecase.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import '../../domain/usecases/check_onboarding_status_usecase.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

/// @file        onboarding_bloc.dart
/// @brief       BLoC for Onboarding feature.
/// @details     Handles the business logic for language selection and onboarding flow.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SaveLanguageUsecase saveLanguage;
  final GetLanguageUsecase getLanguage;
  final CompleteOnboardingUsecase completeOnboarding;
  final CheckOnboardingStatusUsecase checkOnboardingStatus;

  // Constants for onboarding slides
  static const int totalSlides = 3;

  OnboardingBloc({
    required this.saveLanguage,
    required this.getLanguage,
    required this.completeOnboarding,
    required this.checkOnboardingStatus,
  }) : super(const OnboardingInitial()) {
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
    on<SelectLanguage>(_onSelectLanguage);
    on<NextSlide>(_onNextSlide);
    on<PreviousSlide>(_onPreviousSlide);
    on<SkipOnboarding>(_onSkipOnboarding);
    on<CompleteOnboarding>(_onCompleteOnboarding);
  }

  Future<void> _onCheckOnboardingStatus(
    CheckOnboardingStatus event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingChecking());

    // First, check if onboarding has been completed
    final checkingOnboarding = await checkOnboardingStatus();

    checkingOnboarding.fold(
      (failure) {
        emit(OnboardingError(failure.message));
        return;
      },
      (isCompleted) {
        if (isCompleted) {
          emit(const OnboardingAlreadyCompleted());
          return;
        }
      },
    );

    // If not completed, check the language
    final result = await getLanguage();
    result.fold((failure) => emit(OnboardingError(failure.message)), (
      language,
    ) {
      if (language == null) {
        // First run, no language saved
        emit(const OnboardingInitial());
      } else {
        // User already has a language saved
        emit(LanguageSelection(currentLanguage: language));
      }
    });
  }

  Future<void> _onSelectLanguage(
    SelectLanguage event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await saveLanguage(event.language);
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (success) => emit(
        OnboardingInProgress(
          currentSlide: 0,
          totalSlides: totalSlides,
          currentLanguage: event.language,
        ),
      ),
    );
  }

  void _onNextSlide(NextSlide event, Emitter<OnboardingState> emit) {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      if (currentState.currentSlide < totalSlides - 1) {
        emit(
          OnboardingInProgress(
            currentSlide: currentState.currentSlide + 1,
            totalSlides: totalSlides,
            currentLanguage: currentState.currentLanguage,
          ),
        );
      }
    }
  }

  void _onPreviousSlide(PreviousSlide event, Emitter<OnboardingState> emit) {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      if (currentState.currentSlide > 0) {
        emit(
          OnboardingInProgress(
            currentSlide: currentState.currentSlide - 1,
            totalSlides: totalSlides,
            currentLanguage: currentState.currentLanguage,
          ),
        );
      }
    }
  }

  Future<void> _onSkipOnboarding(
    SkipOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await completeOnboarding();
    result.fold((failure) => emit(OnboardingError(failure.message)), (success) {
      if (state is OnboardingInProgress) {
        final currentState = state as OnboardingInProgress;
        emit(
          OnboardingCompleted(selectedLanguage: currentState.currentLanguage),
        );
      }
    });
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await completeOnboarding();
    result.fold((failure) => emit(OnboardingError(failure.message)), (success) {
      if (state is OnboardingInProgress) {
        final currentState = state as OnboardingInProgress;
        emit(
          OnboardingCompleted(selectedLanguage: currentState.currentLanguage),
        );
      }
    });
  }
}
