import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';
import 'package:nemorixpay/features/auth/ui/widgets/custom_text_form_field.dart';
import 'package:nemorixpay/features/auth/ui/widgets/rounded_elevated_button.dart';

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
  TextEditingController forgotEmailController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.forgotPassword),
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
          RoundedElevatedButton(
            text: AppLocalizations.of(context)!.sendEmail,
            onPressed: () {
              if (kDebugMode) {
                print('Email Sent using the Custom Button');
              }
              /*
    //          final alert = BaseAlertDialog(
    //                 title: AppLocalizations.of(context)!.information_title,
    //                 content: AppLocalizations.of(context)!.email_was_sent,
    //                 yesOnPressed: () {},
    //                 noOnPressed: () {},
    //                 yes: '',
    //                 no: AppLocalizations.of(context)!.ok);
    //             showDialog(context: context, builder: (_) => alert);
    //          */
            }, // Flutter bloc action
            backgroundColor: NemorixColors.primaryColor,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
