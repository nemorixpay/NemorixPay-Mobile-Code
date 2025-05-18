import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        yes_no_dialog.dart
/// @brief       Implementation of a reusable confirmation dialog with Yes/No options.
/// @details     This dialog provides a consistent UI pattern for user confirmations
///             across the app. It displays a message with two options (Yes/No) and
///             handles the user's response through callbacks.
/// @author      Miguel Fagundez
/// @date        2025-05-13
/// @version     1.0
/// @copyright   Apache 2.0 License
class YesNoDialog extends StatelessWidget {
  /// The title displayed at the top of the dialog
  final String title;

  /// The message to display in the dialog body
  final String message;

  /// Callback function when the Yes button is pressed
  final VoidCallback onYesPressed;

  /// Callback function when the No button is pressed
  final VoidCallback onNoPressed;

  /// Text to display on the Yes button (default: "Yes")
  final String yesText;

  /// Text to display on the No button (default: "No")
  final String noText;

  const YesNoDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onYesPressed,
    required this.onNoPressed,
    this.yesText = "Yes",
    this.noText = "No",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      actions: [
        RoundedElevatedButton(
          text: noText,
          onPressed: onNoPressed,
          backgroundColor: NemorixColors.primaryColor,
          textColor: Colors.black,
        ),
        RoundedElevatedButton(
          text: yesText,
          onPressed: onYesPressed,
          backgroundColor: NemorixColors.primaryColor,
          textColor: Colors.black,
        ),
      ],
    );
  }
}
