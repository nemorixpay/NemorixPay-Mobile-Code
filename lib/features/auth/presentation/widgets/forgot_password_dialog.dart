import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:nemorixpay/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:nemorixpay/shared/ui/widgets/rounded_elevated_button.dart';

/// @file        forgot_password_dialog.dart
/// @brief       Implementation of functions for resetting the user password.
/// @details
/// @author      Miguel Fagundez
/// @date        04/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handlePasswordReset() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        ForgotPasswordRequested(email: _emailController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.emailWasSent),
              backgroundColor: NemorixColors.successColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is ForgotPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: NemorixColors.errorColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)!.forgotPasswordTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.forgotPasswordSubtitle),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: CustomTextFormField(
                controller: _emailController,
                hintText: AppLocalizations.of(context)!.emailAddress,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.emailIsRequired;
                  }
                  if (!ValidationRules.emailValidation.hasMatch(value)) {
                    return AppLocalizations.of(context)!.enterValidEmail;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return RoundedElevatedButton(
                  text: AppLocalizations.of(context)!.sendEmail,
                  onPressed:
                      state is ForgotPasswordLoading
                          ? null
                          : _handlePasswordReset,
                  backgroundColor: NemorixColors.primaryColor,
                  textColor: Colors.black,
                  isLoading: state is ForgotPasswordLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
