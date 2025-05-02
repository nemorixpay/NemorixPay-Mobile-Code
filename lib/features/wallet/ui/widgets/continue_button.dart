/// @file        continue_button.dart
/// @brief       Continue Button widget for NemorixPay wallet feature.
/// @details     Reusable button for advancing in wallet-related flows, based on RoundedElevatedButton.
/// @author      Miguel Fagundez
/// @date        2024-06-09
/// @version     1.0
/// @copyright   Apache 2.0 License
import 'package:flutter/material.dart';
import 'package:nemorixpay/shared/ui/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

/// @brief Continue button for the wallet feature.
/// @details Reuses RoundedElevatedButton and allows custom onPressed and label.
class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool enabled;

  /// @param onPressed Callback when the button is pressed
  /// @param label Button label text
  /// @param enabled Whether the button is enabled
  const ContinueButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedElevatedButton(
      text: label,
      onPressed: enabled ? onPressed : null,
      backgroundColor: NemorixColors.primaryColor,
      textColor: NemorixColors.mainBlack,
    );
  }
}
