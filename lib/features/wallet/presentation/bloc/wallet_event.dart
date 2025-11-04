import 'package:equatable/equatable.dart';

/// @file        wallet_event.dart
/// @brief       Defines the events for the Wallet Bloc
/// @details     Contains all possible events that can be triggered in the wallet feature,
///             including wallet creation, import, and balance retrieval operations.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.1
/// @copyright   Apache 2.0 License
abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

class CreateWalletRequested extends WalletEvent {
  final String mnemonic;
  const CreateWalletRequested(this.mnemonic);
}

class GenerateSeedPhraseRequested extends WalletEvent {
  const GenerateSeedPhraseRequested();
}

/// Event to create wallet directly without showing seed phrase
/// This event combines seed phrase generation, wallet creation, and public key saving
class CreateWalletDirectlyRequested extends WalletEvent {
  const CreateWalletDirectlyRequested();
}

class ImportWalletRequested extends WalletEvent {
  final String mnemonic;

  const ImportWalletRequested(this.mnemonic);

  @override
  List<Object?> get props => [mnemonic];
}

class GetWalletBalanceRequested extends WalletEvent {
  final String publicKey;

  const GetWalletBalanceRequested(this.publicKey);

  @override
  List<Object?> get props => [publicKey];
}

/// Event to save public key for the authenticated user
class SavePublicKeyRequested extends WalletEvent {
  final String publicKey;
  final String userId;

  const SavePublicKeyRequested({
    required this.publicKey,
    required this.userId,
  });

  @override
  List<Object?> get props => [publicKey, userId];
}
