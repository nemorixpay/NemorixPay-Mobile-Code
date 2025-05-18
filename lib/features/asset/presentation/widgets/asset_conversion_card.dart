import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/asset/domain/entities/asset_entity.dart';
import 'package:nemorixpay/features/asset/data/mock_cryptos.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/features/asset/domain/entities/amount_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'asset_price_display.dart';
import '../../domain/usecases/update_asset_price_usecase.dart';
import '../../data/repositories/asset_repository_impl.dart';
import '../../data/datasources/asset_datasource_impl.dart';

/// @file        asset_conversion_card.dart
/// @brief       Widget for conversion between fiat and cryptocurrencies.
/// @details     This widget handles the user interface for currency conversion,
///              including fiat currency selection, amount input, cryptocurrency selection,
///              and exchange rate display.
/// @author      Miguel Fagundez
/// @date        04/30/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class AssetConversionCard extends StatefulWidget {
  final String selectedFiat;
  final AssetEntity selectedAsset;
  final TextEditingController payController;
  final double assetPrice;
  final double receiveAmount;
  final Function(String) onFiatChanged;
  final Function(AssetEntity) onAssetChanged;
  final Function(String) onPayAmountChanged;

  const AssetConversionCard({
    super.key,
    required this.selectedFiat,
    required this.selectedAsset,
    required this.payController,
    required this.assetPrice,
    required this.receiveAmount,
    required this.onFiatChanged,
    required this.onAssetChanged,
    required this.onPayAmountChanged,
  });

  @override
  State<AssetConversionCard> createState() => _AssetConversionCardState();
}

class _AssetConversionCardState extends State<AssetConversionCard> {
  AmountValidationState _validationState = AmountValidationState.valid;
  late AssetBloc _assetBloc;

  @override
  void initState() {
    super.initState();
    _initializeBloc();
  }

  @override
  void didUpdateWidget(AssetConversionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedAsset.symbol != widget.selectedAsset.symbol) {
      _initializeBloc();
    }
  }

  // TODO This needs to be deleted
  // Temporal bloc initialization
  // Move to di/services
  void _initializeBloc() {
    _assetBloc = AssetBloc(
      updateAssetPrice: UpdateAssetPriceUseCase(
        AssetRepositoryImpl(
          AssetDataSourceImpl()..initializeMockData(widget.selectedAsset),
        ),
      ),
    );
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
    return BlocProvider.value(
      value: _assetBloc,
      child: BaseCard(
        cardWidget: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.youPay,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 12),
            AssetPriceDisplay(
              symbol: widget.selectedAsset.symbol,
              initialAsset: widget.selectedAsset,
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
                  '1 USD = ${(1 / widget.assetPrice).toStringAsFixed(6)} ${widget.selectedAsset.symbol.toUpperCase()}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
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
    return DropdownButton<AssetEntity>(
      value: widget.selectedAsset,
      style: Theme.of(context).textTheme.labelLarge,
      underline: const SizedBox(),
      items:
          mockCryptos
              .map(
                (asset) => DropdownMenuItem(
                  value: asset,
                  child: Text(asset.symbol.toUpperCase()),
                ),
              )
              .toList(),
      onChanged: (value) => widget.onAssetChanged(value!),
    );
  }

  @override
  void dispose() {
    _assetBloc.close();
    super.dispose();
  }
}
