import 'package:flutter/material.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/crypto_fiat_amount_display.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/transaction_date_display.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/transaction_status_badge.dart';
import 'package:nemorixpay/features/transactions/presentation/widgets/transaction_type_icon.dart';

/// @file        transaction_list_item.dart
/// @brief       Main widget for displaying a single transaction item
/// @details     Combines all transaction display widgets into one cohesive item
/// @author      Miguel Fagundez
/// @date        08/29/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionListItem extends StatelessWidget {
  final TransactionListItemData transaction;
  final VoidCallback? onTap;
  final bool showStatus;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onTap,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Transaction type icon
              TransactionTypeIcon(
                type: transaction.type,
                size: 28,
              ),

              const SizedBox(width: 8),

              // Transaction details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date and ID
                    TransactionDateDisplay(
                      date: transaction.createdAt,
                      prefix: transaction.displayId,
                    ),

                    const SizedBox(height: 4),

                    // Transaction type and asset
                    Row(
                      children: [
                        Text(
                          transaction.type == TransactionType.send
                              ? 'Send'
                              : 'Receive',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          transaction.assetCode,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),

                    // Status badge
                    if (showStatus) ...[
                      const SizedBox(height: 8),
                      TransactionStatusBadge(
                        status: transaction.status,
                        showIcon: true,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Amount display
              CryptoFiatAmountDisplay(
                transaction: transaction,
                showFiat: true,
                alignment: CrossAxisAlignment.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
