import 'package:flutter/material.dart';

/// @file        base_card.dart
/// @brief       Base Card widget.
/// @details     This file contains the layout and UI logic for each base card in NemorixPay,
///              This widget is included in: buy_crypto_page.dart.
/// @author      Miguel Fagundez
/// @date        2025-04-19
/// @version     1.0
/// @copyright   Apache 2.0 License
class BaseCard extends StatefulWidget {
  final Widget cardWidget;
  const BaseCard({super.key, required this.cardWidget});

  @override
  State<BaseCard> createState() => _BaseCardState();
}

class _BaseCardState extends State<BaseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: widget.cardWidget,
      ),
    );
  }
}
