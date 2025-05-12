import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_event.dart';
import 'package:nemorixpay/features/auth/presentation/bloc/auth_state.dart';
import 'package:nemorixpay/features/auth/presentation/controllers/email_verification_controller.dart';
import 'package:nemorixpay/shared/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/presentation/widgets/rounded_elevated_button.dart';

/// @file        verification_email_dialog.dart
/// @brief       Implementation of email verification dialog.
/// @details     This dialog is shown after user registration to inform about
///             email verification process and allow resending the verification email.
///             It includes a wait time control to prevent spam.
/// @author      Miguel Fagundez
/// @date        2024-05-08
/// @version     1.2
/// @copyright   Apache 2.0 License
class VerificationEmailDialog extends StatefulWidget {
  /// Whether the dialog is shown from signup page
  final bool isFromSignUp;

  const VerificationEmailDialog({super.key, this.isFromSignUp = false});

  @override
  State<VerificationEmailDialog> createState() =>
      _VerificationEmailDialogState();
}

class _VerificationEmailDialogState extends State<VerificationEmailDialog> {
  Timer? _timer;
  int _remainingMinutes = 0;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeTimer() async {
    _remainingMinutes = await EmailVerificationController.getRemainingMinutes();
    _canResend = await EmailVerificationController.canResendVerification();

    if (_remainingMinutes > 0) {
      _startTimer();
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      if (_remainingMinutes > 0) {
        setState(() {
          _remainingMinutes--;
        });
      } else {
        _canResend = await EmailVerificationController.canResendVerification();
        _timer?.cancel();
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  void _handleClose(BuildContext context) {
    Navigator.of(context).pop(); // Close dialog
    if (widget.isFromSignUp) {
      Navigator.of(
        context,
      ).pop(); // Close sign up page only if coming from signup
    }
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
            if (_remainingMinutes > 0) ...[
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(
                  context,
                )!.waitTimeMessage(_remainingMinutes),
                style: TextStyle(
                  color: NemorixColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  children: [
                    RoundedElevatedButton(
                      text:
                          AppLocalizations.of(context)!.resendVerificationEmail,
                      onPressed:
                          (state is VerificationEmailSending || !_canResend)
                              ? null
                              : () async {
                                await EmailVerificationController.recordVerificationAttempt();
                                context.read<AuthBloc>().add(
                                  const SendVerificationEmailRequested(),
                                );

                                // Wait for the email to be sent
                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );

                                // Close dialog and sign up page if coming from signup
                                if (context.mounted) {
                                  Navigator.of(context).pop(); // Close dialog
                                  if (widget.isFromSignUp) {
                                    Navigator.of(
                                      context,
                                    ).pop(); // Close sign up page
                                  }

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
