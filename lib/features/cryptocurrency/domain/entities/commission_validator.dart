import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        commission_validator.dart
/// @brief       Utility class for commission validation in cryptocurrency transactions.
/// @details     This class provides methods to validate transaction commissions,
///              including commission limits and total amount validation.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
enum CommissionValidationState { valid, belowMinimum, aboveMaximum }

class CommissionValidator {
  static const double minimumCommissionPercent = 0.0005; // 0.05%
  static const double maximumCommissionPercent = 0.01; // 1.0%
  static const double absoluteCommissionLimit = 50.0; // $50 USD

  static double calculateCommission({
    required double amount,
    required double commissionPercent,
  }) {
    final commission = amount * commissionPercent;
    return commission > absoluteCommissionLimit
        ? absoluteCommissionLimit
        : commission;
  }

  static CommissionValidationState validateCommission({
    required double amount,
    required double commissionPercent,
  }) {
    if (commissionPercent < minimumCommissionPercent) {
      return CommissionValidationState.belowMinimum;
    }

    if (commissionPercent > maximumCommissionPercent) {
      return CommissionValidationState.aboveMaximum;
    }

    return CommissionValidationState.valid;
  }

  static double calculateTotalAmount({
    required double amount,
    required double commissionPercent,
  }) {
    final commission = calculateCommission(
      amount: amount,
      commissionPercent: commissionPercent,
    );
    return amount + commission;
  }

  static String getCommissionMessage(
    BuildContext context,
    CommissionValidationState state,
  ) {
    switch (state) {
      case CommissionValidationState.belowMinimum:
        return AppLocalizations.of(context)!.commissionBelowMinimum;
      case CommissionValidationState.aboveMaximum:
        return AppLocalizations.of(context)!.commissionAboveMaximum;
      case CommissionValidationState.valid:
        return '';
    }
  }
}
