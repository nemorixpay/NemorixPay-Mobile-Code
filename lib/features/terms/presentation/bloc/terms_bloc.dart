import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_terms_content.dart';
import '../../domain/usecases/accept_terms.dart';
import 'terms_event.dart';
import 'terms_state.dart';

/// @file        terms_bloc.dart
/// @brief       Bloc for Terms and Conditions feature.
/// @details     Handles loading, acceptance, and state management for terms and conditions.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  final GetTermsContent getTermsContent;
  final AcceptTerms acceptTerms;

  bool isAccepted = false;

  TermsBloc({required this.getTermsContent, required this.acceptTerms})
    : super(TermsInitial()) {
    on<LoadTerms>(_onLoadTerms);
    on<ToggleAcceptance>(_onToggleAcceptance);
    on<AcceptTermsEvent>(_onAcceptTerms);
  }

  Future<void> _onLoadTerms(LoadTerms event, Emitter<TermsState> emit) async {
    emit(TermsLoading());
    try {
      final content = await getTermsContent();
      emit(TermsLoaded(content: content, isAccepted: isAccepted));
    } catch (e) {
      emit(TermsError(e.toString()));
    }
  }

  void _onToggleAcceptance(ToggleAcceptance event, Emitter<TermsState> emit) {
    isAccepted = !isAccepted;
    if (state is TermsLoaded) {
      emit(
        TermsLoaded(
          content: (state as TermsLoaded).content,
          isAccepted: isAccepted,
        ),
      );
    }
  }

  Future<void> _onAcceptTerms(
    AcceptTermsEvent event,
    Emitter<TermsState> emit,
  ) async {
    try {
      await acceptTerms(event.version, event.acceptedAt);
      isAccepted = true;
      if (state is TermsLoaded) {
        emit(
          TermsLoaded(
            content: (state as TermsLoaded).content,
            isAccepted: isAccepted,
          ),
        );
      }
    } catch (e) {
      emit(TermsError(e.toString()));
    }
  }
}
