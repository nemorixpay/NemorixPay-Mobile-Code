import 'package:flutter/material.dart';

/// @file        line_divider_with_text.dart
/// @brief       Widget for displaying a divider with centered text
/// @details     Displays a single line with centered text.
/// @author      Miguel Fagundez
/// @date        06/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class LineDividerWithText extends StatelessWidget {
  final String text;
  const LineDividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text, style: Theme.of(context).textTheme.labelMedium),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
