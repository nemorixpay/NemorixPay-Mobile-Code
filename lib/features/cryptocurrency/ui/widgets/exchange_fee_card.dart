import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/ui/widgets/base_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// @file        exchange_fee_card.dart
/// @brief       Widget to display the exchange fee.
/// @details     This widget visually displays the exchange fee applied to the transaction,
///              including an icon and the fee amount.
/// @author      Miguel Fagundez
/// @date        2025-04-29
/// @version     1.0
/// @copyright   Apache 2.0 License
class ExchangeFeeCard extends StatelessWidget {
  final double exchangeFee;

  const ExchangeFeeCard({super.key, required this.exchangeFee});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardWidget: Row(
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
            '\$${exchangeFee.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
