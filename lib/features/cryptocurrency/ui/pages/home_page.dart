import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entity/crypto_entity.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/asset_card.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/deposit_withdraw_buttons.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/live_price_tile.dart';
import 'package:nemorixpay/features/cryptocurrency/ui/widgets/wallet_balance.dart';
import 'package:nemorixpay/shared/data/mock_cryptos.dart';

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
  List<Crypto> _searchResults = mockCryptos;

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
  List<Crypto> get myAssets => mockCryptos.take(5).toList();
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
              Container(
                decoration: const BoxDecoration(
                  color: NemorixColors.primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (!_isSearching)
                          IconButton(
                            icon: Icon(
                              _isSearching ? Icons.close : Icons.search,
                              color: Colors.black,
                            ),
                            onPressed: _toggleSearch,
                          ),
                        _isSearching
                            ? Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: _searchCrypto,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                ),
                                autofocus: true,
                              ),
                            )
                            : Expanded(
                              child: const Text(
                                'NemorixPay',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                        const SizedBox(width: 8),
                        if (_isSearching)
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.black),
                            onPressed: _toggleSearch,
                          ),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const WalletBalance(balance: '\$12,345.67'),
                    const DepositWithdrawButtons(),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  //padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            const Text(
                              'My Assets',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'See All',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
                        child: const Text(
                          'Live Prices',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
