import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/shared/stellar/data/repositories/stellar_repository_impl.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_account.dart';
import 'package:nemorixpay/shared/stellar/domain/repositories/stellar_repository.dart';

/// @file        import_account_usecase.dart
/// @brief       Use case for importing a Stellar account.
/// @details     This use case handles the business logic for importing an existing
///              Stellar account using a mnemonic phrase.
/// @author      Miguel Fagundez
/// @date        2025-05-13
/// @version     1.0
/// @copyright   Apache 2.0 License

class ImportAccountUseCase {
  final StellarRepository repository;

  ImportAccountUseCase({required this.repository});

  Future<Either<Failure, StellarAccount>> call({
    required String mnemonic,
    String passphrase = "",
  }) async {
    return await repository.importAccount(
      mnemonic: mnemonic,
      passphrase: passphrase,
    );
  }
}
