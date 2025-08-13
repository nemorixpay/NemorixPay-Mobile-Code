import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/kyc_session.dart';
import '../../domain/repositories/kyc_repository.dart';
import '../../domain/usecases/create_kyc_session.dart' as usecase;
import '../../domain/usecases/get_kyc_status.dart';
import '../../domain/usecases/save_kyc_session.dart';
import 'kyc_event.dart';
import 'kyc_state.dart';

/// @file        kyc_bloc.dart
/// @brief       BLoC for KYC feature
/// @details     Manages KYC verification sessions, status updates, and UI state
///              through event-driven architecture
/// @author      Miguel Fagundez
/// @date        08/08/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class KYCBloc extends Bloc<KYCEvent, KYCState> {
  final usecase.CreateKYCSession _createSession;
  final GetKYCStatus _getStatus;
  final SaveKYCSession _saveSession;
  final KYCRepository _repository;

  KYCBloc({
    required usecase.CreateKYCSession createSession,
    required GetKYCStatus getStatus,
    required SaveKYCSession saveSession,
    required KYCRepository repository,
  })  : _createSession = createSession,
        _getStatus = getStatus,
        _saveSession = saveSession,
        _repository = repository,
        super(const KYCInitial()) {
    // Event handlers
    on<LoadKYCStatus>(_onLoadKYCStatus);
    on<CreateKYCSession>(_onCreateKYCSession);
    on<StartKYCVerification>(_onStartKYCVerification);
    on<UpdateKYCStatus>(_onUpdateKYCStatus);
    on<ClearKYCSession>(_onClearKYCSession);
    on<RefreshKYCStatus>(_onRefreshKYCStatus);
  }

  /// Load current KYC status and session
  Future<void> _onLoadKYCStatus(
    LoadKYCStatus event,
    Emitter<KYCState> emit,
  ) async {
    try {
      debugPrint('🔄 KYCBloc: _onLoadKYCStatus - Starting...');
      emit(const KYCLoading());

      // Get current status
      debugPrint('🔄 KYCBloc: _onLoadKYCStatus - Getting status...');
      final status = await _getStatus();
      debugPrint('✅ KYCBloc: _onLoadKYCStatus - Status received: $status');

      // Check if there's an active session
      debugPrint('🔄 KYCBloc: _onLoadKYCStatus - Checking active session...');
      final hasActiveSession = await _repository.hasActiveSession();
      debugPrint(
          '✅ KYCBloc: _onLoadKYCStatus - Has active session: $hasActiveSession');

      // Get current session if exists
      KYCSession? session;
      if (hasActiveSession) {
        debugPrint('🔄 KYCBloc: _onLoadKYCStatus - Getting current session...');
        session = await _repository.getCurrentSession();
        debugPrint(
            '✅ KYCBloc: _onLoadKYCStatus - Session: ${session?.sessionId}');
      }

      debugPrint('✅ KYCBloc: _onLoadKYCStatus - Emitting KYCLoaded');
      emit(KYCLoaded(
        status: status,
        session: session,
        hasActiveSession: hasActiveSession,
      ));
    } catch (e) {
      debugPrint('❌ KYCBloc: _onLoadKYCStatus - Error: $e');
      emit(KYCError('Error loading KYC status: $e'));
    }
  }

  /// Create a new KYC verification session
  Future<void> _onCreateKYCSession(
    CreateKYCSession event,
    Emitter<KYCState> emit,
  ) async {
    try {
      debugPrint('🔄 KYCBloc: _onCreateKYCSession - Starting...');
      emit(const KYCLoading());

      // Check if there's already an active session
      debugPrint(
          '🔄 KYCBloc: _onCreateKYCSession - Checking existing session...');
      final hasActiveSession = await _repository.hasActiveSession();
      debugPrint(
          '✅ KYCBloc: _onCreateKYCSession - Has active session: $hasActiveSession');

      if (hasActiveSession) {
        debugPrint(
            '🔄 KYCBloc: _onCreateKYCSession - Getting current session...');
        final currentSession = await _repository.getCurrentSession();
        debugPrint(
            '✅ KYCBloc: _onCreateKYCSession - Current session: ${currentSession?.sessionId}');

        if (currentSession != null && currentSession.isActive) {
          debugPrint(
              '✅ KYCBloc: _onCreateKYCSession - Reusing existing active session');
          // Return existing active session
          emit(KYCSessionCreated(currentSession));
          return;
        }
      }

      // Create new session
      debugPrint('🔄 KYCBloc: _onCreateKYCSession - Creating new session...');
      final session = await _createSession();
      debugPrint(
          '✅ KYCBloc: _onCreateKYCSession - Session created: ${session.sessionId}');

      // Save session locally
      debugPrint('🔄 KYCBloc: _onCreateKYCSession - Saving session locally...');
      await _saveSession(session);
      debugPrint('✅ KYCBloc: _onCreateKYCSession - Session saved locally');

      debugPrint('✅ KYCBloc: _onCreateKYCSession - Emitting KYCSessionCreated');
      emit(KYCSessionCreated(session));
    } catch (e) {
      debugPrint('❌ KYCBloc: _onCreateKYCSession - Error: $e');
      emit(KYCError('Error creating KYC session: $e'));
    }
  }

  /// Start KYC verification process
  Future<void> _onStartKYCVerification(
    StartKYCVerification event,
    Emitter<KYCState> emit,
  ) async {
    try {
      debugPrint('🔄 KYCBloc: _onStartKYCVerification - Starting...');

      // Get current session
      debugPrint(
          '🔄 KYCBloc: _onStartKYCVerification - Getting current session...');
      final session = await _repository.getCurrentSession();
      debugPrint(
          '✅ KYCBloc: _onStartKYCVerification - Session: ${session?.sessionId}');

      if (session == null) {
        debugPrint(
            '❌ KYCBloc: _onStartKYCVerification - No active session found');
        emit(const KYCError('No active KYC session found'));
        return;
      }

      if (session.isExpired) {
        debugPrint('❌ KYCBloc: _onStartKYCVerification - Session expired');
        emit(const KYCError('KYC session has expired'));
        return;
      }

      debugPrint(
          '✅ KYCBloc: _onStartKYCVerification - Emitting KYCVerificationStarted');
      emit(KYCVerificationStarted(session));
    } catch (e) {
      debugPrint('❌ KYCBloc: _onStartKYCVerification - Error: $e');
      emit(KYCError('Error starting KYC verification: $e'));
    }
  }

  /// Update KYC status manually
  Future<void> _onUpdateKYCStatus(
    UpdateKYCStatus event,
    Emitter<KYCState> emit,
  ) async {
    try {
      debugPrint(
          '🔄 KYCBloc: _onUpdateKYCStatus - Starting with status: ${event.status}');

      final session = await _repository.getCurrentSession();
      debugPrint(
          '✅ KYCBloc: _onUpdateKYCStatus - Session: ${session?.sessionId}');

      debugPrint('✅ KYCBloc: _onUpdateKYCStatus - Emitting KYCStatusUpdated');
      emit(KYCStatusUpdated(
        status: event.status,
        session: session,
      ));
    } catch (e) {
      debugPrint('❌ KYCBloc: _onUpdateKYCStatus - Error: $e');
      emit(KYCError('Error updating KYC status: $e'));
    }
  }

  /// Clear current KYC session
  Future<void> _onClearKYCSession(
    ClearKYCSession event,
    Emitter<KYCState> emit,
  ) async {
    try {
      debugPrint('🔄 KYCBloc: _onClearKYCSession - Starting...');

      await _repository.clearSession();
      debugPrint('✅ KYCBloc: _onClearKYCSession - Session cleared');

      debugPrint('✅ KYCBloc: _onClearKYCSession - Emitting KYCSessionCleared');
      emit(const KYCSessionCleared());
    } catch (e) {
      debugPrint('❌ KYCBloc: _onClearKYCSession - Error: $e');
      emit(KYCError('Error clearing KYC session: $e'));
    }
  }

  /// Refresh KYC status from server
  Future<void> _onRefreshKYCStatus(
    RefreshKYCStatus event,
    Emitter<KYCState> emit,
  ) async {
    try {
      debugPrint('🔄 KYCBloc: _onRefreshKYCStatus - Starting...');
      emit(const KYCLoading());

      // Get latest status from server
      debugPrint('🔄 KYCBloc: _onRefreshKYCStatus - Getting latest status...');
      final status = await _getStatus();
      debugPrint('✅ KYCBloc: _onRefreshKYCStatus - Status received: $status');

      // Check if there's an active session
      debugPrint(
          '🔄 KYCBloc: _onRefreshKYCStatus - Checking active session...');
      final hasActiveSession = await _repository.hasActiveSession();
      debugPrint(
          '✅ KYCBloc: _onRefreshKYCStatus - Has active session: $hasActiveSession');

      // Get current session if exists
      KYCSession? session;
      if (hasActiveSession) {
        debugPrint(
            '🔄 KYCBloc: _onRefreshKYCStatus - Getting current session...');
        session = await _repository.getCurrentSession();
        debugPrint(
            '✅ KYCBloc: _onRefreshKYCStatus - Session: ${session?.sessionId}');
      }

      debugPrint('✅ KYCBloc: _onRefreshKYCStatus - Emitting KYCLoaded');
      emit(KYCLoaded(
        status: status,
        session: session,
        hasActiveSession: hasActiveSession,
      ));
    } catch (e) {
      debugPrint('❌ KYCBloc: _onRefreshKYCStatus - Error: $e');
      emit(KYCError('Error refreshing KYC status: $e'));
    }
  }
}
