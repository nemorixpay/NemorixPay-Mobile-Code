import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/features/transactions/data/mock/mock_transaction_data.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/transaction_list.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/search_bar_widget.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';

/// @file        transactions_page.dart
/// @brief       Main page for displaying transaction history
/// @details     Shows list of transactions with search and filtering capabilities
/// @author      Miguel Fagundez
/// @date        08/29/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionsPage extends StatefulWidget {
  final List<TransactionListItemData>? initialTransactions;
  final Function(TransactionListItemData)? onTransactionTap;
  final VoidCallback? onBackPressed;

  const TransactionsPage({
    super.key,
    this.initialTransactions,
    this.onTransactionTap,
    this.onBackPressed,
  });

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<TransactionListItemData> _transactions = [];
  List<TransactionListItemData> _filteredTransactions = [];
  bool _isLoading = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _transactions = widget.initialTransactions ??
            MockTransactionData.getMockTransactions();
        _filteredTransactions = _transactions;
        _isLoading = false;
      });
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredTransactions = _transactions;
      } else {
        _filteredTransactions = _transactions.where((transaction) {
          final searchLower = query.toLowerCase();
          return transaction.assetCode.toLowerCase().contains(searchLower) ||
              transaction.memo?.toLowerCase().contains(searchLower) == true ||
              transaction.displayId.toLowerCase().contains(searchLower) ||
              transaction.type.name.toLowerCase().contains(searchLower);
        }).toList();
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
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        // appBar: AppBar(
        //   backgroundColor: theme.appBarTheme.backgroundColor,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: Container(
        //       padding: const EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         color: theme.colorScheme.surface,
        //         borderRadius: BorderRadius.circular(12),
        //       ),
        //       child: Icon(
        //         Icons.arrow_back_ios_new,
        //         color: theme.colorScheme.onSurface,
        //         size: 20,
        //       ),
        //     ),
        //     onPressed: widget.onBackPressed ?? () => Navigator.of(context).pop(),
        //   ),
        //   title: Text(
        //     'Transaction History',
        //     style: theme.textTheme.titleLarge?.copyWith(
        //       fontWeight: FontWeight.w600,
        //       color: theme.colorScheme.onSurface,
        //     ),
        //   ),
        //   centerTitle: true,
        //   actions: [
        //     IconButton(
        //       icon: Container(
        //         padding: const EdgeInsets.all(8),
        //         decoration: BoxDecoration(
        //           color: theme.colorScheme.surface,
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: Icon(
        //           Icons.refresh,
        //           color: theme.colorScheme.onSurface,
        //           size: 20,
        //         ),
        //       ),
        //       onPressed: _onRefresh,
        //     ),
        //   ],
        // ),
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

            // Transaction list
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : TransactionList(
                      transactions: _filteredTransactions,
                      onTransactionTap: _onTransactionTap,
                      emptyMessage: _searchQuery.isNotEmpty
                          ? appLocalizations
                              .noTransactionsFoundFor(_searchQuery)
                          : appLocalizations.noTransactionsFound,
                      // TODO:
                      // This errorMessage behavior needs to be changed
                      errorMessage: null,
                      onRetry: _loadTransactions,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
