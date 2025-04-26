import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/core/utils/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/auth/ui/widgets/forgot_password_dialog.dart';
import 'package:nemorixpay/features/auth/ui/widgets/widgets.dart';
import 'package:nemorixpay/features/auth/ui/widgets/password_field.dart';
import 'package:nemorixpay/features/auth/ui/widgets/email_field.dart';

/// @file        sign_in_page.dart
/// @brief       Implementation of functions for basic user authentication.
/// @details
/// @author      Miguel Fagundez
/// @date        04/26/2025
/// @version     1.3
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(ImageUrl.logo, width: 100, height: 100),
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.welcomeBack,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                        hintText: AppLocalizations.of(context)!.emailAddress,
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
                            style: TextStyle(color: NemorixColors.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      RoundedElevatedButton(
                        text: AppLocalizations.of(context)!.signIn,
                        onPressed: () {}, // Flutter bloc action
                        backgroundColor: NemorixColors.primaryColor,
                        textColor: Colors.black,
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
                    RoundedElevatedButton(
                      text: AppLocalizations.of(context)!.continueWithGoogle,
                      onPressed: () {},
                      backgroundColor: NemorixColors.greyLevel1,
                      textColor: Colors.white,
                      icon: ImageUrl.googleLogo,
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
                            style: TextStyle(color: NemorixColors.primaryColor),
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
      ),
    );
  }
}
