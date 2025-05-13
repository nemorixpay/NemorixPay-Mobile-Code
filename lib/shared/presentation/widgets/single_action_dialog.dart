import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/presentation/widgets/rounded_elevated_button.dart';

/// @file        single_action_dialog.dart
/// @brief       Implementation of a reusable single-button dialog.
/// @details     This dialog provides a consistent UI pattern for displaying
///             information with a single action button. It's used across the app
///             for various confirmation and information dialogs.
/// @author      Miguel Fagundez
/// @date        2025-05-13
/// @version     1.0
/// @copyright   Apache 2.0 License
class SingleActionDialog extends StatelessWidget {
  /// The title displayed at the top of the dialog
  final String title;

  /// The main content widget of the dialog
  final Widget child;

  /// The text to display on the action button
  final String buttonText;

  /// Callback function when the button is pressed
  final VoidCallback onPressed;

  /// Whether to show the action button (default: true)
  final bool showButton;

  const SingleActionDialog({
    super.key,
    required this.title,
    required this.child,
    required this.buttonText,
    required this.onPressed,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          if (showButton) const SizedBox(height: 20),
          if (showButton)
            RoundedElevatedButton(
              text: buttonText,
              onPressed: onPressed,
              backgroundColor: NemorixColors.primaryColor,
              textColor: Colors.black,
            ),
        ],
      ),
    );
  }
}
