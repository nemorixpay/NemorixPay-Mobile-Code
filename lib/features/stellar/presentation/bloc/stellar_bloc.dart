import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_account_usecase.dart';
import '../../domain/usecases/generate_mnemonic_usecase.dart';
import '../../domain/usecases/get_account_balance_usecase.dart';
import '../../domain/usecases/send_payment_usecase.dart';
import '../../domain/usecases/validate_transaction_usecase.dart';
import 'stellar_event.dart';
import 'stellar_state.dart';

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

  StellarBloc({
    required this.generateMnemonicUseCase,
    required this.createAccountUseCase,
    required this.getAccountBalanceUseCase,
    required this.sendPaymentUseCase,
    required this.validateTransactionUseCase,
  }) : super(StellarInitial()) {
    on<GenerateMnemonicEvent>(_onGenerateMnemonic);
    on<CreateAccountEvent>(_onCreateAccount);
    on<GetAccountBalanceEvent>(_onGetAccountBalance);
    on<SendPaymentEvent>(_onSendPayment);
    on<ValidateTransactionEvent>(_onValidateTransaction);
  }

  Future<void> _onGenerateMnemonic(
    GenerateMnemonicEvent event,
    Emitter<StellarState> emit,
  ) async {
    emit(StellarLoading());
    final result = await generateMnemonicUseCase(strength: event.strength);
    result.fold(
      (failure) => emit(StellarError(failure.message)),
      (mnemonic) => emit(MnemonicGenerated(mnemonic)),
    );
  }

  Future<void> _onCreateAccount(
    CreateAccountEvent event,
    Emitter<StellarState> emit,
  ) async {
    emit(StellarLoading());
    final result = await createAccountUseCase(
      mnemonic: event.mnemonic,
      passphrase: event.passphrase,
    );
    result.fold(
      (failure) => emit(StellarError(failure.message)),
      (account) => emit(AccountCreated(account)),
    );
  }

  Future<void> _onGetAccountBalance(
    GetAccountBalanceEvent event,
    Emitter<StellarState> emit,
  ) async {
    emit(StellarLoading());
    final result = await getAccountBalanceUseCase(event.publicKey);
    result.fold(
      (failure) => emit(StellarError(failure.message)),
      (account) => emit(BalanceUpdated(account)),
    );
  }

  Future<void> _onSendPayment(
    SendPaymentEvent event,
    Emitter<StellarState> emit,
  ) async {
    emit(StellarLoading());
    final result = await sendPaymentUseCase(
      sourceSecretKey: event.sourceSecretKey,
      destinationPublicKey: event.destinationPublicKey,
      amount: event.amount,
      memo: event.memo,
    );
    result.fold(
      (failure) => emit(StellarError(failure.message)),
      (transaction) => emit(PaymentSent(transaction)),
    );
  }

  Future<void> _onValidateTransaction(
    ValidateTransactionEvent event,
    Emitter<StellarState> emit,
  ) async {
    emit(StellarLoading());
    final result = await validateTransactionUseCase(event.transactionHash);
    result.fold(
      (failure) => emit(StellarError(failure.message)),
      (transaction) => emit(TransactionValidated(transaction)),
    );
  }
}
