import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:nemorixpay/features/settings/presentation/bloc/settings_event.dart';
import 'package:nemorixpay/features/settings/presentation/bloc/settings_state.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/custom_button_tile.dart';

/// @file        settings_page.dart
/// @brief       Settings page UI for user profile and app configuration.
/// @details     Provides the visual structure for the Settings feature, including user profile, general and settings sections. Integrates NemorixPay theme and shared widgets for consistency.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.2
/// @copyright   Apache 2.0 License

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String? userName;
  late String? userEmail;
  String? userAvatar;

  @override
  void initState() {
    super.initState();

    userName = 'John Smith';
    userEmail = 'john.smith@email.com';

    final currentUser = FirebaseAuth.instance.currentUser;

    // Testing purposes
    userEmail =
        (currentUser == null) ? 'john.smith@email.com' : currentUser.email;
    userName = (currentUser == null) ? 'John Smith' : currentUser.displayName;

    // Load dark mode preference after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SettingsBloc>().add(LoadDarkModePreference());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        // Determine if dark mode is enabled based on current state
        bool isDarkMode = false;
        if (state is SettingsLoaded) {
          isDarkMode = state.isDarkMode;
        } else if (state is DarkModeToggled) {
          isDarkMode = state.isDarkMode;
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MainHeader(
                    title: appLocalizations.userProfile,
                    showBackButton: true,
                    showSearchButton: false,
                  ),
                  const SizedBox(height: 16),
                  // Avatar and user name
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 44,
                          backgroundImage: AssetImage(
                            userAvatar ?? ImageUrl.settingsUserAvatar,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          userName!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userEmail!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // General Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      appLocalizations.general,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Theme.of(context).hintColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Opciones de General
                  CustomButtonTile(
                    label: appLocalizations.myAccount,
                    function: () {
                      NemorixSnackBar.show(
                        context,
                        message: appLocalizations.featureNotImplemented,
                      );
                    },
                    widgetRight: const Icon(Icons.chevron_right),
                    widgetLeft: const Icon(
                      Icons.person_outline,
                      color: NemorixColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomButtonTile(
                    label: appLocalizations.billingPayment,
                    function: () {
                      NemorixSnackBar.show(
                        context,
                        message: appLocalizations.featureNotImplemented,
                      );
                    },
                    widgetRight: const Icon(Icons.chevron_right),
                    widgetLeft: const Icon(
                      Icons.credit_card_outlined,
                      color: NemorixColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomButtonTile(
                    label: appLocalizations.faqSupport,
                    function: () {
                      NemorixSnackBar.show(
                        context,
                        message: appLocalizations.featureNotImplemented,
                      );
                    },
                    widgetRight: const Icon(Icons.chevron_right),
                    widgetLeft: const Icon(
                      Icons.help_outline,
                      color: NemorixColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Setting Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      appLocalizations.setting,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Theme.of(context).hintColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButtonTile(
                    label: appLocalizations.language,
                    function: () {
                      NemorixSnackBar.show(
                        context,
                        message: appLocalizations.featureNotImplemented,
                      );
                    },
                    widgetRight: const Icon(Icons.chevron_right),
                    widgetLeft: const Icon(
                      Icons.language_outlined,
                      color: NemorixColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomButtonTile(
                    label: appLocalizations.security,
                    function: () {
                      NemorixSnackBar.show(
                        context,
                        message: appLocalizations.featureNotImplemented,
                      );
                    },
                    widgetRight: const Icon(Icons.chevron_right),
                    widgetLeft: const Icon(
                      Icons.security_outlined,
                      color: NemorixColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomButtonTile(
                    label: appLocalizations.darkMode,
                    function: () {},
                    widgetRight: Switch(
                      value: isDarkMode,
                      onChanged: (val) {
                        context.read<SettingsBloc>().add(ToggleDarkMode());
                      },
                    ),
                    widgetLeft: const Icon(
                      Icons.dark_mode_outlined,
                      color: NemorixColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
