import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/shared/presentation/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/features/cryptocurrency/data/mock_cryptos.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/crypto_entity.dart';
import 'dart:math';

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
  // TODO For testing purposes ----------------------------------
  CryptoEntity get randomCrypto {
    final random = Random();
    final index = random.nextInt(mockCryptos.length);
    return mockCryptos[index];
  }
  // TODO For testing purposes ----------------------------------

  @override
  void initState() {
    // TODO: implement initState
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
                  text: "Continue with Home",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.home);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with CryptoDetails",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.cryptoDetails,
                      arguments: randomCrypto,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with BuyCrypto",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.buyCrypto);
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
                      /**cryptoName: args['cryptoName'] as String,
                    amount: args['amount'] as double,
                    currency: args['currency'] as String, */
                      arguments: {
                        'cryptoName': "BTC",
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
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
