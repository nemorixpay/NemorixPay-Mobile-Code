import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../repositories/wallet_repository.dart';

/// @file        seed_phrase_usecase.dart
/// @brief       Use case for creating a new seed phrase.
/// @details     Handles the business logic for creating a new seed phrase,
///              including error handling and repository interaction.
///              Returns Either type with Failure or List<String>.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.0
/// @copyright   Apache 2.0 License

class CreateSeedPhraseUseCase {
  final WalletRepository repository;

  CreateSeedPhraseUseCase({required this.repository});

  Future<Either<Failure, List<String>>> call() async {
    debugPrint('CreateSeedPhraseUseCase: Seed Phrase');
    return await repository.createSeedPhrase();
  }
}
