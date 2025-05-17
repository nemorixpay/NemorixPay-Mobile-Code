import 'package:flutter/material.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/custom_text_form_field.dart';

/// @file        password_field.dart
/// @brief       Custom password field widget with visibility toggle.
/// @details     This widget extends CustomTextFormField to provide a password
///              input field with visibility toggle functionality. It includes
///              validation for password requirements and maintains consistent
///              styling with the app's design system.
/// @author      Miguel Fagundez
/// @date        04/25/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool showVisibilityToggle;
  final bool isConfirmPassword;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.showVisibilityToggle = true,
    this.isConfirmPassword = false,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      obscureText: !_isPasswordVisible,
      keyboardType: TextInputType.visiblePassword,
      validator: widget.validator ?? _defaultValidator,
      suffixIcon:
          widget.showVisibilityToggle
              ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
              : null,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.passwordIsRequired;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordAtLeast6Characters;
    }
    return null;
  }
}
