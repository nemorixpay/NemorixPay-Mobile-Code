import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/stellar_repository.dart';

/// @file        generate_mnemonic_usecase.dart
/// @brief       Generate mnemonic use case for NemorixPay Stellar feature.
/// @details     This use case handles the generation of a new mnemonic phrase
///              for Stellar account creation.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class GenerateMnemonicUseCase {
  final StellarRepository repository;

  GenerateMnemonicUseCase({required this.repository});

  Future<Either<Failure, String>> call({int strength = 128}) async {
    debugPrint('GenerateMnemonicUseCase');
    return await repository.generateMnemonic(strength: strength);
  }
}
