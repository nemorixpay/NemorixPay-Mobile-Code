// ------------------ Action Buttons ------------------
import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        column_action_buttons.dart
/// @brief       Reusable widget for displaying two action buttons in a column layout.
/// @details     Provides a consistent layout for confirm and cancel buttons with proper
///              styling and spacing. The confirm button uses primary color and the cancel
///              button uses an outlined style. This widget is designed to be reusable
///              across different pages that require confirmation actions.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class ColumnActionButtons extends StatelessWidget {
  /// Callback function to execute when the confirm button is pressed
  final VoidCallback onConfirm;

  /// Callback function to execute when the cancel button is pressed
  final VoidCallback onCancel;

  /// Text to display on the confirm button
  final String textConfirmBtn;

  /// Text to display on the cancel button (defaults to 'Cancel')
  final String textCancelBtn;

  const ColumnActionButtons({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.textConfirmBtn,
    this.textCancelBtn = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedElevatedButton(
          text: textConfirmBtn,
          onPressed: onConfirm,
          backgroundColor: NemorixColors.primaryColor,
          textColor: NemorixColors.greyLevel1,
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: NemorixColors.greyLevel4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onCancel,
            child: Text(
              textCancelBtn,
              style: const TextStyle(color: NemorixColors.greyLevel4),
            ),
          ),
        ),
      ],
    );
  }
}
