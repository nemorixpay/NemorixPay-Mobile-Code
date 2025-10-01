import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/di/services/transactions_injection_service.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/transaction_list.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/search_bar_widget.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';
import 'package:nemorixpay/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:nemorixpay/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:nemorixpay/features/transactions/presentation/bloc/transactions_state.dart';

/// @file        transactions_page.dart
/// @brief       Main page for displaying transaction history
/// @details     Shows list of transactions with search and filtering capabilities
/// @author      Miguel Fagundez
/// @date        09/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionsPage extends StatefulWidget {
  final Function(TransactionListItemData)? onTransactionTap;
  final VoidCallback? onBackPressed;

  const TransactionsPage({
    super.key,
    this.onTransactionTap,
    this.onBackPressed,
  });

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<TransactionListItemData> _filteredTransactions = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load transactions when the page initializes
    context.read<TransactionsBloc>().add(const LoadTransactions());
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredTransactions = [];
      } else {
        // Filter transactions based on search query
        final currentState = context.read<TransactionsBloc>().state;
        if (currentState is TransactionsLoaded) {
          _filteredTransactions =
              currentState.transactions.where((transaction) {
            final searchLower = query.toLowerCase();
            return transaction.assetCode.toLowerCase().contains(searchLower) ||
                transaction.memo?.toLowerCase().contains(searchLower) == true ||
                transaction.displayId.toLowerCase().contains(searchLower) ||
                transaction.type.name.toLowerCase().contains(searchLower);
          }).toList();
        }
      }
    });
  }

  void _onTransactionTap(TransactionListItemData transaction) {
    final appLocalizations = AppLocalizations.of(context)!;
    widget.onTransactionTap?.call(transaction);
    // TODO: Navigate to transaction detail page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(appLocalizations.transactionId(transaction.displayId)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onRefresh() {
    context.read<TransactionsBloc>().add(const RefreshTransactions());
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) {
        final bloc = di<TransactionsBloc>();
        // Trigger initial load
        bloc.add(const LoadTransactions());
        return bloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              MainHeader(
                title: appLocalizations.transactionHistory,
                showBackButton: true,
                showSearchButton: false,
              ),
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchBarWidget(
                  hintText: appLocalizations.searchTransactions,
                  onChanged: _onSearchChanged,
                  onClear: () => _onSearchChanged(''),
                ),
              ),

              // Transaction list with BLoC
              Expanded(
                child: BlocBuilder<TransactionsBloc, TransactionsState>(
                  builder: (context, state) {
                    // Determine which transactions to show
                    List<TransactionListItemData> transactionsToShow = [];
                    String? emptyMessage;
                    String? errorMessage;
                    VoidCallback? onRetry;

                    if (state is TransactionsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TransactionsRefreshing) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TransactionsLoaded) {
                      transactionsToShow = _searchQuery.isEmpty
                          ? state.transactions
                          : _filteredTransactions;
                      emptyMessage = _searchQuery.isNotEmpty
                          ? appLocalizations
                              .noTransactionsFoundFor(_searchQuery)
                          : appLocalizations.noTransactionsFound;
                    } else if (state is TransactionsEmpty) {
                      transactionsToShow = [];
                      emptyMessage = state.message;
                    } else if (state is TransactionsError) {
                      transactionsToShow = state.currentTransactions ?? [];
                      errorMessage = state.message;
                      onRetry = () => context
                          .read<TransactionsBloc>()
                          .add(const LoadTransactions());
                    } else {
                      // Initial state - show loading
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return TransactionList(
                      transactions: transactionsToShow,
                      onTransactionTap: _onTransactionTap,
                      emptyMessage: emptyMessage,
                      errorMessage: errorMessage,
                      onRetry: onRetry,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
