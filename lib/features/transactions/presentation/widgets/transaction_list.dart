import 'package:flutter/material.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/transaction_list_item.dart';

/// @file        transaction_list.dart
/// @brief       Widget for displaying a list of transactions
/// @details     Handles transaction list display with pagination and empty states
/// @author      Miguel Fagundez
/// @date        08/29/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionList extends StatelessWidget {
  final List<TransactionListItemData> transactions;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback? onLoadMore;
  final Function(TransactionListItemData)? onTransactionTap;
  final String? emptyMessage;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const TransactionList({
    super.key,
    required this.transactions,
    this.isLoading = false,
    this.hasMore = false,
    this.onLoadMore,
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

    if (transactions.isEmpty && !isLoading) {
      return BuildEmptyState(
        emptyMessage: emptyMessage,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: transactions.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == transactions.length) {
          // Load more indicator
          return const BuildLoadMoreIndicator();
        }

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
            emptyMessage ?? 'No transactions found',
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
            errorMessage ?? 'Error loading transactions',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}

class BuildLoadMoreIndicator extends StatelessWidget {
  const BuildLoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Loading more...',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
