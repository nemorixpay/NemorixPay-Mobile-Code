import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nemorixpay/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:nemorixpay/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:nemorixpay/features/transactions/presentation/bloc/transactions_state.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';

/// @file        transactions_bloc.dart
/// @brief       BLoC for managing transaction state and business logic
/// @details     Handles all transaction-related operations including loading,
///              refreshing, and filtering transactions using Clean Architecture
/// @author      Miguel Fagundez
/// @date        09/12/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  // UseCases
  final GetTransactionsUseCase _getTransactionsUseCase;

  TransactionsBloc({
    required GetTransactionsUseCase getTransactionsUseCase,
  })  : _getTransactionsUseCase = getTransactionsUseCase,
        super(const TransactionsInitial()) {
    // Register event handlers
    on<LoadTransactions>(_onLoadTransactions);
  }

  /// Handles loading transactions
  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    debugPrint('TransactionsBloc: _onLoadTransactions - Starting');

    try {
      emit(const TransactionsLoading());

      // Check if user is authenticated
      final StellarAccountProvider accountProvider = StellarAccountProvider();
      final currentAccount = accountProvider.currentAccount;
      if (currentAccount == null || currentAccount.publicKey == null) {
        debugPrint(
            'TransactionsBloc: _onLoadTransactions - No authenticated account found');
        emit(const TransactionsError(
          message: 'Please log in to view your transaction history',
        ));
        return;
      }

      debugPrint(
          'TransactionsBloc: _onLoadTransactions - Account found: ${currentAccount.publicKey}');

      // Use the UseCase to get transactions
      final result = await _getTransactionsUseCase();

      result.fold(
        (failure) {
          debugPrint(
              'TransactionsBloc: _onLoadTransactions - Error: ${failure.message}');
          emit(TransactionsError(message: failure.message));
        },
        (transactions) {
          debugPrint(
              'TransactionsBloc: _onLoadTransactions - Found ${transactions.length} transactions');

          if (transactions.isEmpty) {
            emit(const TransactionsEmpty(
              message: 'No transactions found',
            ));
          } else {
            emit(TransactionsLoaded(
              transactions: transactions,
              hasMore: false, // TODO: Implement pagination
              nextCursor: null,
            ));
          }
        },
      );
    } catch (e) {
      debugPrint('TransactionsBloc: _onLoadTransactions - Exception: $e');
      emit(TransactionsError(message: 'Unexpected error: $e'));
    }
  }
}
