import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/core/utils/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';
import 'package:nemorixpay/features/auth/ui/widgets/forgot_password_dialog.dart';
import 'package:nemorixpay/features/auth/ui/widgets/widgets.dart';

/// @file        sign_in_page.dart
/// @brief       Implementation of functions for basic user authentication.
/// @details
/// @author      Miguel Fagundez
/// @date        04/05/2025
/// @version     1.0
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
  bool _isPasswordVisible = false;

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
                Image.asset(
                  ImageUrl.logo,
                  width: 100,
                  height: 100,
                  // color: Colors.white,
                ),
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
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: AppLocalizations.of(context)!.emailAddress,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.emailIsRequired;
                          }
                          if (!ValidationRules.emailValidation.hasMatch(
                            value,
                          )) {
                            return AppLocalizations.of(
                              context,
                            )!.enterValidEmail;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: AppLocalizations.of(context)!.password,
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.passwordIsRequired;
                          }
                          if (value.length < 6) {
                            return AppLocalizations.of(
                              context,
                            )!.passwordAtLeast6Characters;
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            // TODO: Temporal setState
                            setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder:
                            (BuildContext context) => ForgotPasswordDialog(),
                      );
                    },
                    child: Text(
                      "${AppLocalizations.of(context)!.forgotPassword}?",
                      style: TextStyle(color: NemorixColors.primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: AppLocalizations.of(context)!.signIn,
                  onPressed: () {}, // Flutter bloc action
                  backgroundColor: NemorixColors.primaryColor,
                  textColor: Colors.black,
                ),
                SizedBox(height: 30),
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
                SizedBox(height: 30),
                RoundedElevatedButton(
                  text: AppLocalizations.of(context)!.continueWithGoogle,
                  onPressed: () {},
                  backgroundColor: NemorixColors.greyLevel1,
                  textColor: Colors.white,
                  icon: ImageUrl.googleLogo,
                ),
                SizedBox(height: 40),
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
