import 'package:equatable/equatable.dart';

/// @file        kyc_session.dart
/// @brief       Entity representing a KYC verification session
/// @details     Contains session data for Didit KYC verification including
///              session ID, token, URL, creation time and status
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

enum KYCStatus {
  notStarted,
  inProgress,
  completed,
  failed,
  underReview,
  expired,
}

class KYCSession extends Equatable {
  final String sessionId;
  final String sessionToken;
  final String url;
  final DateTime createdAt;
  final KYCStatus status;

  const KYCSession({
    required this.sessionId,
    required this.sessionToken,
    required this.url,
    required this.createdAt,
    required this.status,
  });

  /// Check if the session has expired (24 hours)
  bool get isExpired => DateTime.now().difference(createdAt).inHours >= 24;

  /// Check if the session is active and can be used
  bool get isActive => !isExpired && status != KYCStatus.completed;

  /// Check if the user can start a new verification
  bool get canStartVerification =>
      status == KYCStatus.notStarted ||
      status == KYCStatus.failed ||
      status == KYCStatus.expired;

  /// Check if the verification is in progress
  bool get isInProgress => status == KYCStatus.inProgress;

  /// Check if the verification is completed successfully
  bool get isCompleted => status == KYCStatus.completed;

  /// Check if the verification is under review
  bool get isUnderReview => status == KYCStatus.underReview;

  /// Check if the verification failed
  bool get isFailed => status == KYCStatus.failed;

  @override
  List<Object?> get props => [sessionId, sessionToken, url, createdAt, status];

  /// Create a copy of this session with updated fields
  KYCSession copyWith({
    String? sessionId,
    String? sessionToken,
    String? url,
    DateTime? createdAt,
    KYCStatus? status,
  }) {
    return KYCSession(
      sessionId: sessionId ?? this.sessionId,
      sessionToken: sessionToken ?? this.sessionToken,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  /// Create a session from JSON data
  factory KYCSession.fromJson(Map<String, dynamic> json) {
    return KYCSession(
      sessionId: json['session_id'] as String,
      sessionToken: json['session_token'] as String,
      url: json['url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: KYCStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => KYCStatus.notStarted,
      ),
    );
  }

  /// Convert session to JSON data
  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'session_token': sessionToken,
      'url': url,
      'created_at': createdAt.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }
}
