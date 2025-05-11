import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:nemorixpay/shared/ui/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/ui/widgets/rounded_elevated_button.dart';

/// @file        verification_email_dialog.dart
/// @brief       Implementation of email verification dialog.
/// @details     This dialog is shown after user registration to inform about
///             email verification process and allow resending the verification email.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.0
/// @copyright   Apache 2.0 License
class VerificationEmailDialog extends StatelessWidget {
  const VerificationEmailDialog({super.key});

  void _handleClose(BuildContext context) {
    Navigator.of(context).pop(); // Close dialog
    Navigator.of(context).pop(); // Close sign up page
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)!.verifyEmailTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.verifyEmailSubtitle),
            const SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  children: [
                    RoundedElevatedButton(
                      text:
                          AppLocalizations.of(context)!.resendVerificationEmail,
                      onPressed:
                          state is VerificationEmailSending
                              ? null
                              : () async {
                                context.read<AuthBloc>().add(
                                  const SendVerificationEmailRequested(),
                                );

                                // Wait for the email to be sent
                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );

                                // Close dialog and sign up page
                                if (context.mounted) {
                                  Navigator.of(context).pop(); // Close dialog
                                  Navigator.of(
                                    context,
                                  ).pop(); // Close sign up page

                                  // Show success message
                                  NemorixSnackBar.show(
                                    context,
                                    message:
                                        AppLocalizations.of(
                                          context,
                                        )!.verificationEmailSent,
                                    borderColor: NemorixColors.successColor,
                                  );
                                }
                              },
                      backgroundColor: NemorixColors.primaryColor,
                      textColor: Colors.black,
                      isLoading: state is VerificationEmailSending,
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => _handleClose(context),
                      child: Text(
                        AppLocalizations.of(context)!.iReceivedTheEmail,
                        style: TextStyle(
                          color: NemorixColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
