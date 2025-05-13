import 'package:equatable/equatable.dart';

/// @file        stellar_event.dart
/// @brief       Events for the Stellar feature bloc.
/// @details     This file contains all possible events for the Stellar feature.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class StellarEvent extends Equatable {
  const StellarEvent();

  @override
  List<Object?> get props => [];
}

class GenerateMnemonicEvent extends StellarEvent {
  final int strength;

  const GenerateMnemonicEvent({this.strength = 256});

  @override
  List<Object?> get props => [strength];
}

class CreateAccountEvent extends StellarEvent {
  final String mnemonic;
  final String passphrase;

  const CreateAccountEvent({required this.mnemonic, this.passphrase = ""});

  @override
  List<Object?> get props => [mnemonic, passphrase];
}

class GetAccountBalanceEvent extends StellarEvent {
  final String publicKey;

  const GetAccountBalanceEvent(this.publicKey);

  @override
  List<Object?> get props => [publicKey];
}

class SendPaymentEvent extends StellarEvent {
  final String sourceSecretKey;
  final String destinationPublicKey;
  final double amount;
  final String? memo;

  const SendPaymentEvent({
    required this.sourceSecretKey,
    required this.destinationPublicKey,
    required this.amount,
    this.memo,
  });

  @override
  List<Object?> get props => [
    sourceSecretKey,
    destinationPublicKey,
    amount,
    memo,
  ];
}

class ValidateTransactionEvent extends StellarEvent {
  final String transactionHash;

  const ValidateTransactionEvent(this.transactionHash);

  @override
  List<Object?> get props => [transactionHash];
}
