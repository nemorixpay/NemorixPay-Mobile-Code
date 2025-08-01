import 'package:equatable/equatable.dart';
import '../../domain/entities/kyc_session.dart';

/// @file        kyc_state.dart
/// @brief       States for KYC BLoC
/// @details     Defines all states that the KYC BLoC can emit
///              for managing KYC verification sessions and status
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class KYCState extends Equatable {
  const KYCState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class KYCInitial extends KYCState {
  const KYCInitial();
}

/// Loading KYC data
class KYCLoading extends KYCState {
  const KYCLoading();
}

/// KYC data loaded successfully
class KYCLoaded extends KYCState {
  final KYCStatus status;
  final KYCSession? session;
  final bool hasActiveSession;

  const KYCLoaded({
    required this.status,
    this.session,
    required this.hasActiveSession,
  });

  @override
  List<Object?> get props => [status, session, hasActiveSession];
}

/// KYC session created successfully
class KYCSessionCreated extends KYCState {
  final KYCSession session;

  const KYCSessionCreated(this.session);

  @override
  List<Object?> get props => [session];
}

/// KYC verification started
class KYCVerificationStarted extends KYCState {
  final KYCSession session;

  const KYCVerificationStarted(this.session);

  @override
  List<Object?> get props => [session];
}

/// KYC status updated
class KYCStatusUpdated extends KYCState {
  final KYCStatus status;
  final KYCSession? session;

  const KYCStatusUpdated({
    required this.status,
    this.session,
  });

  @override
  List<Object?> get props => [status, session];
}

/// KYC session cleared
class KYCSessionCleared extends KYCState {
  const KYCSessionCleared();
}

/// Error state
class KYCError extends KYCState {
  final String message;

  const KYCError(this.message);

  @override
  List<Object?> get props => [message];
}
