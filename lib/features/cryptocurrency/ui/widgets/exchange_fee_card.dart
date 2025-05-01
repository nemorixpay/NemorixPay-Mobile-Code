import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/ui/widgets/base_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entities/commission_validator.dart';

/// @file        exchange_fee_card.dart
/// @brief       Widget to display the exchange fee.
/// @details     This widget visually displays the exchange fee applied to the transaction,
///              including an icon and the fee amount.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class ExchangeFeeCard extends StatelessWidget {
  final double exchangeFee;
  final double amount;
  final double commissionPercent;

  const ExchangeFeeCard({
    super.key,
    required this.exchangeFee,
    required this.amount,
    required this.commissionPercent,
  });

  @override
  Widget build(BuildContext context) {
    final commissionState = CommissionValidator.validateCommission(
      amount: amount,
      commissionPercent: commissionPercent,
    );

    final commission = CommissionValidator.calculateCommission(
      amount: amount,
      commissionPercent: commissionPercent,
    );

    final totalAmount = CommissionValidator.calculateTotalAmount(
      amount: amount,
      commissionPercent: commissionPercent,
    );

    return BaseCard(
      cardWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: NemorixColors.greyLevel2,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.monetization_on,
                  color: NemorixColors.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.exchangeFee,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              Text(
                '\$${commission.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color:
                      commissionState == CommissionValidationState.valid
                          ? NemorixColors.successColor
                          : NemorixColors.errorColor,
                ),
              ),
            ],
          ),
          if (commissionState != CommissionValidationState.valid) ...[
            const SizedBox(height: 8),
            Text(
              CommissionValidator.getCommissionMessage(
                context,
                commissionState,
              ),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: NemorixColors.errorColor),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.totalAmount,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
