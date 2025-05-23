import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import '../../domain/usecases/create_account_usecase.dart';
import '../../domain/usecases/generate_mnemonic_usecase.dart';
import '../../domain/usecases/get_account_balance_usecase.dart';
import '../../domain/usecases/send_payment_usecase.dart';
import '../../domain/usecases/validate_transaction_usecase.dart';
import '../../domain/usecases/import_account_usecase.dart';
import '../../domain/usecases/get_account_assets_usecase.dart';
import '../../domain/usecases/get_available_assets_usecase.dart';
import 'stellar_event.dart';
import 'stellar_state.dart';
import 'package:flutter/foundation.dart';

/// @file        stellar_bloc.dart
/// @brief       Bloc implementation for the Stellar feature.
/// @details     This file contains the implementation of the Stellar feature bloc.
/// @author      Miguel Fagundez
/// @date        2025-05-12
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarBloc extends Bloc<StellarEvent, StellarState> {
  final GenerateMnemonicUseCase generateMnemonicUseCase;
  final CreateAccountUseCase createAccountUseCase;
  final GetAccountBalanceUseCase getAccountBalanceUseCase;
  final SendPaymentUseCase sendPaymentUseCase;
  final ValidateTransactionUseCase validateTransactionUseCase;
  final ImportAccountUseCase importAccountUseCase;
  final GetAccountAssetsUseCase getAccountAssetsUseCase;
  final GetAvailableAssetsUseCase getAvailableAssetsUseCase;

  StellarBloc({
    required this.generateMnemonicUseCase,
    required this.createAccountUseCase,
    required this.getAccountBalanceUseCase,
    required this.sendPaymentUseCase,
    required this.validateTransactionUseCase,
    required this.importAccountUseCase,
    required this.getAccountAssetsUseCase,
    required this.getAvailableAssetsUseCase,
  }) : super(StellarInitial()) {
    on<GenerateMnemonicEvent>(_onGenerateMnemonic);
    on<CreateAccountEvent>(_onCreateAccount);
    on<GetAccountBalanceEvent>(_onGetAccountBalance);
    on<SendPaymentEvent>(_onSendPayment);
    on<ValidateTransactionEvent>(_onValidateTransaction);
    on<ImportAccountEvent>(_onImportAccount);
    on<GetAccountAssetsEvent>(_onGetAccountAssets);
    on<GetAvailableAssetsEvent>(_onGetAvailableAssets);
  }

  Future<void> _onGenerateMnemonic(
    GenerateMnemonicEvent event,
    Emitter<StellarState> emit,
  ) async {
    debugPrint(
      'StellarBloc: _onGenerateMnemonic - Iniciando generación de mnemonic',
    );
    debugPrint(
      'StellarBloc: _onGenerateMnemonic - Strength: ${event.strength}',
    );
    emit(StellarLoading());
    final result = await generateMnemonicUseCase(strength: event.strength);
    result.fold(
      (failure) {
        debugPrint(
          'StellarBloc: _onGenerateMnemonic - Error: ${failure.message}',
        );
        debugPrint(
          'StellarBloc: _onGenerateMnemonic - Código: ${failure.code}',
        );
        emit(StellarError(failure.message));
      },
      (mnemonicWords) {
        debugPrint(
          'StellarBloc: _onGenerateMnemonic - Mnemonic generado exitosamente',
        );
        debugPrint(
          'StellarBloc: _onGenerateMnemonic - Palabras: ${mnemonicWords.join(" ")}',
        );
        emit(MnemonicGenerated(mnemonicWords));
      },
    );
  }

  Future<void> _onCreateAccount(
    CreateAccountEvent event,
    Emitter<StellarState> emit,
  ) async {
    debugPrint('StellarBloc: _onCreateAccount - Iniciando creación de cuenta');
    debugPrint('StellarBloc: _onCreateAccount - Mnemonic: ${event.mnemonic}');
    debugPrint(
      'StellarBloc: _onCreateAccount - Passphrase: ${event.passphrase}',
    );
    emit(StellarLoading());
    final result = await createAccountUseCase(
      mnemonic: event.mnemonic,
      passphrase: event.passphrase,
    );
    result.fold(
      (failure) {
        debugPrint('StellarBloc: _onCreateAccount - Error: ${failure.message}');
        debugPrint('StellarBloc: _onCreateAccount - Código: ${failure.code}');
        emit(StellarError(failure.message));
      },
      (account) {
        debugPrint(
          'StellarBloc: _onCreateAccount - Cuenta creada exitosamente',
        );
        debugPrint(
          'StellarBloc: _onCreateAccount - PublicKey: ${account.publicKey}',
        );
        debugPrint(
          'StellarBloc: _onCreateAccount - Balance: ${account.balance}',
        );
        emit(AccountCreated(account));
      },
    );
  }

  Future<void> _onGetAccountBalance(
    GetAccountBalanceEvent event,
    Emitter<StellarState> emit,
  ) async {
    debugPrint('StellarBloc: _onGetAccountBalance - Consultando balance');
    debugPrint(
      'StellarBloc: _onGetAccountBalance - PublicKey: ${event.publicKey}',
    );
    emit(StellarLoading());
    final result = await getAccountBalanceUseCase(event.publicKey);
    result.fold(
      (failure) {
        debugPrint(
          'StellarBloc: _onGetAccountBalance - Error: ${failure.message}',
        );
        debugPrint(
          'StellarBloc: _onGetAccountBalance - Código: ${failure.code}',
        );
        emit(StellarError(failure.message));
      },
      (balance) {
        debugPrint(
          'StellarBloc: _onGetAccountBalance - Balance obtenido: $balance',
        );
        emit(BalanceUpdated(balance));
      },
    );
  }

  Future<void> _onSendPayment(
    SendPaymentEvent event,
    Emitter<StellarState> emit,
  ) async {
    debugPrint('StellarBloc: _onSendPayment - Iniciando envío de pago');
    debugPrint(
      'StellarBloc: _onSendPayment - Destino: ${event.destinationPublicKey}',
    );
    debugPrint('StellarBloc: _onSendPayment - Monto: ${event.amount}');
    debugPrint('StellarBloc: _onSendPayment - Memo: ${event.memo}');
    emit(StellarLoading());
    final result = await sendPaymentUseCase(
      sourceSecretKey: event.sourceSecretKey,
      destinationPublicKey: event.destinationPublicKey,
      amount: event.amount,
      memo: event.memo,
    );
    result.fold(
      (failure) {
        debugPrint('StellarBloc: _onSendPayment - Error: ${failure.message}');
        debugPrint('StellarBloc: _onSendPayment - Código: ${failure.code}');
        emit(StellarError(failure.message));
      },
      (transaction) {
        debugPrint('StellarBloc: _onSendPayment - Pago enviado exitosamente');
        debugPrint('StellarBloc: _onSendPayment - Hash: ${transaction.hash}');
        debugPrint(
          'StellarBloc: _onSendPayment - Estado: ${transaction.successful}',
        );
        emit(PaymentSent(transaction));
      },
    );
  }

  Future<void> _onValidateTransaction(
    ValidateTransactionEvent event,
    Emitter<StellarState> emit,
  ) async {
    debugPrint('StellarBloc: _onValidateTransaction - Validando transacción');
    debugPrint(
      'StellarBloc: _onValidateTransaction - Hash: ${event.transactionHash}',
    );
    emit(StellarLoading());
    final result = await validateTransactionUseCase(event.transactionHash);
    result.fold(
      (failure) {
        debugPrint(
          'StellarBloc: _onValidateTransaction - Error: ${failure.message}',
        );
        debugPrint(
          'StellarBloc: _onValidateTransaction - Código: ${failure.code}',
        );
        emit(StellarError(failure.message));
      },
      (transaction) {
        debugPrint(
          'StellarBloc: _onValidateTransaction - Transacción validada',
        );
        debugPrint(
          'StellarBloc: _onValidateTransaction - Estado: ${transaction.successful}',
        );
        debugPrint(
          'StellarBloc: _onValidateTransaction - Ledger: ${transaction.ledger}',
        );
        emit(TransactionValidated(transaction));
      },
    );
  }

  Future<void> _onImportAccount(
    ImportAccountEvent event,
    Emitter<StellarState> emit,
  ) async {
    debugPrint(
      'StellarBloc: _onImportAccount - Iniciando importación de cuenta',
    );
    debugPrint('StellarBloc: _onImportAccount - Mnemonic: ${event.mnemonic}');
    debugPrint(
      'StellarBloc: _onImportAccount - Passphrase: ${event.passphrase}',
    );
    emit(StellarLoading());
    try {
      final result = await importAccountUseCase(
        mnemonic: event.mnemonic,
        passphrase: event.passphrase,
      );
      result.fold(
        (failure) {
          debugPrint(
            'StellarBloc: _onImportAccount - Error: ${failure.message}',
          );
          debugPrint('StellarBloc: _onImportAccount - Código: ${failure.code}');
          emit(StellarError(failure.message));
        },
        (account) {
          debugPrint(
            'StellarBloc: _onImportAccount - Cuenta importada exitosamente',
          );
          debugPrint(
            'StellarBloc: _onImportAccount - PublicKey: ${account.publicKey}',
          );
          debugPrint(
            'StellarBloc: _onImportAccount - Balance: ${account.balance}',
          );
          emit(AccountImported(account));
        },
      );
    } catch (e) {
      debugPrint('StellarBloc: _onImportAccount - Error inesperado: $e');
      if (e is StellarFailure) {
        emit(StellarError(e.message));
      } else {
        emit(StellarError('Unexpected error. Try again!'));
      }
    }
  }

  Future<void> _onGetAccountAssets(
    GetAccountAssetsEvent event,
    Emitter<StellarState> emit,
  ) async {
    debugPrint(
      'StellarBloc: _onGetAccountAssets - Iniciando obtención de assets',
    );
    debugPrint(
      'StellarBloc: _onGetAccountAssets - PublicKey: ${event.publicKey}',
    );
    emit(AssetsLoading());
    try {
      final result = await getAccountAssetsUseCase(event.publicKey);
      result.fold(
        (failure) {
          debugPrint(
            'StellarBloc: _onGetAccountAssets - Error: ${failure.message}',
          );
          debugPrint(
            'StellarBloc: _onGetAccountAssets - Código: ${failure.code}',
          );
          emit(StellarError(failure.message));
        },
        (assets) {
          debugPrint(
            'StellarBloc: _onGetAccountAssets - Assets obtenidos exitosamente',
          );
          debugPrint(
            'StellarBloc: _onGetAccountAssets - Cantidad de assets: ${assets.length}',
          );
          emit(AssetsLoaded(assets));
        },
      );
    } catch (e) {
      debugPrint('StellarBloc: _onGetAccountAssets - Error inesperado: $e');
      if (e is StellarFailure) {
        emit(StellarError(e.message));
      } else {
        emit(StellarError('Unexpected error. Try again!'));
      }
    }
  }

  Future<void> _onGetAvailableAssets(
    GetAvailableAssetsEvent event,
    Emitter<StellarState> emit,
  ) async {
    debugPrint('StellarBloc: _onGetAvailableAssets - Getting available assets');
    emit(AvailableAssetsLoading());
    try {
      final result = await getAvailableAssetsUseCase();
      result.fold(
        (failure) {
          debugPrint(
            'StellarBloc: _onGetAvailableAssets - Error (Message): ${failure.message}',
          );
          debugPrint(
            'StellarBloc: _onGetAvailableAssets - Error (Code): ${failure.code}',
          );
          emit(StellarError(failure.message));
        },
        (assets) {
          debugPrint(
            'StellarBloc: _onGetAvailableAssets - Assets loaded successfully',
          );
          debugPrint(
            'StellarBloc: _onGetAvailableAssets - Assets count: ${assets.length}',
          );
          emit(AvailableAssetsLoaded(assets));
        },
      );
    } catch (e) {
      debugPrint('StellarBloc: _onGetAvailableAssets - Unexpected error: $e');
      if (e is StellarFailure) {
        emit(StellarError(e.message));
      } else {
        emit(StellarError('Unexpected error. Try again!'));
      }
    }
  }
}
