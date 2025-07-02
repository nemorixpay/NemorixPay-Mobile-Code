import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_event.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        success_page.dart
/// @brief       Success page for different results in NemorixPay.
/// @details     This page is shown after the user successfully creates or imports a wallet or a transaction has been sent.
///              It displays a success icon, important security messages, and a button to go to the home page.
/// @author      Miguel Fagundez
/// @date        07/01/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class SuccessPage extends StatefulWidget {
  final String titleSuccess;
  final String firstParagraph;
  final String? secondParagraph;
  const SuccessPage({
    super.key,
    required this.titleSuccess,
    required this.firstParagraph,
    this.secondParagraph,
  });

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      // Success Icon
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: NemorixColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: NemorixColors.mainBlack,
                            size: 60,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Success Message
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          widget.titleSuccess,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // First paragraph
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          widget.firstParagraph,
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Second paragraph
                      if (widget.secondParagraph != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            widget.secondParagraph ?? '',
                            style: theme.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 32.0,
                        ),
                        child: RoundedElevatedButton(
                          text: l10n.goToHomePage,
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.home2,
                              (route) => false,
                            );
                          },
                          backgroundColor: NemorixColors.primaryColor,
                          textColor: NemorixColors.mainBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
