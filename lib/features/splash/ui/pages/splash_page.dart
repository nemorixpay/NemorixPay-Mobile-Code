import 'package:flutter/material.dart';
import 'package:nemorixpay/core/utils/image_url.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/l10n/l10n.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageUrl.logo, width: 100, height: 100),
            SizedBox(height: 64),
            Text(AppLocalizations.of(context)!.appName),
          ],
        ),
      ),
    );
  }
}
