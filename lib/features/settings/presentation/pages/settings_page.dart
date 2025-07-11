import 'package:flutter/material.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/custom_button_tile.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
// Importa aquí otros widgets reutilizables según sea necesario

/// @file        settings_page.dart
/// @brief       Settings page UI for user profile and app configuration.
/// @details     Provides the visual structure for the Settings feature, including user profile, general and settings sections. Integrates NemorixPay theme and shared widgets for consistency.
/// @author      Miguel Fagundez
/// @date        2024-06-08
/// @version     1.0
/// @copyright   Apache 2.0 License

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool value;
  late String userName;
  late String userEmail;
  String? userAvatar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    value = false;
    userName = 'John Smith';
    userEmail = 'john.smith@email.com';
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
                      userName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userEmail,
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
                  value: value,
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                    NemorixSnackBar.show(
                      context,
                      message: appLocalizations.featureNotImplemented,
                    );
                  },
                  activeColor: NemorixColors.primaryColor,
                  activeTrackColor: NemorixColors.greyLevel2,
                  inactiveThumbColor: NemorixColors.greyLevel3,
                  inactiveTrackColor: NemorixColors.greyLevel5,
                ),
                widgetLeft: const Icon(
                  Icons.credit_card_outlined,
                  color: NemorixColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
