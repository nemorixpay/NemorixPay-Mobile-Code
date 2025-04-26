import 'package:flutter/material.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/shared/ui/widgets/rounded_elevated_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                Navigator.pushNamed(context, RouteNames.cryptoDetails);
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
                Navigator.pushNamed(context, RouteNames.paymentMethod);
              },
              backgroundColor: Colors.white,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
