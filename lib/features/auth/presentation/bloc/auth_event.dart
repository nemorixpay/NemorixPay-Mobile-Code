import 'package:equatable/equatable.dart';

/// @file        auth_event.dart
/// @brief       Authentication events for NemorixPay auth feature.
/// @details     This file contains all the possible events for the authentication BLoC.
/// @author      Miguel Fagundez
/// @date        2025-05-07
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class AuthEvent extends Equatable {
  /// Base class for all authentication events
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to request user registration
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String securityWord;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.securityWord,
  });

  @override
  List<Object?> get props => [
    email,
    password,
    firstName,
    lastName,
    birthDate,
    securityWord,
  ];
}

/// Event to request user sign in
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Event to request user sign out
class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

/// Event to check current authentication status
class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

/// Event to request password recovery
class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}
