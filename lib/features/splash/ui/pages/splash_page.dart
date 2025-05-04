import 'package:flutter/material.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/shared/ui/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/features/cryptocurrency/data/mock_cryptos.dart';
import 'package:nemorixpay/features/cryptocurrency/domain/entities/crypto_entity.dart';
import 'dart:math';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  // TODO For testing purposes ----------------------------------
  CryptoEntity get randomCrypto {
    final random = Random();
    final index = random.nextInt(mockCryptos.length);
    return mockCryptos[index];
  }
  // TODO For testing purposes ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'list',
                        'area',
                        'word',
                        'can',
                        'sun',
                        'house',
                        'book',
                        'door',
                        'type',
                        'pencil',
                        'tree',
                        'color',
                        'list',
                        'area',
                        'word',
                        'can',
                        'sun',
                        'house',
                        'book',
                        'door',
                        'type',
                        'pencil',
                        'tree',
                        'color',
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
                        'list',
                        'area',
                        'word',
                        'can',
                        'sun',
                        'house',
                        'book',
                        'door',
                        'type',
                        'pencil',
                        'tree',
                        'color',
                      ],
                    );
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
