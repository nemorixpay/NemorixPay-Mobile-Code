import 'package:equatable/equatable.dart';
import '../../domain/entities/stellar_account.dart';
import '../../domain/entities/stellar_transaction.dart';

/// @file        stellar_state.dart
/// @brief       States for the Stellar feature bloc.
/// @details     This file contains all possible states for the Stellar feature.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class StellarState extends Equatable {
  const StellarState();

  @override
  List<Object?> get props => [];
}

class StellarInitial extends StellarState {}

class StellarLoading extends StellarState {}

class StellarError extends StellarState {
  final String message;

  const StellarError(this.message);

  @override
  List<Object?> get props => [message];
}

class MnemonicGenerated extends StellarState {
  final List<String> mnemonic;

  const MnemonicGenerated(this.mnemonic);

  @override
  List<Object?> get props => [mnemonic];
}

class AccountCreated extends StellarState {
  final StellarAccount account;

  const AccountCreated(this.account);

  @override
  List<Object?> get props => [account];
}

class BalanceUpdated extends StellarState {
  final StellarAccount account;

  const BalanceUpdated(this.account);

  @override
  List<Object?> get props => [account];
}

class PaymentSent extends StellarState {
  final StellarTransaction transaction;

  const PaymentSent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionValidated extends StellarState {
  final StellarTransaction transaction;

  const TransactionValidated(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
