import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/single_action_dialog.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/yes_no_dialog.dart';
import '../bloc/terms_bloc.dart';
import '../bloc/terms_event.dart';
import '../bloc/terms_state.dart';
import '../../domain/usecases/accept_terms.dart';
import '../../domain/usecases/get_terms_content.dart';
import '../../data/repositories/terms_repository_impl.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/features/terms/presentation/widgets/terms_section.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/custom_two_buttons.dart';
import 'package:nemorixpay/features/terms/data/datasources/terms_local_datasource_impl.dart';

/// @file        terms_page.dart
/// @brief       Terms and Conditions page UI.
/// @details     Displays the terms content, last update, and accept/decline actions with localization support.
///              Now uses real SharedPreferences storage for terms acceptance.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

class TermsPage extends StatelessWidget {
  final bool? isOnboarding;
  const TermsPage({super.key, this.isOnboarding = true});

  @override
  Widget build(BuildContext context) {
    // Use real datasource and repository with SharedPreferences
    // This needs to be checked/changed in main.dart
    // ------------
    // TEMPORAL
    // ------------
    final datasource = TermsLocalDatasourceImpl();
    final repository = TermsRepositoryImpl(datasource);

    return BlocProvider(
      create: (context) => TermsBloc(
        getTermsContent: GetTermsContent(repository),
        acceptTerms: AcceptTerms(repository),
      )..add(LoadTerms()),
      child: BlocBuilder<TermsBloc, TermsState>(
        builder: (context, state) {
          if (state is TermsLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is TermsError) {
            return Scaffold(body: Center(child: Text(state.message)));
          }
          if (state is TermsLoaded) {
            debugPrint('Terms loaded: ${state.content}');
            return _TermsContent(
              content: state.content,
              isAccepted: state.isAccepted,
              isOnboarding: isOnboarding ?? true,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _TermsContent extends StatelessWidget {
  final String content;
  final bool isAccepted;
  final bool isOnboarding;

  const _TermsContent({
    required this.content,
    required this.isAccepted,
    required this.isOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    debugPrint('_TermsContent. isOnboarding = $isOnboarding');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --------------------
              // Back button/Title
              // --------------------
              MainHeader(
                title: localizations.termsOfServices,
                showBackButton: !isOnboarding,
                showSearchButton: false,
              ),
              const SizedBox(height: 40),
              Text(
                localizations.lastUpdate,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TermsSection(
                        sectionTitle: localizations.termsTitleTesting,
                        sectionBody: localizations.loremIpsumContent,
                      ),
                      const SizedBox(height: 32),
                      TermsSection(
                        sectionTitle: localizations.termsTitle,
                        sectionBody: localizations.termsBody,
                      ),
                      const SizedBox(height: 32),
                      TermsSection(
                        sectionTitle: localizations.licenseTitle,
                        sectionBody: localizations.licenseBody,
                      ),
                      const SizedBox(height: 32),
                      TermsSection(
                        sectionTitle: localizations.loremIpsumTitle,
                        sectionBody: localizations.loremIpsumContent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (isOnboarding)
                Row(
                  children: [
                    Checkbox(
                      value: isAccepted,
                      onChanged: (_) {
                        context.read<TermsBloc>().add(ToggleAcceptance());
                      },
                    ),
                    Flexible(child: Text(localizations.acceptTermsCheckbox)),
                  ],
                ),
              const SizedBox(height: 8),
              if (isOnboarding)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // --------------------
                    // Decline/Accept Buttons
                    // --------------------
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomTwoButtons(
                        height: 1.25,
                        textButton1: localizations.decline,
                        onFunctionButton1: () async {
                          debugPrint('Button01 - Decline4');
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) => YesNoDialog(
                              title: localizations.termsOfServices,
                              message: localizations.confirmDeclineTerms,
                              onYesPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(RouteNames.signIn);
                              },
                              onNoPressed: () {
                                Navigator.of(context).pop();
                              },
                              yesText: localizations.yesDecline,
                              noText: localizations.noContinue,
                            ),
                          );
                        },
                        textButton2: localizations.accept,
                        onFunctionButton2: isAccepted
                            ? () async {
                                try {
                                  // Save terms acceptance
                                  context.read<TermsBloc>().add(
                                        AcceptTermsEvent(
                                          version: '1.0',
                                          acceptedAt: DateTime.now(),
                                        ),
                                      );

                                  debugPrint('Button02 - Accept');

                                  // Navigate to wallet setup after accepting terms
                                  Navigator.of(context).pushReplacementNamed(
                                      RouteNames.walletSetup);
                                } catch (e) {
                                  debugPrint('Error accepting terms: $e');
                                  // Show error message to user
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Error accepting terms: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              if (!isOnboarding)
                RoundedElevatedButton(
                  text: AppLocalizations.of(context)!.continueText,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: NemorixColors.primaryColor,
                  textColor: NemorixColors.greyLevel1,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
