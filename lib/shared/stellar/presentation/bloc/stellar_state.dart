import 'package:equatable/equatable.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';
import '../../domain/entities/stellar_account.dart';
import '../../domain/entities/stellar_transaction.dart';

/// @file        stellar_state.dart
/// @brief       States for the Stellar feature bloc.
/// @details     This file contains all possible states for the Stellar feature.
/// @author      Miguel Fagundez
/// @date        2025-05-21
/// @version     1.1
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
  final double balance;

  const BalanceUpdated(this.balance);

  @override
  List<Object?> get props => [balance];
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

/// State when an account has been successfully imported
class AccountImported extends StellarState {
  final StellarAccount account;

  const AccountImported(this.account);

  @override
  List<Object?> get props => [account];
}

/// State when assets are being loaded
class AssetsLoading extends StellarState {}

/// State when assets have been successfully loaded
class AssetsLoaded extends StellarState {
  final List<AssetEntity> assets;

  const AssetsLoaded(this.assets);

  @override
  List<Object?> get props => [assets];
}

/// State when available assets are being loaded
class AvailableAssetsLoading extends StellarState {}

/// State when available assets have been loaded successfully
class AvailableAssetsLoaded extends StellarState {
  final List<AssetEntity> assets;

  const AvailableAssetsLoaded(this.assets);

  @override
  List<Object?> get props => [assets];
}
