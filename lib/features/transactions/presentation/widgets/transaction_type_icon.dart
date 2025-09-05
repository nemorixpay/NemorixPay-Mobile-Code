import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/transactions/domain/entities/transaction_list_item_data.dart';

/// @file        transaction_type_icon.dart
/// @brief       Widget for displaying transaction type icons
/// @details     Shows different icons for send and receive transactions
/// @author      Miguel Fagundez
/// @date        08/29/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionTypeIcon extends StatelessWidget {
  final TransactionType type;
  final double size;
  final Color? color;

  const TransactionTypeIcon({
    super.key,
    required this.type,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = color ?? theme.textTheme.bodyMedium?.color;

    IconData iconData;

    switch (type) {
      case TransactionType.send:
        iconData = LucideIcons.send;
        break;
      case TransactionType.receive:
        iconData = LucideIcons.wallet;
        break;
    }

    return SizedBox(
      width: size + 8,
      height: size + 8,
      child: Icon(
        iconData,
        size: size,
        color: iconColor,
      ),
    );
  }
}
