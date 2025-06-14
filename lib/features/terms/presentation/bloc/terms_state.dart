/// @file        terms_state.dart
/// @brief       States for Terms and Conditions Bloc.
/// @details     Defines the states for loading, loaded, error, and acceptance of terms.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class TermsState {}

class TermsInitial extends TermsState {}

class TermsLoading extends TermsState {}

class TermsLoaded extends TermsState {
  final String content;
  final bool isAccepted;
  TermsLoaded({required this.content, required this.isAccepted});
}

class TermsError extends TermsState {
  final String message;
  TermsError(this.message);
}
