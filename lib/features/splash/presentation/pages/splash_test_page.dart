import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/features/crypto/domain/entities/crypto_asset_with_market_data.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/bloc_home/crypto_home_state.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/features/kyc/presentation/bloc/kyc_bloc.dart';
import 'package:nemorixpay/features/kyc/presentation/bloc/kyc_event.dart';
import 'package:nemorixpay/features/kyc/presentation/bloc/kyc_state.dart';

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
                    // Navigator.pushNamed(context, RouteNames.home2);
                    NemorixSnackBar.show(
                      // ignore: use_build_context_synchronously
                      context,
                      message: 'This button does not work in this test page!',
                      type: SnackBarType.error,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with AssetDetails",
                  onPressed: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   RouteNames.assetDetails,
                    //   arguments: getRandomAsset(),
                    // );
                    NemorixSnackBar.show(
                      // ignore: use_build_context_synchronously
                      context,
                      message: 'This button does not work in this test page!',
                      type: SnackBarType.error,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with BuyAsset",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.buyAsset,
                      arguments: CryptoAssetWithMarketData.toTest(),
                    );
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
                  text: "Continue with Testing Page",
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
                    //Navigator.pushNamed(context, RouteNames.testTransactions);
                    NemorixSnackBar.show(
                      // ignore: use_build_context_synchronously
                      context,
                      message: 'This button does not work in this test page!',
                      type: SnackBarType.error,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Terms Page",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.termsAndConditions);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Onboarding Security",
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteNames.onboardingPageSecurity);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Onboarding Features",
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteNames.onboardingPageFeatures);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Onboarding Benefits",
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteNames.onboardingPageBenefits);
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Receive Crypto",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.receiveCrypto,
                      arguments: {
                        'cryptoName': "XLM",
                        'logoAsset': "assets/logos/xlm_white.png",
                        'publicKey':
                            "GARRK43GDUGZKPGFPLTCXNOGGVZ27KL2RS3J5A4RUYVQOHAESSZ3AERL",
                      },
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Send Crypto",
                  onPressed: () {
                    NemorixSnackBar.show(
                      // ignore: use_build_context_synchronously
                      context,
                      message: 'This button does not work in this test page!',
                      type: SnackBarType.error,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Settings Page",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.settings,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Continue with Language Page",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.languagePage,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: "Test KYC WebView (Google.com)",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.kycPage,
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),

                // KYC BLoC Test Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'KYC BLoC Test',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocConsumer<KYCBloc, KYCState>(
                        listener: (context, state) {
                          if (state is KYCVerificationStarted) {
                            debugPrint(
                                '🔄 SplashTestPage: Navigating to KYC with URL: ${state.session.url}');
                            Navigator.pushNamed(
                              context,
                              RouteNames.kycPage,
                              arguments: state.session.url,
                            );
                          } else if (state is KYCError) {
                            NemorixSnackBar.show(
                              context,
                              message: 'Error: ${state.message}',
                              type: SnackBarType.error,
                            );
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              // Load KYC Status Button
                              RoundedElevatedButton(
                                text: "Load KYC Status",
                                onPressed: () {
                                  context
                                      .read<KYCBloc>()
                                      .add(const LoadKYCStatus());
                                },
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                              ),
                              const SizedBox(height: 10),

                              // Create KYC Session Button
                              RoundedElevatedButton(
                                text: state is KYCLoading
                                    ? "Creating..."
                                    : "Create KYC Session",
                                onPressed: state is KYCLoading
                                    ? null
                                    : () {
                                        context
                                            .read<KYCBloc>()
                                            .add(const CreateKYCSession());
                                      },
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              ),
                              const SizedBox(height: 10),

                              // Start KYC Verification Button
                              RoundedElevatedButton(
                                text: "Start KYC Verification",
                                onPressed: state is KYCLoading
                                    ? null
                                    : () {
                                        context
                                            .read<KYCBloc>()
                                            .add(const StartKYCVerification());
                                      },
                                backgroundColor: Colors.orange,
                                textColor: Colors.white,
                              ),
                              const SizedBox(height: 10),

                              // Clear KYC Session Button
                              RoundedElevatedButton(
                                text: "Clear KYC Session",
                                onPressed: () {
                                  context
                                      .read<KYCBloc>()
                                      .add(const ClearKYCSession());
                                },
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              ),
                              const SizedBox(height: 10),

                              // Status Display
                              if (state is KYCLoaded)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Status: ${state.status.name}'),
                                      Text(
                                          'Has Active Session: ${state.hasActiveSession}'),
                                      if (state.session != null) ...[
                                        Text(
                                            'Session ID: ${state.session!.sessionId}'),
                                        Text('URL: ${state.session!.url}'),
                                      ] else ...[
                                        const Text('No active session found'),
                                      ],
                                    ],
                                  ),
                                ),

                              if (state is KYCSessionCreated)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Session Created!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          'Session ID: ${state.session.sessionId}'),
                                      Text('URL: ${state.session.url}'),
                                      Text(
                                          'Status: ${state.session.status.name}'),
                                    ],
                                  ),
                                ),

                              if (state is KYCLoading)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                      SizedBox(width: 8),
                                      Text('Loading...'),
                                    ],
                                  ),
                                ),

                              if (state is KYCError)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Error',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(state.message),
                                    ],
                                  ),
                                ),

                              if (state is KYCSessionCleared)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Session cleared successfully',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),

                              if (state is KYCInitial)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Click "Load KYC Status" to start',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
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
