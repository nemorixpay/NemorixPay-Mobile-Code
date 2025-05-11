import 'package:equatable/equatable.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';

/// @file        auth_state.dart
/// @brief       Authentication states for NemorixPay auth feature.
/// @details     This file contains all the possible states for the authentication BLoC.
/// @author      Miguel Fagundez
/// @date        2025-05-06
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class AuthState extends Equatable {
  /// Base class for all authentication states
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the BLoC is created
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State when an authentication operation is in progress
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State when the user is authenticated
class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// State when the user is not authenticated
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// State when an error occurs during authentication
class AuthError extends AuthState {
  final Failure error;

  const AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

/// State when password recovery is in progress
class ForgotPasswordLoading extends AuthState {
  const ForgotPasswordLoading();
}

/// State when password recovery is successful
class ForgotPasswordSuccess extends AuthState {
  const ForgotPasswordSuccess();
}

/// State when password recovery fails
class ForgotPasswordError extends AuthState {
  final String message;

  const ForgotPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when the user's email is not verified
class EmailNotVerified extends AuthState {
  final UserEntity user;

  const EmailNotVerified(this.user);

  @override
  List<Object?> get props => [user];
}

/// State when verification email is being sent
class VerificationEmailSending extends AuthState {
  const VerificationEmailSending();
}

/// State when verification email has been sent
class VerificationEmailSent extends AuthState {
  const VerificationEmailSent();
}

/// State when verification email fails to send
class VerificationEmailError extends AuthState {
  final String message;

  const VerificationEmailError(this.message);

  @override
  List<Object?> get props => [message];
}
