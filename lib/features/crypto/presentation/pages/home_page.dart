import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/core/utils/api_extensions.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/animated_drawer.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/app_loader.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/crypto_card.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/home_header.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/live_price_tile.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_state.dart';

/// @file        home_page.dart
/// @brief       New implementation of the main screen using CryptoMarketBloc.
/// @details     This version uses the new CryptoMarketBloc to handle state
///              and operations related to the cryptocurrency market.
/// @author      Miguel Fagundez
/// @date        06/09/2025
/// @version     1
/// @copyright   Apache 2.0 License
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<CryptoAssetWithMarketData> _searchResults = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // Fire main event: Get all available/account assets
    if (!_isSearching) {
      context.read<CryptoHomeBloc>().add(LoadAllCryptoData());
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _searchCrypto(String query) {
    final state = context.read<CryptoHomeBloc>().state;
    if (state is CryptoHomeLoaded) {
      debugPrint('state is CryptoHomeLoaded in _searchCrypto');
      setState(() {
        _searchResults = state.marketAssets
            .where(
              (crypto) => crypto.asset.name.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedDrawer(
      body: SafeArea(
        // TODO: Need to check with BlocListener
        child: BlocBuilder<CryptoHomeBloc, CryptoHomeState>(
          builder: (context, homeState) {
            debugPrint('Home State: $homeState');

            if (homeState is CryptoHomeLoading) {
              return AppLoader(message: l10n.loading);
            }

            if (homeState is CryptoHomeError) {
              return Center(child: Text('Error: ${l10n.noAvailableData}'));
            }

            if (homeState is CryptoHomeLoaded) {
              debugPrint('Home State is: ${homeState.toString()}');
              debugPrint(
                'Home State (marketAssets): ${homeState.marketAssets}',
              );
              debugPrint(
                'Home State (accountAssets): ${homeState.accountAssets}',
              );

              // TODO: Include Home widgets HERE
              return mainWidget(homeState);
            }
            return Center(child: Text(l10n.noAvailableData));
          },
        ),
      ),
    );
  }

  Widget mainWidget(CryptoHomeLoaded homeState) {
    final walletBalance = calculateWalletBalance(homeState.accountAssets);
    return GestureDetector(
      onTap: () {
        if (_isSearching) _toggleSearch();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(
            isSearching: _isSearching,
            onSearchToggle: _toggleSearch,
            onSearchChanged: _searchCrypto,
            walletBalance: walletBalance,
          ),
          Expanded(
            child: _buildContent(
              homeState.marketAssets,
              homeState.accountAssets,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    List<CryptoAssetWithMarketData> marketState,
    List<CryptoAssetWithMarketData> accountState,
  ) {
    final displayAssets = _isSearching ? _searchResults : marketState;
    debugPrint('accountState = ${accountState.length}');

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.myAssets,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context)!.seeAll,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: accountState.take(5).length,
              itemBuilder: (context, index) {
                final crypto = accountState[index];
                return CryptoCard(crypto: crypto);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              AppLocalizations.of(context)!.livePrices,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ...displayAssets.map((asset) => LivePriceTile(crypto: asset)),
        ],
      ),
    );

    // return const SizedBox.shrink();
  }

  String calculateWalletBalance(List<CryptoAssetWithMarketData> accountAssets) {
    try {
      double totalBalance = 0.0;
      for (var asset in accountAssets) {
        final balance = asset.asset.balance ?? 0.0;
        //final price = asset.marketData.currentPrice ?? 0.0;
        // TODO: This need to be re-checked when connected with coin market gecko
        // - $1 per crypto -
        const price = 1.0;
        final assetValue = balance * price;

        totalBalance += assetValue;
        debugPrint('Asset: ${asset.asset.assetCode}');
        debugPrint('Balance: ${asset.asset.balance}');
        debugPrint('Current Price: $price');
        debugPrint('Asset Value: $assetValue');
      }
      debugPrint('Balance Total: $totalBalance');
      return totalBalance.truncateToDecimalPlaces(2);
    } catch (e) {
      debugPrint('Error calculating wallet balance: ${e.toString()}');
      return '0.0';
    }
  }
}
