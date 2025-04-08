import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/core/utils/image_url.dart';
import 'package:nemorixpay/features/auth/ui/widgets/widgets.dart';

/// @file        sign_up_page.dart
/// @brief       Implementation of functions for basic user registration.
/// @details
/// @author      Miguel Fagundez
/// @date        04/05/2025
/// @version     1.0
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

  final bool _isPasswordVisible = false;
  final bool _isConfirmPasswordVisible = false;
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

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+');
    return emailRegex.hasMatch(email);
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
                        "Sign Up",
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
                        "It only takes a minute to create your account",
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
                                        ? 'First name is required'
                                        : null,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            hintText: 'First Name',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTextFormField(
                            controller: _lastNameController,
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Last name is required'
                                        : null,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            hintText: 'Last Name',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!_isValidEmail(value)) return 'Invalid email';
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      hintText: 'Email address',
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isPasswordVisible,
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isConfirmPasswordVisible,
                      hintText: 'Confirm Password',
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _securityWordController,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Security word is required'
                                  : null,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: 'Security word (for account recovery)',
                    ),
                    const SizedBox(height: 16),
                    BirthdatePickerField(
                      selectedDate: _birthDate,
                      onDateSelected:
                          (date) => setState(() => _birthDate = date),
                      validator: (value) {
                        if (value == null) {
                          return 'Birthdate is required';
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
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'I agree with NemorixPay ',
                              children: [
                                TextSpan(
                                  text: 'Terms of Services',
                                  style: TextStyle(
                                    color: NemorixColors.primaryColor,
                                  ),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
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
                      text: 'Sign Up',
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
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RoundedElevatedButton(
                      text: 'Continue with Google',
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
                      child: const Text.rich(
                        TextSpan(
                          text: "Already registered? ",
                          children: [
                            TextSpan(
                              text: "Sign In",
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
