import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';

/// @file        transaction_status_badge.dart
/// @brief       Widget for displaying transaction status badges
/// @details     Shows status with appropriate colors and styling
/// @author      Miguel Fagundez
/// @date        08/29/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionStatusBadge extends StatelessWidget {
  final TransactionStatus status;
  final bool showIcon;
  final double fontSize;

  const TransactionStatusBadge({
    super.key,
    required this.status,
    this.showIcon = false,
    this.fontSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color textColor;
    String statusText;

    switch (status) {
      case TransactionStatus.confirmed:
        textColor = NemorixColors.successTextColor;
        statusText = 'Confirmed';
        break;
      case TransactionStatus.failed:
        textColor = NemorixColors.errorColor;
        statusText = 'Failed';
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Icon(
            status == TransactionStatus.confirmed
                ? Icons.check_circle
                : Icons.error_rounded,
            size: fontSize,
            color: textColor,
          ),
          const SizedBox(width: 4),
        ],
        Text(
          statusText,
          style: theme.textTheme.labelSmall?.copyWith(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
