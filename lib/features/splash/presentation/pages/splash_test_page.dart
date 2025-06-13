import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_state.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        splash_test_page.dart
/// @brief       Temporary test page for NemorixPay UI components.
/// @details     This file contains a temporary test page that displays all created
///              screens for basic visual testing purposes. This is a temporary
///              implementation and will be removed in production.
/// @author      Miguel Fagundez
/// @date        2025-05-06
/// @version     1.0
/// @copyright   Apache 2.0 License
class SplashTestPage extends StatefulWidget {
  const SplashTestPage({super.key});

  @override
  State<SplashTestPage> createState() => _SplashTestPageState();
}

class _SplashTestPageState extends State<SplashTestPage> {
  late final CryptoAssetWithMarketData asset;

  @override
  void initState() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        debugPrint('User Authenticated');
        FirebaseAuth.instance.signOut();
        debugPrint('User was SignOut');
      } else {
        debugPrint('User Unauthenticated');
      }
    } catch (e) {
      debugPrint('Error _SplashTestPageState: $e');
    }
    super.initState();
  }

  CryptoAssetWithMarketData getRandomAsset() {
    final listOfAssets =
        context.read<CryptoHomeBloc>().state as CryptoHomeLoaded;
    final asset = listOfAssets.accountAssets[0];
    return asset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Page')),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageUrl.nemorixpayLogo, width: 100, height: 100),
                SizedBox(height: 40),
                Text(AppLocalizations.of(context)!.appName),
                // TODO This is only for testing purposes
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with SignIn",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.signIn);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with SignUp",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.signUp);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Home2",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.home2);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with AssetDetails",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.assetDetails,
                      arguments: getRandomAsset(),
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with BuyAsset",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.buyAsset);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Payment Method",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.paymentMethod,
                      arguments: {
                        'assetName': "BTC",
                        'amount': 1000.0,
                        'currency': "USD",
                      },
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Wallet Setup",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.walletSetup);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Import Seed Phrase",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.importSeedPhrase);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Show Seed Phrase",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.showSeedPhrase,
                      arguments: [
                        'rule',
                        'topic',
                        'trick',
                        'clutch',
                        'sketch',
                        'same',
                        'filter',
                        'myself',
                        'material',
                        'option',
                        'flee',
                        'leave',
                      ],
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Confirm Seed Phrase",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.confirmSeedPhrase,
                      arguments: [
                        'rule',
                        'topic',
                        'trick',
                        'clutch',
                        'sketch',
                        'same',
                        'filter',
                        'myself',
                        'material',
                        'option',
                        'flee',
                        'leave',
                      ],
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Wallet Success Creation",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.successWalletCreation,
                      arguments:
                          AppLocalizations.of(
                            context,
                          )!.importWalletSuccessTitle,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Tetsing Page",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.testingPage);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Transactions Page",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.testTransactions);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
