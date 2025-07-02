import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/features/crypto/domain/repositories/crypto_market_repository.dart';

/// @file        send_stellar_transaction_usecase.dart
/// @brief       Send a stellar transaction in the NemorixPay Crypto feature.
/// @details     This use case handles the basic transaction of native asset in the stellar network.
/// @author      Miguel Fagundez
/// @date        06/30/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class SendStellarTransactionUseCase {
  final CryptoMarketRepository repository;

  SendStellarTransactionUseCase({required this.repository});

  /// Gets market data
  /// @return Either<Failure, String> transaction hash or error
  Future<Either<Failure, String>> call(
      String publicKey, double amount, String? note) async {
    debugPrint(
        'SendStellarTransactionUseCase: Send stellar transaction use case');
    return await repository.sentTransaction(publicKey, amount, note);
  }
}
