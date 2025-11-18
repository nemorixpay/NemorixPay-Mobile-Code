import 'package:equatable/equatable.dart';
import 'package:nemorixpay/features/auth/domain/entities/user_entity.dart';

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
  final String countryCode;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.securityWord,
    required this.countryCode,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        firstName,
        lastName,
        birthDate,
        securityWord,
        countryCode,
      ];
}

/// Event to request user sign in
class SignInRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const SignInRequested({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
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

/// Event to request email verification
class SendVerificationEmailRequested extends AuthEvent {
  const SendVerificationEmailRequested();
}

/// Event to check email verification status
class CheckEmailVerificationStatus extends AuthEvent {
  const CheckEmailVerificationStatus();
}

/// Event to check if user has a wallet configured
class CheckWalletExists extends AuthEvent {
  final String userId;
  final UserEntity user;

  const CheckWalletExists({
    required this.userId,
    required this.user,
  });

  @override
  List<Object?> get props => [userId, user];
}

/// Event to determine post-authentication navigation based on wallet and terms status
class DeterminePostAuthNavigation extends AuthEvent {
  final String userId;
  final UserEntity user;

  const DeterminePostAuthNavigation({
    required this.userId,
    required this.user,
  });

  @override
  List<Object?> get props => [userId, user];
}
