import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/stellar_account.dart';
import '../entities/stellar_transaction.dart';

/// @file        stellar_repository.dart
/// @brief       Repository interface for Stellar network operations.
/// @details     Defines the contract for Stellar network operations including
///              account management and transaction handling.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class StellarRepository {
  /// Generates a mnemonic phrase for account creation
  /// @param strength Strength of the mnemonic phrase (128 for 12 words, 256 for 24 words)
  /// @return Either<Failure, List<String>> List of mnemonic words or error
  Future<Either<Failure, List<String>>> generateMnemonic({int strength = 256});

  /// Creates a new Stellar account from a mnemonic phrase
  Future<Either<Failure, StellarAccount>> createAccount({
    required String mnemonic,
    String passphrase = "",
  });

  /// Gets the current balance of a Stellar account
  Future<Either<Failure, StellarAccount>> getAccountBalance(String publicKey);

  /// Sends XLM from one account to another
  Future<Either<Failure, StellarTransaction>> sendPayment({
    required String sourceSecretKey,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  });

  /// Validates a transaction by its hash
  Future<Either<Failure, StellarTransaction>> validateTransaction(
    String transactionHash,
  );
}
