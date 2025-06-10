import 'package:equatable/equatable.dart';

/// @file        crypto_home_event.dart
/// @brief       Events for the CryptoHomeBloc.
/// @details     Defines all possible events that can be triggered in the crypto market feature (Home page only).
/// @author      Miguel Fagundez
/// @date        06/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class CryptoHomeEvent extends Equatable {
  const CryptoHomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllCryptoData extends CryptoHomeEvent {
  const LoadAllCryptoData();
}
