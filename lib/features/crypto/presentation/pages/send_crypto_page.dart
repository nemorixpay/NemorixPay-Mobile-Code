import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/crypto/presentation/pages/confirm_transaction_page.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/app_loader.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/crypto_logo_widget.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_account_assets/crypto_account_state.dart';
import 'package:http/http.dart' as http;
import 'package:nemorixpay/shared/analytics/data/datasources/transactions_analytics_datasource_impl.dart';
import 'package:nemorixpay/shared/analytics/services/transactions_analytics_service.dart';

/// @file        send_crypto_page.dart
/// @brief       Page for sending Stellar Lumens (XLM) to another address.
/// @details     Provides UI for entering recipient address, amount, note, and sending XLM.
///              Includes validation, balance display, and a placeholder for QR scanning.
///              Validates that the recipient address is not the same as the sender's address.
/// @author      Miguel Fagundez
/// @date        06/28/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class SendCryptoPage extends StatefulWidget {
  /// Name of the cryptocurrency (e.g., "XLM", "USDC")
  final CryptoAssetWithMarketData crypto;
  const SendCryptoPage({
    Key? key,
    required this.crypto,
  }) : super(key: key);

  @override
  State<SendCryptoPage> createState() => _SendCryptoPageState();
}

class _SendCryptoPageState extends State<SendCryptoPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // Valores hardcodeados (mock)
  late double _availableBalance;
  final double _minAmount = 1;
  final double _initialFee = 0.0006;
  late double _fee;
  late double _maxAmount;

  bool _isValidAddress = false;
  bool _isValidAmount = false;
  bool _isOwnAddress = false;
  bool _isValidNote = false;
  bool _isSendingTransaction = false; // Flag to track if we're sending a transaction

  @override
  void initState() {
    super.initState();
    // Basic validation
    _fee = 4 * _initialFee;
    _availableBalance = widget.crypto.asset.balance ?? 0.0;
    _maxAmount = _availableBalance - _fee;
    _addressController.addListener(_validateAddress);
    _amountController.addListener(_validateAmount);
    _noteController.addListener(_validateNote);
    debugPrint('initState - amount = ${widget.crypto.asset.amount}');
    debugPrint('initState - balance = ${widget.crypto.asset.balance}');
    debugPrint('initState - name = ${widget.crypto.asset.name}');
    debugPrint('initState - assetIssuer = ${widget.crypto.asset.assetIssuer}');
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
    final stellarAccountProvider = StellarAccountProvider();
    final ownPublicKey = stellarAccountProvider.getPublicKey();

    // Simple validation: (56 characters, starting with 'G')
    final isValidFormat = ValidationRules.isValidStellarAddress(address);
    // Validates that the recipient address is not the same as the sender's address
    final isOwnAddress = address == ownPublicKey;

    setState(() {
      _isValidAddress = isValidFormat && !isOwnAddress;
      _isOwnAddress = isOwnAddress;
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

  void _validateNote() {
    final note = _noteController.text.trim();
    setState(() {
      _isValidNote = (note.isEmpty) || (note.isNotEmpty && note.length < 28);
    });
  }

  bool get _isFormValid => _isValidAddress && _isValidAmount && _isValidNote;

  void _onScanQr() async {
    // TODO: Need to be checked in real device
    final result = await Navigator.pushNamed(
      context,
      RouteNames.qrScan,
    ) as String;

    if (result != '-1') {
      setState(() {
        _addressController.text = result;
      });
    } else {
      debugPrint('_onScanQr - result is not a Stellar address or null');
    }
    debugPrint('_onScanQr - result = $result');
  }

  void showNemorixSnackBar({
    required String message,
    SnackBarType type = SnackBarType.success,
  }) {
    NemorixSnackBar.show(
      context,
      message: message,
      type: type,
    );
  }

  void sentTransaction() {
    setState(() {
      _isSendingTransaction = true; // Mark that we're sending a transaction
    });
    final double amount = double.parse(_amountController.text);
    context.read<CryptoAccountBloc>().add(SendCryptoTransaction(
          _addressController.text,
          amount,
          _noteController.text,
        ));
  }

  /// Tracks transaction for analytics purposes
  Future<void> _trackTransactionAnalytics(
      String transactionHash, double amount, double fee) async {
    try {
      debugPrint('SendCryptoPage - Tracking transaction for analytics');
      final httpClient = http.Client();
      final datasource =
          TransactionsAnalyticsDatasourceImpl(httpClient: httpClient);
      final analyticsService =
          TransactionsAnalyticsService(datasource: datasource);

      final feeCharged = fee;
      final fiatAmount = amount * 1.0; // TODO: Get real fiat conversion rate
      const country =
          'US'; // TODO: Get from user profile or implement country detection

      await analyticsService.trackTransaction(
        transactionId: transactionHash,
        assetAmount: amount,
        assetCode: widget.crypto.asset.assetCode,
        feeCharged: feeCharged,
        fiatAmount: fiatAmount,
        fiatSymbol: 'US',
        location: country,
        type: 'send',
      );

      debugPrint('SendCryptoPage - Transaction analytics tracked successfully');
      httpClient.close();
    } catch (e) {
      debugPrint('SendCryptoPage - Analytics tracking failed: $e');
      // Don't affect the main flow - analytics is optional
    }
  }

  void _onSend(String message) {
    final l10n = AppLocalizations.of(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmTransactionPage(
          recipientAddress: _addressController.text,
          amount: double.parse(_amountController.text),
          cryptoName: widget.crypto.asset.assetCode,
          fee: _fee,
          note: _noteController.text,
          onConfirm: () {
            // Handle confirmation - send transaction
            Navigator.pop(context, true); // Return true for confirmed
          },
          onCancel: () {
            // Handle cancellation
            Navigator.pop(context, false); // Return false for cancelled
          },
        ),
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        // User confirmed, proceed with transaction
        debugPrint('Transaction confirmed!');
        sentTransaction();
      } else {
        // User cancelled
        debugPrint('Transaction cancelled!');
        showNemorixSnackBar(
          message: l10n!.confirmTransactionCanceled,
          type: SnackBarType.warning,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    debugPrint('cryptoName (SEND): ${widget.crypto.asset.assetCode}');
    return BlocListener<CryptoAccountBloc, CryptoAccountState>(
      listenWhen: (previous, current) {
        // Only listen to transaction-related states if we're actually sending a transaction
        // This prevents processing old states when returning from QR scan
        if (current is CryptoTransactionLoading ||
            current is CryptoTransactionError ||
            current is CryptoTransactionSent) {
          return _isSendingTransaction;
        }
        return false;
      },
      listener: (BuildContext context, CryptoAccountState state) {
        if (state is CryptoTransactionLoading) {
          debugPrint('CryptoTransactionLoading');
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AppLoader(message: l10n.sendingTransaction),
          );
        }
        if (state is CryptoTransactionError) {
          debugPrint('CryptoTransactionError: ${state.failure}');
          setState(() {
            _isSendingTransaction = false; // Reset flag on error
          });
          Navigator.of(context).pop(); // Close loader if open
          showNemorixSnackBar(
            message: l10n.transactionFailed,
            type: SnackBarType.error,
          );
        }
        if (state is CryptoTransactionSent) {
          debugPrint('CryptoTransactionSent: ${state.hash}');

          setState(() {
            _isSendingTransaction = false; // Reset flag after successful transaction
          });

          // Track transaction for analytics (fire and forget)
          final amount = double.parse(_amountController.text);
          _trackTransactionAnalytics(state.hash, amount, _fee);

          Navigator.of(context).pop(); // Close loader if open
          Navigator.of(context).pop(); // Close send crypto page
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.successPage,
            arguments: {
              'titleSuccess': l10n.transactionSuccessTitle,
              'firstParagraph':
                  l10n.transactionSuccessMessage(widget.crypto.asset.assetCode),
              'secondParagraph':
                  '${l10n.transactionHashInfo(state.hash)}.\n${l10n.transactionConfirmationNote}',
            },
            (route) => false,
          );
          showNemorixSnackBar(
            message: l10n.transactionSent,
            type: SnackBarType.success,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainHeader(
                  title: l10n!.sendCryptoTitle(widget.crypto.asset.assetCode),
                  showSearchButton: false,
                ),
                const SizedBox(height: 20),
                const CryptoLogoWidget(
                  logo: 'assets/logos/xlm.png',
                ),
                const SizedBox(height: 20),
                _CryptoInfoCard(
                  balance: _availableBalance,
                  cryptoName: widget.crypto.asset.assetCode,
                ),
                const SizedBox(height: 32),
                _SendCryptoForm(
                  addressController: _addressController,
                  amountController: _amountController,
                  noteController: _noteController,
                  onScanQr: () {
                    _onScanQr();
                  },
                  isValidAddress: _isValidAddress,
                  isValidAmount: _isValidAmount,
                  isOwnAddress: _isOwnAddress,
                  isValidNote: _isValidNote,
                  minAmount: _minAmount,
                  maxAmount: _maxAmount,
                  availableBalance: _availableBalance,
                  fee: _fee,
                  cryptoName: widget.crypto.asset.assetCode,
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
                    text: l10n.sendCryptoTitle(widget.crypto.asset.assetCode),
                    onPressed: _isFormValid
                        ? () async {
                            _onSend(l10n.sendNotImplemented);
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
  final bool isValidNote;
  final bool isOwnAddress;
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
    required this.isValidNote,
    required this.isOwnAddress,
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
                      hintText: l10n.recipientAddress,
                      errorText: addressController.text.isEmpty
                          ? null
                          : (isOwnAddress
                              ? l10n.ownAddressError
                              : (isValidAddress ? null : l10n.invalidAddress)),
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
            Text(l10n.amount, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: l10n.amountHint,
                errorText: amountController.text.isEmpty
                    ? null
                    : (isValidAmount ? null : l10n.invalidAmount),
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
            Text(l10n.note, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                hintText: l10n.noteHint,
                errorText: noteController.text.isEmpty
                    ? null
                    : (isValidNote ? null : l10n.memoLongErrorMessage),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            Text(
              l10n.transactionFees(fee, cryptoName),
              style: theme.textTheme.labelSmall,
            ),
            Text(
              l10n.sendCryptominMax(minAmount, maxAmount, cryptoName),
              style: theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
