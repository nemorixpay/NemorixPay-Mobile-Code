import 'package:flutter/material.dart';
import 'crypto_price_display.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/features/crypto/domain/entities/amount_validator.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';

/// @file        crypto_conversion_card.dart
/// @brief       Widget for conversion between fiat and cryptocurrencies.
/// @details     This widget handles the user interface for currency conversion,
///              including fiat currency selection, amount input, cryptocurrency selection,
///              and exchange rate display.
/// @author      Miguel Fagundez
/// @date        06/12/2025
/// @version     1.2
/// @copyright   Apache 2.0 License
class CryptoConversionCard extends StatefulWidget {
  final String selectedFiat;
  final List<CryptoAssetWithMarketData> listOfAssets;
  final TextEditingController payController;
  final double assetPrice;
  final double receiveAmount;
  final Function(String) onFiatChanged;
  final Function(CryptoAssetWithMarketData) onAssetChanged;
  final Function(String) onPayAmountChanged;

  const CryptoConversionCard({
    super.key,
    required this.selectedFiat,
    required this.listOfAssets,
    required this.payController,
    required this.assetPrice,
    required this.receiveAmount,
    required this.onFiatChanged,
    required this.onAssetChanged,
    required this.onPayAmountChanged,
  });

  @override
  State<CryptoConversionCard> createState() => _CryptoConversionCardState();
}

class _CryptoConversionCardState extends State<CryptoConversionCard> {
  AmountValidationState _validationState = AmountValidationState.valid;
  late CryptoAssetWithMarketData selectedAsset;
  @override
  void initState() {
    selectedAsset = widget.listOfAssets[0];
    super.initState();
  }

  @override
  void didUpdateWidget(CryptoConversionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (selectedAsset.asset.assetCode != selectedAsset.asset.assetCode) {}
  }

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
          Text(
            AppLocalizations.of(context)!.youPay,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          CryptoPriceDisplay(
            symbol: selectedAsset.asset.assetCode,
            initialCrypto: selectedAsset,
          ),
          const SizedBox(height: 12),
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
              _buildAssetDropdown(context),
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
                '1 USD = ${(1 / widget.assetPrice).toStringAsFixed(6)} ${selectedAsset.asset.assetCode.toUpperCase()}',
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

  Widget _buildAssetDropdown(BuildContext context) {
    return DropdownButton<CryptoAssetWithMarketData>(
      value: selectedAsset,
      style: Theme.of(context).textTheme.labelLarge,
      underline: const SizedBox(),
      items:
          widget.listOfAssets
              .map(
                (asset) => DropdownMenuItem(
                  value: asset,
                  child: Text(asset.asset.assetCode.toUpperCase()),
                ),
              )
              .toList(),
      onChanged: (value) => widget.onAssetChanged(value!),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
