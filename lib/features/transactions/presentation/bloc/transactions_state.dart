import 'package:equatable/equatable.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_transaction.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';

/// @file        transactions_state.dart
/// @brief       States for the Transactions BLoC
/// @details     Defines all possible states for the Transactions feature
/// @author      Miguel Fagundez
/// @date        09/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

/// Base class for all transaction states
abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the BLoC is first created
class TransactionsInitial extends TransactionsState {
  const TransactionsInitial();
}

/// State when transactions are being loaded
class TransactionsLoading extends TransactionsState {
  const TransactionsLoading();
}

/// State when transactions are being refreshed
class TransactionsRefreshing extends TransactionsState {
  final List<TransactionListItemData> currentTransactions;

  const TransactionsRefreshing({required this.currentTransactions});

  @override
  List<Object?> get props => [currentTransactions];
}

/// State when transactions are loaded successfully
class TransactionsLoaded extends TransactionsState {
  final List<TransactionListItemData> transactions;
  final bool hasMore;
  final String? nextCursor;

  const TransactionsLoaded({
    required this.transactions,
    this.hasMore = false,
    this.nextCursor,
  });

  @override
  List<Object?> get props => [transactions, hasMore, nextCursor];
}

/// State when transaction details are loaded
class TransactionDetailsLoaded extends TransactionsState {
  final StellarTransaction transaction;
  final TransactionListItemData transactionData;

  const TransactionDetailsLoaded({
    required this.transaction,
    required this.transactionData,
  });

  @override
  List<Object?> get props => [transaction, transactionData];
}

/// State when there's an error
class TransactionsError extends TransactionsState {
  final String message;
  final List<TransactionListItemData>? currentTransactions;

  const TransactionsError({
    required this.message,
    this.currentTransactions,
  });

  @override
  List<Object?> get props => [message, currentTransactions];
}

/// State when no transactions are found
class TransactionsEmpty extends TransactionsState {
  final String message;

  const TransactionsEmpty({required this.message});

  @override
  List<Object?> get props => [message];
}
