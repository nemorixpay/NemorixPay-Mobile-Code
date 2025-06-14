/// @file        terms_event.dart
/// @brief       Events for Terms and Conditions Bloc.
/// @details     Defines the events for loading, accepting, and toggling acceptance of terms.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class TermsEvent {}

class LoadTerms extends TermsEvent {}

class ToggleAcceptance extends TermsEvent {}

class AcceptTermsEvent extends TermsEvent {
  final String version;
  final DateTime acceptedAt;
  AcceptTermsEvent({required this.version, required this.acceptedAt});
}
