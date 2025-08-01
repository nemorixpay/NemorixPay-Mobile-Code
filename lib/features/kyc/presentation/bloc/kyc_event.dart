import 'package:equatable/equatable.dart';
import '../../domain/entities/kyc_session.dart';

/// @file        kyc_event.dart
/// @brief       Events for KYC BLoC
/// @details     Defines all events that can be dispatched to the KYC BLoC
///              for managing KYC verification sessions and status
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class KYCEvent extends Equatable {
  const KYCEvent();

  @override
  List<Object?> get props => [];
}

/// Load current KYC status and session
class LoadKYCStatus extends KYCEvent {
  const LoadKYCStatus();
}

/// Create a new KYC verification session
class CreateKYCSession extends KYCEvent {
  const CreateKYCSession();
}

/// Start KYC verification process
class StartKYCVerification extends KYCEvent {
  const StartKYCVerification();
}

/// Update KYC session status
class UpdateKYCStatus extends KYCEvent {
  final KYCStatus status;

  const UpdateKYCStatus(this.status);

  @override
  List<Object?> get props => [status];
}

/// Clear current KYC session
class ClearKYCSession extends KYCEvent {
  const ClearKYCSession();
}

/// Refresh KYC status from server
class RefreshKYCStatus extends KYCEvent {
  const RefreshKYCStatus();
}
