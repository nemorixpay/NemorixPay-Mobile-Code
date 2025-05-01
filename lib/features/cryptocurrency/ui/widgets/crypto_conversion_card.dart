import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/crypto_entity.dart';
import 'package:nemorixpay/features/cryptocurrency/data/mock_cryptos.dart';
import 'package:nemorixpay/shared/ui/widgets/base_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/amount_validator.dart';

/// @file        crypto_conversion_card.dart
/// @brief       Widget for conversion between fiat and cryptocurrencies.
/// @details     This widget handles the user interface for currency conversion,
///              including fiat currency selection, amount input, cryptocurrency selection,
///              and exchange rate display.
/// @author      Miguel Fagundez
/// @date        2025-04-29
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoConversionCard extends StatefulWidget {
  final String selectedFiat;
  final CryptoEntity selectedCrypto;
  final TextEditingController payController;
  final double cryptoPrice;
  final double receiveAmount;
  final Function(String) onFiatChanged;
  final Function(CryptoEntity) onCryptoChanged;
  final Function(String) onPayAmountChanged;

  const CryptoConversionCard({
    super.key,
    required this.selectedFiat,
    required this.selectedCrypto,
    required this.payController,
    required this.cryptoPrice,
    required this.receiveAmount,
    required this.onFiatChanged,
    required this.onCryptoChanged,
    required this.onPayAmountChanged,
  });

  @override
  State<CryptoConversionCard> createState() => _CryptoConversionCardState();
}

class _CryptoConversionCardState extends State<CryptoConversionCard> {
  AmountValidationState _validationState = AmountValidationState.valid;

  void _validateAmount(String amount) {
    setState(() {
      _validationState = AmountValidator.validateAmount(amount);
    });
    widget.onPayAmountChanged(amount);
  }

  String _getErrorMessage(BuildContext context) {
    switch (_validationState) {
      case AmountValidationState.invalidFormat:
        return AppLocalizations.of(context)!.invalidAmountFormat;
      case AmountValidationState.belowMinimum:
        return AppLocalizations.of(context)!.minimumAmount;
      case AmountValidationState.aboveMaximum:
        return AppLocalizations.of(context)!.maximumAmount;
      case AmountValidationState.valid:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardWidget: Column(
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.youPay,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              _buildFiatDropdown(context),
            ],
          ),
          TextField(
            controller: widget.payController,
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.titleLarge,
            inputFormatters: [AmountInputFormatter()],
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              errorText:
                  _validationState != AmountValidationState.valid
                      ? _getErrorMessage(context)
                      : null,
            ),
            onChanged: _validateAmount,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Icon(
                  Icons.swap_vert,
                  color: NemorixColors.primaryColor,
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.youReceive,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              _buildCryptoDropdown(context),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.receiveAmount.toStringAsFixed(4),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.circle,
                color: NemorixColors.primaryColor,
                size: 8,
              ),
              const SizedBox(width: 4),
              Text(
                '1 USD = ${(1 / widget.cryptoPrice).toStringAsFixed(6)} ${widget.selectedCrypto.symbol.toUpperCase()}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiatDropdown(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedFiat,
      style: Theme.of(context).textTheme.labelLarge,
      underline: const SizedBox(),
      items:
          ['USD', 'EUR', 'MXN', 'VES']
              .map(
                (currency) =>
                    DropdownMenuItem(value: currency, child: Text(currency)),
              )
              .toList(),
      onChanged: (value) => widget.onFiatChanged(value!),
    );
  }

  Widget _buildCryptoDropdown(BuildContext context) {
    return DropdownButton<CryptoEntity>(
      value: widget.selectedCrypto,
      style: Theme.of(context).textTheme.labelLarge,
      underline: const SizedBox(),
      items:
          mockCryptos
              .map(
                (crypto) => DropdownMenuItem(
                  value: crypto,
                  child: Text(crypto.symbol.toUpperCase()),
                ),
              )
              .toList(),
      onChanged: (value) => widget.onCryptoChanged(value!),
    );
  }
}
