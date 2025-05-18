import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../entities/stellar_account.dart';
import '../repositories/stellar_repository.dart';

/// @file        create_account_usecase.dart
/// @brief       Create account use case for NemorixPay Stellar feature.
/// @details     This use case handles the creation of a new Stellar account
///              from a mnemonic phrase.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class CreateAccountUseCase {
  final StellarRepository repository;

  CreateAccountUseCase({required this.repository});

  Future<Either<Failure, StellarAccount>> call({
    required String mnemonic,
    String passphrase = "",
  }) async {
    debugPrint('CreateAccountUseCase');
    return await repository.createAccount(
      mnemonic: mnemonic,
      passphrase: passphrase,
    );
  }
}
