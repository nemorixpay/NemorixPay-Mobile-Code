import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

/// @file        import_wallet.dart
/// @brief       Use case for importing an existing wallet.
/// @details     Handles the business logic for importing a wallet using
///              a mnemonic phrase, including error handling and repository
///              interaction. Returns Either type with Failure or Wallet entity.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

class ImportWallet {
  final WalletRepository repository;

  ImportWallet({required this.repository});

  Future<Either<Failure, Wallet>> call(String mnemonic) async {
    debugPrint('ImportWallet');
    return await repository.importWallet(mnemonic);
  }
}
