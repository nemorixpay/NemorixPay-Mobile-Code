import 'package:flutter/material.dart';

/// @file        seed_phrase_input_grid.dart
/// @brief       Seed Phrase Input Grid widget for NemorixPay wallet feature.
/// @details     Contains the dynamic grid and input field widgets for entering the mnemonic phrase during wallet import.
/// @author      Miguel Fagundez
/// @date        2025-05-02
/// @version     1.0
/// @copyright   Apache 2.0 License

/// @brief Widget that displays a dynamic grid of seed phrase input fields.
/// @details The grid adapts to the selected phrase length (12 or 24 words) and arranges the fields in two columns.
class SeedPhraseInputGrid extends StatelessWidget {
  final int phraseLength;
  final List<TextEditingController> controllers;

  /// @param phraseLength Number of words in the seed phrase (12 or 24)
  /// @param controllers List of controllers for each input field
  const SeedPhraseInputGrid({
    super.key,
    required this.phraseLength,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4.5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 12,
      ),
      itemCount: phraseLength,
      itemBuilder: (context, index) {
        return SeedPhraseInputField(
          index: index,
          controller: controllers[index],
        );
      },
    );
  }
}

/// @brief Widget for a single seed phrase input field.
/// @details Displays the field number and a text input for the mnemonic word.
class SeedPhraseInputField extends StatelessWidget {
  final int index;
  final TextEditingController controller;

  /// @param index Index of the field (0-based)
  /// @param controller Controller for the text input
  const SeedPhraseInputField({
    super.key,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          alignment: Alignment.center,
          child: Text(
            '${index + 1}.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
