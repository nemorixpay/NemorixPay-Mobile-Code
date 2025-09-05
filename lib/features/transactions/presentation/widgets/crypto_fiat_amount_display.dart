import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';

/// @file        crypto_fiat_amount_display.dart
/// @brief       Widget for displaying crypto and fiat amounts
/// @details     Shows formatted amounts for both crypto and fiat currencies
/// @author      Miguel Fagundez
/// @date        08/29/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CryptoFiatAmountDisplay extends StatelessWidget {
  final TransactionListItemData transaction;
  final bool showFiat;
  final CrossAxisAlignment alignment;
  final double cryptoFontSize;
  final double fiatFontSize;

  const CryptoFiatAmountDisplay({
    super.key,
    required this.transaction,
    this.showFiat = true,
    this.alignment = CrossAxisAlignment.end,
    this.cryptoFontSize = 14.0,
    this.fiatFontSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Crypto amount
        Text(
          transaction.formattedAmount,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: cryptoFontSize,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),

        // Fiat amount
        if (showFiat && transaction.fiatAmount != null) ...[
          const SizedBox(height: 2),
          Text(
            transaction.formattedFiatAmount,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: fiatFontSize,
              color: NemorixColors.primaryTextGoldColor,
            ),
          ),
        ],
      ],
    );
  }
}
