import 'package:equatable/equatable.dart';

/// @file        stellar_asset.dart
/// @brief       Entity representing a Stellar asset.
/// @details     This class defines the structure for Stellar assets,
///              including essential information like code, balance, and type.
///              It extends Equatable for value comparison.
/// @author      Miguel Fagundez
/// @date        2025-05-17
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarAsset extends Equatable {
  final String code;
  final double balance;
  final String type;

  const StellarAsset({
    required this.code,
    required this.balance,
    required this.type,
  });

  @override
  List<Object?> get props => [code, balance, type];

  StellarAsset copyWith({String? code, double? balance, String? type}) {
    return StellarAsset(
      code: code ?? this.code,
      balance: balance ?? this.balance,
      type: type ?? this.type,
    );
  }
}
