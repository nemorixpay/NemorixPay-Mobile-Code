import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/widgets/custom_two_buttons.dart';
import 'package:nemorixpay/features/terms/presentation/widgets/terms_section.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import '../bloc/terms_bloc.dart';
import '../bloc/terms_event.dart';
import '../bloc/terms_state.dart';
import '../../domain/usecases/get_terms_content.dart';
import '../../domain/usecases/accept_terms.dart';
import '../../domain/repositories/terms_repository.dart';

/// @file        terms_page.dart
/// @brief       Terms and Conditions page UI.
/// @details     Displays the terms content, last update, and accept/decline actions with localization support.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class _LocalTermsRepository implements TermsRepository {
  // TODO _LocalTermsRepository - Testing purposes only
  // TODO Need to changed in future - Text from file or API call
  final String content;
  _LocalTermsRepository(this.content);

  @override
  Future<String> getTermsContent() async => content;

  @override
  Future<void> acceptTerms(String version, DateTime acceptedAt) async {}
}

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final termsContent = localizations.termsContent;

    // TEMPORAL - We need to connect with real repository: Server or LocalDatabase
    final repository = _LocalTermsRepository(termsContent);

    return BlocProvider(
      create:
          (context) => TermsBloc(
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
            return _TermsContent(
              content: state.content,
              isAccepted: state.isAccepted,
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

  const _TermsContent({required this.content, required this.isAccepted});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
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
                showBackButton: true,
                showSearchButton: false,
              ),
              SizedBox(height: 40),
              Text(
                '${localizations.lastUpdate} June 2025',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        content,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 32),
                      TermsSection(
                        sectionTitle: localizations.termsTitle,
                        sectionBody: localizations.termsBody,
                      ),
                      SizedBox(height: 32),
                      TermsSection(
                        sectionTitle: localizations.licenseTitle,
                        sectionBody: localizations.licenseBody,
                      ),
                      TermsSection(
                        sectionTitle: '',
                        sectionBody: localizations.licenseBody,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
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
                      onFunctionButton1: () {
                        debugPrint('Button01 - Decline');
                        Navigator.of(context).pop(false);
                      },
                      textButton2: localizations.accept,
                      onFunctionButton2:
                          isAccepted
                              ? () {
                                // We need to save the date/time of accepting terms
                                // context.read<TermsBloc>().add(
                                //   AcceptTermsEvent(
                                //     version: '1.0',
                                //     acceptedAt: DateTime.now(),
                                //   ),
                                // );
                                debugPrint('Button01 - Accept');
                              }
                              : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
