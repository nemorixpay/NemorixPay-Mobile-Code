import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/core/utils/remember_me_helper.dart';
import 'package:nemorixpay/features/onboarding/data/datasources/onboarding_local_datasource_impl.dart';
import 'package:nemorixpay/features/terms/data/datasources/terms_local_datasource_impl.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/core/errors/auth/firebase_error_codes.dart';
import 'package:nemorixpay/core/errors/auth/firebase_failure.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/forgot_password_dialog.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/verification_email_dialog.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/widgets.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/password_field.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/email_field.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/line_divider_with_text.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @file        sign_in_page.dart
/// @brief       Sign In page implementation for NemorixPay authentication system.
/// @details     This page provides a complete sign-in experience including:
///             - Email and password authentication
///             - Social login options (Google, Apple)
///             - Password recovery
///             - Form validation
///             - Error handling with localized messages
///             - Loading states
///             - Responsive design
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.5
/// @copyright   Apache 2.0 License
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// @brief       State management for the Sign In page.
/// @details     Handles:
///             - Form state and validation
///             - Text controllers for input fields
///             - Authentication state changes
///             - Error message display
///             - Loading states
///             - Navigation
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Loads the remembered email if Remember Me was previously enabled
  Future<void> _loadRememberedEmail() async {
    try {
      final email = await RememberMeHelper.loadRememberedEmail();
      if (email != null) {
        setState(() {
          _emailController.text = email;
          _rememberMe = true;
        });
      }
    } catch (e) {
      debugPrint('Error loading remembered email: $e');
    }
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            SignInRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text,
              rememberMe: _rememberMe,
            ),
          );
    } else {
      NemorixSnackBar.show(
        context,
        message: AppLocalizations.of(context)!.enterYourLoginInfo,
      );
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        debugPrint('User Authenticated: Login');
        FirebaseAuth.instance.signOut();
        debugPrint('User was SignOut: Login');
      } else {
        debugPrint('User Unauthenticated: Login');
      }
    } catch (e) {
      debugPrint('Error _LoginPageState: $e');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          debugPrint('Auth State Changed: $state');

          if (state is AuthError) {
            final message = state.error is FirebaseFailure
                ? (state.error as FirebaseFailure).getLocalizedMessage(
                    context,
                  )
                : state.error.message;

            debugPrint('Displaying error message: $message');

            NemorixSnackBar.show(
              context,
              message: message,
              type: SnackBarType.error,
            );

            // Show verification dialog if email is not verified
            if (state.error is FirebaseFailure &&
                (state.error as FirebaseFailure).firebaseCode ==
                    FirebaseErrorCode.emailNotVerified.code) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) =>
                    const VerificationEmailDialog(),
              );
            }
          } else if (state is AuthAuthenticated) {
            debugPrint('User authenticated: ${state.user.email}');
            NemorixSnackBar.show(
              context,
              message: AppLocalizations.of(context)!.welcomeBack,
              type: SnackBarType.success,
            );
          } else if (state is PostAuthNavigationDetermined) {
            debugPrint('Post-auth navigation determined: ${state.route}');
            NemorixSnackBar.show(
              context,
              message: AppLocalizations.of(context)!.welcomeBack,
              type: SnackBarType.success,
            );
            // Navigate to the determined route
            Navigator.pushReplacementNamed(context, state.route);
          } else if (state is AuthAuthenticatedWithWallet) {
            debugPrint('User authenticated with wallet: ${state.user.email}');
            NemorixSnackBar.show(
              context,
              message: AppLocalizations.of(context)!.welcomeBack,
              type: SnackBarType.success,
            );
            // Navigate to home since user has wallet
            Navigator.pushReplacementNamed(context, RouteNames.home2);
          } else if (state is AuthAuthenticatedWithoutWallet) {
            debugPrint(
                'User authenticated without wallet: ${state.user.email}');
            NemorixSnackBar.show(
              context,
              message: AppLocalizations.of(context)!.welcomeBack,
              type: SnackBarType.success,
            );
            // Navigate to wallet setup since user doesn't have wallet
            Navigator.pushReplacementNamed(context, RouteNames.walletSetup);
          } else if (state is AuthUnauthenticated) {
            debugPrint('User Unauthenticated');
          } else if (state is AuthLoading) {
            debugPrint('Loading state..');
          } else if (state is AuthInitial) {
            debugPrint('Initial state..');
          } else {
            debugPrint('Last state option in SignIn');
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      ImageUrl.nemorixpayLogo,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 60),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.welcomeBack,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.youHaveBeenMissed,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: FormSection(
                        title: AppLocalizations.of(context)!.loginCredentials,
                        description:
                            AppLocalizations.of(context)!.enterYourLoginInfo,
                        children: [
                          EmailField(
                            controller: _emailController,
                            hintText:
                                AppLocalizations.of(context)!.emailAddress,
                          ),
                          PasswordField(
                            controller: _passwordController,
                            hintText: AppLocalizations.of(context)!.password,
                          ),
                          // Remember Me checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                                activeColor: NemorixColors.primaryColor,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _rememberMe = !_rememberMe;
                                    });
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.rememberMe,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const ForgotPasswordDialog(),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: const TextStyle(
                                  color: NemorixColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          RoundedElevatedButton(
                            text: AppLocalizations.of(context)!.signIn,
                            onPressed: state is AuthLoading
                                ? null
                                : _handleSignIn, // Flutter bloc action
                            backgroundColor: NemorixColors.primaryColor,
                            textColor: Colors.black,
                            isLoading: state is AuthLoading,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormSection(
                      title: AppLocalizations.of(context)!.loginOptions,
                      description:
                          AppLocalizations.of(context)!.chooseYourLoginMethod,
                      children: [
                        const SizedBox(height: 8),
                        LineDividerWithText(
                          text: AppLocalizations.of(context)!.or,
                        ),
                        const SizedBox(height: 16),
                        SocialLoginButtons(
                          onGooglePressed: () {
                            // TODO: Implement Google Sign In
                            NemorixSnackBar.show(context,
                                message: AppLocalizations.of(context)!
                                    .googleSignInNotImplemented);
                          },
                          onApplePressed: () {
                            // TODO: Implement Apple Sign In
                            NemorixSnackBar.show(context,
                                message: AppLocalizations.of(context)!
                                    .appleSignInNotImplemented);
                          },
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.dontHaveAnAccount}?",
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.signUp);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.signUp,
                                    style: const TextStyle(
                                      color: NemorixColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        LineDividerWithText(
                          text: AppLocalizations.of(context)!.testingPurposes,
                        ),
                        const SizedBox(height: 8),
                        RoundedElevatedButton(
                          text: localizations.showIndividualScreens,
                          onPressed: () {
                            Navigator.pushNamed(context, RouteNames.splashTest);
                          }, // Flutter bloc action
                          backgroundColor: NemorixColors.infoColor,
                          textColor: Colors.white,
                          // isLoading: state is AuthLoading,
                        ),
                        RoundedElevatedButton(
                          text: localizations.deletePublicPrivateKeys,
                          onPressed: () async {
                            try {
                              StellarSecureStorageDataSource
                                  stellarSecureStorageDataSource =
                                  StellarSecureStorageDataSource();
                              await stellarSecureStorageDataSource
                                  .deleteAllKeys();
                              // ignore: use_build_context_synchronously
                              NemorixSnackBar.show(context,
                                  message: localizations.allKeysDeleted);
                            } catch (e) {
                              debugPrint(
                                  'Error: All keys were not deleted - Apple Button: $e');
                            }
                          }, // Flutter bloc action
                          backgroundColor: NemorixColors.infoColor,
                          textColor: Colors.white,
                          // isLoading: state is AuthLoading,
                        ),
                        RoundedElevatedButton(
                          text: localizations.deleteTermsOfServices,
                          onPressed: () async {
                            //clearTermsAcceptance
                            TermsLocalDatasourceImpl datasource =
                                TermsLocalDatasourceImpl();
                            StellarSecureStorageDataSource
                                stellarSecureStorageDataSource =
                                StellarSecureStorageDataSource();
                            await datasource.clearTermsAcceptance();
                            await stellarSecureStorageDataSource
                                .deleteAllKeys();
                            // ignore: use_build_context_synchronously
                            NemorixSnackBar.show(context,
                                message: localizations.termsDeleted);
                          }, // Flutter bloc action
                          backgroundColor: NemorixColors.infoColor,
                          textColor: Colors.white,
                          // isLoading: state is AuthLoading,
                        ),
                        RoundedElevatedButton(
                          text: localizations.deleteOnboardingSteps,
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            OnboardingLocalDatasourceImpl datasource =
                                OnboardingLocalDatasourceImpl(prefs);

                            await datasource.resetOnboarding();
                            // ignore: use_build_context_synchronously
                            NemorixSnackBar.show(context,
                                message: localizations.onboardingReset);
                          }, // Flutter bloc action
                          backgroundColor: NemorixColors.infoColor,
                          textColor: Colors.white,
                          // isLoading: state is AuthLoading,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
