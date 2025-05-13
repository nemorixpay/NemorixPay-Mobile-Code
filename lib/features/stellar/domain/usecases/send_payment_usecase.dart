import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../entities/stellar_transaction.dart';
import '../repositories/stellar_repository.dart';

/// @file        send_payment_usecase.dart
/// @brief       Send payment use case for NemorixPay Stellar feature.
/// @details     This use case handles sending XLM payments between Stellar accounts.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class SendPaymentUseCase {
  final StellarRepository repository;

  SendPaymentUseCase({required this.repository});

  Future<Either<Failure, StellarTransaction>> call({
    required String sourceSecretKey,
    required String destinationPublicKey,
    required double amount,
    String? memo,
  }) async {
    debugPrint('SendPaymentUseCase');
    return await repository.sendPayment(
      sourceSecretKey: sourceSecretKey,
      destinationPublicKey: destinationPublicKey,
      amount: amount,
      memo: memo,
    );
  }
}
