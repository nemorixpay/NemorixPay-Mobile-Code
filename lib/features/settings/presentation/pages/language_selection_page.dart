import 'package:flutter/material.dart';
import 'package:nemorixpay/config/constants/app_constants.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/features/settings/presentation/widgets/language_list_item.dart';
import 'package:nemorixpay/features/settings/presentation/widgets/language_search_bar.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/rounded_elevated_button.dart';

/// @file        language_selection_page.dart
/// @brief       Language selection page for NemorixPay app.
/// @details     Allows users to select their preferred language from a list of supported languages.
///              Features search functionality and visual selection indicators.
/// @author      Miguel Fagundez
/// @date        07/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String _selectedLanguage = AppConstants.languageDefault;
  String _searchQuery = '';
  bool _hasChanges = false;

  // Sample language data - replace with actual data
  final List<Map<String, dynamic>> _languages = [
    {
      AppConstants.languageName: 'English',
      AppConstants.languageFlag: 'assets/images/flags/en_flag.png',
      AppConstants.languageCode: 'en',
    },
    {
      AppConstants.languageName: 'Spanish',
      AppConstants.languageFlag: 'assets/images/flags/es_flag.png',
      AppConstants.languageCode: 'es',
    },
    {
      AppConstants.languageName: 'Portuguese',
      AppConstants.languageFlag: 'assets/images/flags/pt_flag.png',
      AppConstants.languageCode: 'pt',
    },
  ];

  List<Map<String, dynamic>> get _filteredLanguages {
    if (_searchQuery.isEmpty) {
      return _languages;
    }
    return _languages
        .where((language) => language[AppConstants.languageName]
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _onLanguageSelected(String languageName) {
    if (_selectedLanguage != languageName) {
      setState(() {
        _selectedLanguage = languageName;
        _hasChanges = true;
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _saveChanges() {
    // TODO: Implement save functionality
    NemorixSnackBar.show(
      context,
      message: AppLocalizations.of(context)!.featureNotImplemented,
      type: SnackBarType.info,
    );
    setState(() {
      _hasChanges = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              MainHeader(
                title: appLocalizations.selectLanguage,
                showBackButton: true,
                showSearchButton: false,
              ),
              const SizedBox(
                height: 24,
              ),
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LanguageSearchBar(
                  onSearchChanged: _onSearchChanged,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              // Language List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _filteredLanguages.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: NemorixColors.greyLevel2,
                    height: 3,
                    thickness: 2,
                  ),
                  itemBuilder: (context, index) {
                    final language = _filteredLanguages[index];
                    final isSelected = language[AppConstants.languageName] ==
                        _selectedLanguage;

                    return LanguageListItem(
                      languageName: language[AppConstants.languageName],
                      flagAsset: language[AppConstants.languageFlag],
                      isSelected: isSelected,
                      onTap: () => (index != 2)
                          ? _onLanguageSelected(
                              language[AppConstants.languageName])
                          : null,
                    );
                  },
                ),
              ),
              // Save Button
              Padding(
                padding: const EdgeInsets.all(12),
                child: RoundedElevatedButton(
                  text: appLocalizations.saveChanges,
                  onPressed: _hasChanges ? _saveChanges : null,
                  backgroundColor: NemorixColors.primaryColor,
                  textColor: _hasChanges
                      ? NemorixColors.greyLevel1
                      : NemorixColors.greyLevel3,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
