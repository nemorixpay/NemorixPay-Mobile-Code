import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/crypto_logo_widget.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        send_crypto_page.dart
/// @brief       Page for sending Stellar Lumens (XLM) to another address.
/// @details     Provides UI for entering recipient address, amount, note, and sending XLM. Includes validation, balance display, and a placeholder for QR scanning. Follows NemorixPay theme and documentation standards.
/// @author      Miguel Fagundez
/// @date        06/28/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class SendCryptoPage extends StatefulWidget {
  /// Name of the cryptocurrency (e.g., "XLM", "USDC")
  final String cryptoName;
  const SendCryptoPage({Key? key, required this.cryptoName}) : super(key: key);

  @override
  State<SendCryptoPage> createState() => _SendCryptoPageState();
}

class _SendCryptoPageState extends State<SendCryptoPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // Valores hardcodeados (mock)
  final double _availableBalance = 2.23464;
  final double _minAmount = 1;
  final double _initialFee = 0.0006;
  late double _fee;
  late double _maxAmount;

  bool _isValidAddress = false;
  bool _isValidAmount = false;

  @override
  void initState() {
    super.initState();
    // Basic validation
    _fee = 3 * _initialFee;
    _maxAmount = _availableBalance - _fee;
    _addressController.addListener(_validateAddress);
    _amountController.addListener(_validateAmount);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _validateAddress() {
    final address = _addressController.text.trim();
    // Validacion simple: longitud tipica de direccion Stellar (56 caracteres, empieza con 'G')
    setState(() {
      _isValidAddress =
          address.isNotEmpty && address.length == 56 && address.startsWith('G');
    });
  }

  void _validateAmount() {
    final text = _amountController.text.trim();
    final amount = double.tryParse(text);
    setState(() {
      _isValidAmount = amount != null &&
          amount >= _minAmount &&
          amount <= _maxAmount &&
          amount <= _availableBalance;
    });
  }

  bool get _isFormValid => _isValidAddress && _isValidAmount;

  void _onScanQr(String message) {
    // TODO: Implement QR scanning logic
    //'QR scanner not implemented yet.'
    NemorixSnackBar.show(
      // ignore: use_build_context_synchronously
      context,
      message: message,
      type: SnackBarType.info,
    );
  }

  void _onSend(String message) {
    // TODO: Implement send logic
    // 'Send not implemented yet.'
    NemorixSnackBar.show(
      // ignore: use_build_context_synchronously
      context,
      message: message,
      type: SnackBarType.info,
    );
  }

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
                title: l10n!.sendCryptoTitle(widget.cryptoName),
                showSearchButton: false,
              ),
              const SizedBox(height: 20),
              const CryptoLogoWidget(
                logo: 'assets/logos/xlm.png',
              ),
              const SizedBox(height: 20),
              _CryptoInfoCard(
                balance: _availableBalance,
                cryptoName: widget.cryptoName,
              ),
              const SizedBox(height: 32),
              _SendCryptoForm(
                addressController: _addressController,
                amountController: _amountController,
                noteController: _noteController,
                onScanQr: () {
                  _onScanQr(l10n!.qrNotImplemented);
                },
                isValidAddress: _isValidAddress,
                isValidAmount: _isValidAmount,
                minAmount: _minAmount,
                maxAmount: _maxAmount,
                availableBalance: _availableBalance,
                fee: _fee,
                cryptoName: widget.cryptoName,
              ),
              const SizedBox(height: 32),
              Text(
                l10n.blockTimeInfo,
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: theme.hintColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(12),
                child: RoundedElevatedButton(
                  text: l10n!.sendCryptoTitle(widget.cryptoName),
                  onPressed: _isFormValid
                      ? () async {
                          _onSend(l10n!.sendNotImplemented);
                        }
                      : null,
                  backgroundColor: NemorixColors.primaryColor,
                  textColor: NemorixColors.greyLevel1,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ Crypto Info Card ------------------
class _CryptoInfoCard extends StatelessWidget {
  final double balance;
  final String cryptoName;
  const _CryptoInfoCard({required this.balance, required this.cryptoName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    // TODO: Need to be checked in real device and API data
    // - Temporal -
    const logo = 'assets/logos/xlm.png';

    return BaseCard(
      cardWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n!.stellarLumens, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(cryptoName, style: theme.textTheme.labelMedium),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(l10n.availableBalance, style: theme.textTheme.labelSmall),
                Text(
                  '${balance.toStringAsFixed(5)} $cryptoName',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ Send Crypto Form ------------------
class _SendCryptoForm extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final VoidCallback onScanQr;
  final bool isValidAddress;
  final bool isValidAmount;
  final double minAmount;
  final double maxAmount;
  final double availableBalance;
  final double fee;
  final String cryptoName;

  const _SendCryptoForm({
    Key? key,
    required this.addressController,
    required this.amountController,
    required this.noteController,
    required this.onScanQr,
    required this.isValidAddress,
    required this.isValidAmount,
    required this.minAmount,
    required this.maxAmount,
    required this.availableBalance,
    required this.fee,
    required this.cryptoName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return BaseCard(
      cardWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n!.enterAddress, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: l10n!.recipientAddress,
                      errorText: addressController.text.isEmpty
                          ? null
                          : (isValidAddress ? null : l10n!.invalidAddress),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(56),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onScanQr,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.qr_code_scanner, size: 28),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(l10n!.amount, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: l10n!.amountHint,
                errorText: amountController.text.isEmpty
                    ? null
                    : (isValidAmount ? null : l10n!.invalidAmount),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]*')),
              ],
            ),
            const SizedBox(height: 20),
            Text(l10n!.note, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                hintText: l10n!.noteHint,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            Text(
              l10n!.transactionFees(fee, cryptoName),
              style: theme.textTheme.labelSmall,
            ),
            Text(
              l10n!.sendCryptominMax(minAmount, maxAmount, cryptoName),
              style: theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
