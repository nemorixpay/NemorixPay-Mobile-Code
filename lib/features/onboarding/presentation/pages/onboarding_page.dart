import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:nemorixpay/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:nemorixpay/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:nemorixpay/features/onboarding/presentation/pages/benefits_slide.dart';
import 'package:nemorixpay/features/onboarding/presentation/pages/features_slide.dart';
import 'package:nemorixpay/features/onboarding/presentation/pages/security_slide.dart';
import 'package:nemorixpay/features/onboarding/presentation/widgets/language_selection_widget.dart';

/// @file        onboarding_page.dart
/// @brief       Main onboarding page that handles the complete onboarding flow.
/// @details     This page manages the onboarding process including language selection
///              and slide navigation using the OnboardingBloc.
/// @author      Miguel Fagundez
/// @date        01/15/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  bool _isProgrammaticPageChange = false;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Check onboarding status when the page loads
    context.read<OnboardingBloc>().add(CheckOnboardingStatus());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextSlide() {
    if (_currentPageIndex < 2) {
      // Only allow if not at last slide
      context.read<OnboardingBloc>().add(NextSlide());
    }
  }

  void _onPreviousSlide() {
    if (_currentPageIndex > 0) {
      // Only allow if not at first slide
      context.read<OnboardingBloc>().add(PreviousSlide());
    }
  }

  void _onSkipOnboarding() {
    context.read<OnboardingBloc>().add(SkipOnboarding());
  }

  void _onCompleteOnboarding() {
    context.read<OnboardingBloc>().add(CompleteOnboarding());
  }

  void _onLanguageSelected(String language) {
    debugPrint('LanguageSelection (OnboardingPage): $language');
    context.read<OnboardingBloc>().add(SelectLanguage(language));
  }

  void _onPageChanged(int index) {
    if (!_isProgrammaticPageChange) {
      _currentPageIndex = index;
      // Only emit events if the index is different from the current state
      final currentState = context.read<OnboardingBloc>().state;
      if (currentState is OnboardingInProgress) {
        if (index > currentState.currentSlide) {
          // Moving forward
          for (int i = currentState.currentSlide; i < index; i++) {
            context.read<OnboardingBloc>().add(NextSlide());
          }
        } else if (index < currentState.currentSlide) {
          // Moving backward
          for (int i = currentState.currentSlide; i > index; i--) {
            context.read<OnboardingBloc>().add(PreviousSlide());
          }
        }
      }
    }
  }

  void _synchronizePageController(int targetSlide) {
    if (_currentPageIndex != targetSlide) {
      _isProgrammaticPageChange = true;
      _pageController
          .animateToPage(
        targetSlide,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        _currentPageIndex = targetSlide;
        _isProgrammaticPageChange = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          // Navigate to home or auth based on onboarding completion
          Navigator.pushReplacementNamed(context, RouteNames.signIn);
        } else if (state is OnboardingAlreadyCompleted) {
          // User already completed onboarding, go to home
          Navigator.pushReplacementNamed(context, RouteNames.signIn);
        } else if (state is OnboardingError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: NemorixColors.errorColor,
            ),
          );
        } else if (state is OnboardingInProgress) {
          // Synchronize PageController with BLoC state
          _synchronizePageController(state.currentSlide);
        }
      },
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(OnboardingState state) {
    if (state is OnboardingChecking) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is OnboardingInitial) {
      return LanguageSelectionWidget(
        onLanguageSelected: _onLanguageSelected,
      );
    }

    if (state is LanguageSelection) {
      return LanguageSelectionWidget(
        currentLanguage: state.currentLanguage,
        onLanguageSelected: _onLanguageSelected,
      );
    }

    if (state is OnboardingInProgress) {
      return _buildOnboardingSlides(state);
    }

    // Default loading state
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildOnboardingSlides(OnboardingInProgress state) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              SecuritySlide(
                onNext: _onNextSlide,
              ),
              FeaturesSlide(
                onNext: _onNextSlide,
                onBack: _onPreviousSlide,
              ),
              BenefitsSlide(
                onNext: _onCompleteOnboarding,
                onBack: _onPreviousSlide,
              ),
            ],
          ),
        ),
        // Progress indicator
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              state.totalSlides,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == state.currentSlide
                      ? NemorixColors.primaryColor
                      : NemorixColors.greyLevel3,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
