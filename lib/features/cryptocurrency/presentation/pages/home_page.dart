import 'package:flutter/material.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/crypto_entity.dart';
import 'package:nemorixpay/features/cryptocurrency/presentation/widgets/asset_card.dart';
import 'package:nemorixpay/features/cryptocurrency/presentation/widgets/home_header.dart';
import 'package:nemorixpay/features/cryptocurrency/presentation/widgets/live_price_tile.dart';
import 'package:nemorixpay/features/cryptocurrency/data/mock_cryptos.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// @file        home_screen.dart
/// @brief       Home screen implementation for NemorixPay.
/// @details     This file contains the layout and logic for the main screen of NemorixPay,
///              including search, wallet balance, deposit/withdraw buttons, asset lists, and charts.
/// @author      Miguel Fagundez
/// @date        2025-04-11
/// @version     1
/// @copyright   Apache 2.0 License
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<CryptoEntity> _searchResults = mockCryptos;

  // Internal controller
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchResults = mockCryptos;
        _searchController.clear();
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _searchCrypto(String query) {
    setState(() {
      _searchResults =
          mockCryptos
              .where(
                (crypto) =>
                    crypto.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  // TODO For testing purposes ----------------------------------
  List<CryptoEntity> get myAssets => mockCryptos.take(5).toList();
  // TODO For testing purposes ----------------------------------

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isSearching) _toggleSearch();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                isSearching: _isSearching,
                onSearchToggle: _toggleSearch,
                onSearchChanged: _searchCrypto,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.myAssets,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              AppLocalizations.of(context)!.seeAll,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: myAssets.length,
                          itemBuilder: (context, index) {
                            final crypto = myAssets[index];
                            return AssetCard(crypto: crypto);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.livePrices,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ..._searchResults.map(
                        (crypto) => LivePriceTile(crypto: crypto),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
