import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/core/utils/image_url.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';
import 'package:nemorixpay/features/auth/ui/widgets/widgets.dart';
import 'package:nemorixpay/features/auth/ui/widgets/password_field.dart';
import 'package:nemorixpay/features/auth/ui/widgets/email_field.dart';

/// @file        sign_up_page.dart
/// @brief       Implementation of functions for basic user registration.
/// @details
/// @author      Miguel Fagundez
/// @date        04/25/2025
/// @version     1.2
/// @copyright   Apache 2.0 License
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _securityWordController = TextEditingController();
  DateTime? _birthDate;

  bool _agreedToTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _securityWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(ImageUrl.logo, width: 100, height: 100),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.onlyTakesAminute,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: _firstNameController,
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? AppLocalizations.of(
                                          context,
                                        )!.firstNameRequired
                                        : null,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            hintText: AppLocalizations.of(context)!.firstName,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTextFormField(
                            controller: _lastNameController,
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? AppLocalizations.of(
                                          context,
                                        )!.lastNameRequired
                                        : null,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            hintText: AppLocalizations.of(context)!.lastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    EmailField(
                      controller: _emailController,
                      hintText: AppLocalizations.of(context)!.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _passwordController,
                      hintText: AppLocalizations.of(context)!.password,
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _confirmPasswordController,
                      hintText:
                          AppLocalizations.of(context)!.confirmYourPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.confirmYourPassword;
                        }
                        if (value != _passwordController.text) {
                          return AppLocalizations.of(
                            context,
                          )!.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _securityWordController,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? AppLocalizations.of(
                                    context,
                                  )!.securityWordRequired
                                  : null,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: AppLocalizations.of(context)!.securityWord,
                    ),
                    const SizedBox(height: 16),
                    BirthdatePickerField(
                      selectedDate: _birthDate,
                      onDateSelected:
                          (date) => setState(() => _birthDate = date),
                      validator: (value) {
                        if (value == null) {
                          return AppLocalizations.of(
                            context,
                          )!.birthdateRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreedToTerms,
                          onChanged:
                              (value) => setState(
                                () => _agreedToTerms = value ?? false,
                              ),
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text:
                                  '${AppLocalizations.of(context)!.agreeWithNemorixPay} ',
                              children: [
                                TextSpan(
                                  text:
                                      AppLocalizations.of(
                                        context,
                                      )!.termsOfServices,
                                  style: TextStyle(
                                    color: NemorixColors.primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' ${AppLocalizations.of(context)!.and} ',
                                ),
                                TextSpan(
                                  text:
                                      AppLocalizations.of(
                                        context,
                                      )!.privacyPolicy,
                                  style: TextStyle(
                                    color: NemorixColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RoundedElevatedButton(
                      text: AppLocalizations.of(context)!.signUp,
                      onPressed:
                          !_agreedToTerms
                              ? null
                              : () {
                                if (_formKey.currentState!.validate() &&
                                    _birthDate != null &&
                                    _agreedToTerms) {
                                  // Flutter bloc action
                                } else {
                                  // Show errors
                                }
                              },
                      backgroundColor: NemorixColors.primaryColor,
                      textColor: Colors.black,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(AppLocalizations.of(context)!.or),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RoundedElevatedButton(
                      text: AppLocalizations.of(context)!.continueWithGoogle,
                      onPressed: () {
                        // Login with Google
                      },
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      icon: ImageUrl.googleLogo,
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        // Login Page
                      },
                      child: Text.rich(
                        TextSpan(
                          text:
                              "${AppLocalizations.of(context)!.alreadyRegistered}? ",
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.signIn,
                              style: TextStyle(
                                color: NemorixColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            const CustomBackButton(),
          ],
        ),
      ),
    );
  }
}
