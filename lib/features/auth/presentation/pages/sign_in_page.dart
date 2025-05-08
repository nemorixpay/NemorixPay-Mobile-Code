import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/forgot_password_dialog.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/widgets.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/password_field.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/email_field.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/social_login_buttons.dart';

/// @file        sign_in_page.dart
/// @brief       Implementation of functions for basic user authentication.
/// @details
/// @author      Miguel Fagundez
/// @date        04/26/2025
/// @version     1.4
/// @copyright   Apache 2.0 License

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignInRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error -  Email & Password required'),
          backgroundColor: Colors.red,
        ),
      );
    }
    // try {
    //   FirebaseAuth.instance.signOut();
    //   debugPrint('User Unauthenticated (signOut)');
    // } catch (e) {
    //   debugPrint('Error (signOut)');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          debugPrint('Auth State Changed: $state'); // Debug log
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthAuthenticated) {
            // Manejar navegación cuando el usuario está autenticado
            debugPrint('User authenticated: ${state.user.email}'); // Debug log
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.user.email),
                backgroundColor: Colors.green,
              ),
            );
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
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      ImageUrl.nemorixpayLogo,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 60),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.welcomeBack,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.youHaveBeenMissed,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder:
                                      (BuildContext context) =>
                                          ForgotPasswordDialog(),
                                );
                              },
                              child: Text(
                                "${AppLocalizations.of(context)!.forgotPassword}?",
                                style: TextStyle(
                                  color: NemorixColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          RoundedElevatedButton(
                            text: AppLocalizations.of(context)!.signIn,
                            onPressed:
                                state is AuthLoading
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
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(AppLocalizations.of(context)!.or),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SocialLoginButtons(
                          onGooglePressed: () {
                            // TODO: Implement Google Sign In
                          },
                          onApplePressed: () {
                            // TODO: Implement Apple Sign In
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.signUp,
                                style: TextStyle(
                                  color: NemorixColors.primaryColor,
                                ),
                              ),
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
        },
      ),
    );
  }
}
