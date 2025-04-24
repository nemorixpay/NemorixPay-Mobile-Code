import 'package:flutter/material.dart';

/// @file        button_tile_right.dart
/// @brief       Button tile.
/// @details     This file provides a base implementation for a button tile with an icon aligned to the right.
/// @author      Miguel Fagundez
/// @date        2025-04-21
/// @version     1.0
/// @copyright   Apache 2.0 License
class CustomButtonTile extends StatelessWidget {
  final String label;
  final Function() function;
  final Widget? widgetRight;
  final Widget? widgetLeft;

  const CustomButtonTile({
    super.key,
    required this.label,
    required this.function,
    this.widgetRight,
    this.widgetLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: widgetLeft,
        title: Text(label, style: const TextStyle(color: Colors.white)),
        trailing: widgetRight,
        onTap: function,
      ),
    );
  }
}
