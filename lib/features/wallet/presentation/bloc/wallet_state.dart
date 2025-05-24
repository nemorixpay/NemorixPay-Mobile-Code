import 'package:equatable/equatable.dart';
import 'package:nemorixpay/features/wallet/domain/entities/wallet.dart';

/// @file        wallet_state.dart
/// @brief       Defines the states for the Wallet Bloc
/// @details     Contains all possible states that the wallet feature can be in,
///             including initial, loading, success, and error states for various
///             wallet operations.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  final bool isSecondLoading;
  const WalletLoading({this.isSecondLoading = false});

  @override
  List<Object?> get props => [isSecondLoading];
}

class SeedPhraseCreated extends WalletState {
  final List<String> seedPhrase;

  const SeedPhraseCreated(this.seedPhrase);

  @override
  List<Object?> get props => [seedPhrase];
}

class WalletCreated extends WalletState {
  final Wallet wallet;

  const WalletCreated(this.wallet);

  @override
  List<Object?> get props => [wallet];
}

class WalletImported extends WalletState {
  final Wallet wallet;

  const WalletImported(this.wallet);

  @override
  List<Object?> get props => [wallet];
}

class WalletBalanceLoaded extends WalletState {
  final double balance;

  const WalletBalanceLoaded(this.balance);

  @override
  List<Object?> get props => [balance];
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object?> get props => [message];
}
