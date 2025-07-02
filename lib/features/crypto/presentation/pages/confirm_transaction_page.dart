import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/column_action_buttons.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/crypto_logo_widget.dart';

/// @file        confirm_transaction_page.dart
/// @brief       Page for confirming crypto transaction details before sending.
/// @details     Displays a summary of the transaction details (recipient, amount, fees, note)
///              and allows the user to confirm or cancel the transaction. Follows NemorixPay
///              theme and documentation standards.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class ConfirmTransactionPage extends StatelessWidget {
  /// Transaction details to be confirmed
  final String recipientAddress;
  final double amount;
  final String cryptoName;
  final double fee;
  final String? note;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmTransactionPage({
    Key? key,
    required this.recipientAddress,
    required this.amount,
    required this.cryptoName,
    required this.fee,
    this.note,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MainHeader(
                title: l10n!.confirmTransactionTitle,
                showSearchButton: false,
              ),
              const SizedBox(height: 20),
              const CryptoLogoWidget(
                logo: 'assets/logos/xlm.png',
              ),
              const SizedBox(height: 20),
              _TransactionSummaryCard(
                recipientAddress: recipientAddress,
                amount: amount,
                cryptoName: cryptoName,
                fee: fee,
                note: note,
              ),
              const SizedBox(height: 20),
              _TransactionDetailsCard(
                amount: amount,
                fee: fee,
                cryptoName: cryptoName,
              ),
              const SizedBox(height: 32),
              ColumnActionButtons(
                onConfirm: onConfirm,
                onCancel: onCancel,
                textConfirmBtn: l10n.confirmAndSend(cryptoName),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ Transaction Summary Card ------------------
class _TransactionSummaryCard extends StatelessWidget {
  final String recipientAddress;
  final double amount;
  final String cryptoName;
  final double fee;
  final String? note;

  const _TransactionSummaryCard({
    required this.recipientAddress,
    required this.amount,
    required this.cryptoName,
    required this.fee,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return BaseCard(
      cardWidget: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n!.transactionSummary,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _SummaryRow(
              label: l10n.recipientAddress,
              value: recipientAddress,
              isAddress: true,
            ),
            const SizedBox(height: 12),
            _SummaryRow(
              label: l10n.amount,
              value: '$amount $cryptoName',
            ),
            if (note != null && note!.isNotEmpty) ...[
              const SizedBox(height: 12),
              _SummaryRow(
                label: l10n.note,
                value: note!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ------------------ Transaction Details Card ------------------
class _TransactionDetailsCard extends StatelessWidget {
  final double amount;
  final double fee;
  final String cryptoName;

  const _TransactionDetailsCard({
    required this.amount,
    required this.fee,
    required this.cryptoName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final totalAmount = amount + fee;

    return BaseCard(
      cardWidget: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n!.transactionDetails,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _DetailRow(
              label: l10n.amount,
              value: '$amount $cryptoName',
            ),
            const SizedBox(height: 8),
            _DetailRow(
              label: l10n.confirmTransactionFees,
              value: '$fee $cryptoName',
            ),
            const Divider(height: 24),
            _DetailRow(
              label: l10n.totalAmount,
              value: '$totalAmount $cryptoName',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ Summary Row Widget ------------------
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isAddress;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isAddress = false,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontFamily: isAddress ? 'monospace' : null,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

// ------------------ Detail Row Widget ------------------
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
