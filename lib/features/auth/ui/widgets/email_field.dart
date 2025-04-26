import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/features/auth/ui/widgets/custom_text_form_field.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';

/// @file        email_field.dart
/// @brief       Custom email field widget with enhanced validation.
/// @details     This widget extends CustomTextFormField to provide an email
///              input field with robust validation. It includes validation for
///              email format according to RFC 5322 standards and maintains
///              consistent styling with the app's design system.
/// @author      Miguel Fagundez
/// @date        04/25/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const EmailField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.emailAddress,
      validator: validator ?? (value) => _defaultValidator(value, context),
    );
  }

  static String? _defaultValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emailIsRequired;
    }

    if (!ValidationRules.emailValidationRFC5322.hasMatch(value)) {
      return AppLocalizations.of(context)!.enterValidEmail;
    }

    if (value.length > ValidationRules.maxEmailLength) {
      return AppLocalizations.of(context)!.enterValidEmail;
    }

    return null;
  }
}
