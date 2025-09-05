import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// @file        transaction_date_display.dart
/// @brief       Widget for displaying formatted transaction dates
/// @details     Shows transaction dates in a user-friendly format
/// @author      Miguel Fagundez
/// @date        08/29/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TransactionDateDisplay extends StatelessWidget {
  final DateTime date;
  final bool showTime;
  final TextStyle? style;
  final String? prefix;

  const TransactionDateDisplay({
    super.key,
    required this.date,
    this.showTime = true,
    this.style,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = style ?? theme.textTheme.bodySmall;

    String formattedDate;

    if (showTime) {
      // Format: "Mar 5, 2021 at 01:44AM"
      final dateFormat = DateFormat("MMM d, y 'at' h:mma");
      formattedDate = dateFormat.format(date);
    } else {
      // Format: "Mar 5, 2021"
      final dateFormat = DateFormat("MMM d, y");
      formattedDate = dateFormat.format(date);
    }

    return Text(
      prefix != null ? '$prefix $formattedDate' : formattedDate,
      style: textStyle?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.7),
      ),
    );
  }
}
