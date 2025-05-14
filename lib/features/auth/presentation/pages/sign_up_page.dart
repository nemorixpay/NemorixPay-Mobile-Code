import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/core/errors/firebase_failure.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/widgets.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/password_field.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/email_field.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/verification_email_dialog.dart';
import 'package:nemorixpay/shared/presentation/widgets/nemorix_snackbar.dart';

/// @file        sign_up_page.dart
/// @brief       Sign Up page implementation for NemorixPay authentication system.
/// @details     This page provides a complete user registration experience including:
///             - Personal information collection (name, birthdate)
///             - Account credentials setup (email, password)
///             - Security word for account recovery
///             - Terms and conditions acceptance
///             - Form validation with localized error messages
///             - Social sign-up options (Google, Apple)
///             - Responsive design with scrollable layout
///             - Error handling and loading states
///             - Navigation between auth screens
///             - Security features (password confirmation)
///             - User-friendly feedback messages
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.4
/// @copyright   Apache 2.0 License

/// SignUpPage widget that handles the user registration process.
/// This is a stateful widget that manages form state, validation,
/// and user input for the registration process.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

/// State class for SignUpPage that manages:
/// - Form controllers for all input fields
/// - Form validation state
/// - User input handling
/// - Registration process
/// - Error handling and feedback
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

  /// Handles the sign up process when the user submits the form.
  /// This method:
  /// 1. Validates all form fields
  /// 2. Checks terms and conditions acceptance
  /// 3. Shows appropriate error messages if validation fails
  /// 4. Triggers the registration process through AuthBloc
  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreedToTerms) {
        NemorixSnackBar.show(
          context,
          message: AppLocalizations.of(context)!.acceptTermsAndConditions,
          type: SnackBarType.warning,
        );
        return;
      }
      context.read<AuthBloc>().add(
        SignUpRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          birthDate: _birthDate!,
          securityWord: _securityWordController.text.trim(),
        ),
      );
      return;
    }
    NemorixSnackBar.show(
      context,
      message: AppLocalizations.of(context)!.fillRegistrationData,
      type: SnackBarType.error,
    );
  }

  /// Builds the main UI of the registration page.
  /// The layout includes:
  /// - App logo and branding
  /// - Form sections for personal info, account details, and security
  /// - Terms and conditions checkbox
  /// - Registration button with loading state
  /// - Navigation options (back button, sign in link)
  /// - Social login options
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          final message =
              state.error is FirebaseFailure
                  ? (state.error as FirebaseFailure).getLocalizedMessage(
                    context,
                  )
                  : state.error.message;

          NemorixSnackBar.show(
            context,
            message: message,
            type: SnackBarType.error,
          );
        }
        if (state is AuthAuthenticated) {
          // Show success message
          NemorixSnackBar.show(
            context,
            message: AppLocalizations.of(context)!.registrationSuccess,
            type: SnackBarType.success,
          );

          // Show dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (BuildContext dialogContext) =>
                    const VerificationEmailDialog(isFromSignUp: true),
          );
        }
      },
      child: Scaffold(
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
                      Image.asset(
                        ImageUrl.nemorixpayLogo,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 20),
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

                      FormSection(
                        title:
                            AppLocalizations.of(context)!.personalInformation,
                        description:
                            AppLocalizations.of(context)!.enterYourPersonalInfo,
                        children: [
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
                                  hintText:
                                      AppLocalizations.of(context)!.firstName,
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
                                  hintText:
                                      AppLocalizations.of(context)!.lastName,
                                ),
                              ),
                            ],
                          ),
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
                        ],
                      ),

                      FormSection(
                        title: AppLocalizations.of(context)!.accountInformation,
                        description:
                            AppLocalizations.of(context)!.enterYourAccountInfo,
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
                          PasswordField(
                            controller: _confirmPasswordController,
                            hintText:
                                AppLocalizations.of(
                                  context,
                                )!.confirmYourPassword,
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
                        ],
                      ),

                      FormSection(
                        title: AppLocalizations.of(context)!.security,
                        description:
                            AppLocalizations.of(context)!.enterYourSecurityInfo,
                        children: [
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
                            hintText:
                                AppLocalizations.of(context)!.securityWord,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
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
                            child: Text(
                              AppLocalizations.of(context)!.agreeToTerms,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return RoundedElevatedButton(
                            text: AppLocalizations.of(context)!.signUp,
                            onPressed:
                                state is AuthLoading ? null : _handleSignUp,
                            backgroundColor: NemorixColors.primaryColor,
                            textColor: Colors.black,
                            isLoading: state is AuthLoading,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.alreadyHaveAnAccount,
                        ),
                      ),
                      const SizedBox(height: 24),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const CustomBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
