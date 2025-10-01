import 'package:flutter/material.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/transaction_list_item.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        transaction_list.dart
/// @brief       Widget for displaying a list of transactions
/// @details     Handles transaction list display with empty and error states
/// @author      Miguel Fagundez
/// @date        09/10/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

class TransactionList extends StatelessWidget {
  final List<TransactionListItemData> transactions;
  final Function(TransactionListItemData)? onTransactionTap;
  final String? emptyMessage;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const TransactionList({
    super.key,
    required this.transactions,
    this.onTransactionTap,
    this.emptyMessage,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return BuildErrorState(
        errorMessage: errorMessage,
        onRetry: onRetry,
      );
    }

    if (transactions.isEmpty) {
      return BuildEmptyState(
        emptyMessage: emptyMessage,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionListItem(
          transaction: transaction,
          onTap: onTransactionTap != null
              ? () => onTransactionTap!(transaction)
              : null,
        );
      },
    );
  }
}

class BuildEmptyState extends StatelessWidget {
  final String? emptyMessage;

  const BuildEmptyState({super.key, this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            emptyMessage ?? appLocalizations.noTransactionsFound,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BuildErrorState extends StatelessWidget {
  final String? errorMessage;
  final Function()? onRetry;

  const BuildErrorState({
    super.key,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.error.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? appLocalizations.errorLoadingTransactions,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(appLocalizations.retry),
            ),
          ],
        ],
      ),
    );
  }
}
