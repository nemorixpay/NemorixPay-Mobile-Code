import 'package:equatable/equatable.dart';

/// @file        crypto_account_event.dart
/// @brief       Events for the CryptoAccountBloc.
/// @details     Defines all possible events that can be triggered in the crypto market feature (account assets only).
/// @author      Miguel Fagundez
/// @date        06/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class CryptoAccountEvent extends Equatable {
  const CryptoAccountEvent();

  @override
  List<Object?> get props => [];
}

class GetCryptoAccountAssets extends CryptoAccountEvent {
  const GetCryptoAccountAssets();
}

class GetCryptoAccountAssetDetails extends CryptoAccountEvent {
  final String symbol;

  const GetCryptoAccountAssetDetails(this.symbol);

  @override
  List<Object?> get props => [symbol];
}
