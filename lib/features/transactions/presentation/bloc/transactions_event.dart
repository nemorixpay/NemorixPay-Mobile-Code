import 'package:equatable/equatable.dart';

/// @file        transactions_event.dart
/// @brief       Events for the Transactions BLoC
/// @details     Defines all possible events that can be triggered in the Transactions feature
/// @author      Miguel Fagundez
/// @date        09/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

/// Base class for all transaction events
abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load transactions
class LoadTransactions extends TransactionsEvent {
  const LoadTransactions();
}

/// Event to refresh transactions
class RefreshTransactions extends TransactionsEvent {
  const RefreshTransactions();
}

/// Event to load more transactions (for pagination)
class LoadMoreTransactions extends TransactionsEvent {
  const LoadMoreTransactions();
}

/// Event to get details of a specific transaction
class GetTransactionDetails extends TransactionsEvent {
  final String transactionHash;

  const GetTransactionDetails({required this.transactionHash});

  @override
  List<Object?> get props => [transactionHash];
}

/// Event to filter transactions
class FilterTransactions extends TransactionsEvent {
  final String? searchQuery;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? type;

  const FilterTransactions({
    this.searchQuery,
    this.fromDate,
    this.toDate,
    this.type,
  });

  @override
  List<Object?> get props => [searchQuery, fromDate, toDate, type];
}
