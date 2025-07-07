import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import '../../domain/entities/amount_validator.dart';
import '../../domain/entities/commission_validator.dart';

/// @file        continue_button.dart
/// @brief       Button to continue with the crypto purchase.
/// @details     This widget handles the continue button for the crypto purchase,
///              including validation states and error messages.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class ContinueButton extends StatelessWidget {
  final Function() onPressed;
  final String amount;
  final double commissionPercent;

  const ContinueButton({
    super.key,
    required this.onPressed,
    required this.amount,
    this.commissionPercent = 0.0005,
  });

  bool get _isValid {
    final amountState = AmountValidator.validateAmount(amount);
    if (amountState != AmountValidationState.valid) return false;

    final payAmount = double.tryParse(amount) ?? 0;
    final commissionState = CommissionValidator.validateCommission(
      amount: payAmount,
      commissionPercent: commissionPercent,
    );

    return commissionState == CommissionValidationState.valid;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedElevatedButton(
      text: AppLocalizations.of(context)!.continueText,
      onPressed: _isValid ? onPressed : null,
      backgroundColor:
          _isValid ? NemorixColors.primaryColor : NemorixColors.greyLevel2,
      textColor: _isValid ? NemorixColors.greyLevel1 : NemorixColors.greyLevel3,
    );
  }
}
