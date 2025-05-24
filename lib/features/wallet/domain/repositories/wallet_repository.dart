import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import '../entities/wallet.dart';

/// @file        wallet_repository.dart
/// @brief       Repository interface for wallet operations.
/// @details     Defines the contract for wallet-related operations in the
///              domain layer. Handles wallet creation, import, and balance
///              retrieval with proper error handling using Either type.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class WalletRepository {
  Future<Either<Failure, Wallet>> createWallet(String mnemonic);
  Future<Either<Failure, List<String>>> createSeedPhrase();
  Future<Either<Failure, Wallet>> importWallet(String mnemonic);
  Future<Either<Failure, double>> getWalletBalance(String publicKey);
}
