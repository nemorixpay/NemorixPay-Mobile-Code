import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';

/// @file        country_picker_field.dart
/// @brief       Country picker field widget for user registration.
/// @details     This widget provides a country selection field using country_picker
///              package. It displays the selected country with flag and name, and
///              allows users to search and select from a list of all countries.
///              The widget follows the same styling pattern as other form fields
///              in the signup form.
/// @author      Miguel Fagundez
/// @date        11/04/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CountryPickerField extends StatelessWidget {
  final Country? selectedCountry;
  final void Function(Country) onCountrySelected;
  final String? Function(Country?)? validator;
  final String hintText;

  const CountryPickerField({
    super.key,
    required this.selectedCountry,
    required this.onCountrySelected,
    required this.validator,
    required this.hintText,
  });

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      favorite: <String>['US', 'MX'], // Default favorites
      showPhoneCode: false,
      onSelect: (Country country) {
        onCountrySelected(country);
      },
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        inputDecoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.searchCountry,
          hintText: AppLocalizations.of(context)!.startTypingToSearch,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: NemorixColors.primaryColor,
              width: 1,
            ),
          ),
        ),
        searchTextStyle: Theme.of(context).textTheme.bodyLarge,
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayText = selectedCountry != null
        ? '${selectedCountry!.flagEmoji} ${selectedCountry!.name}'
        : hintText;

    final errorText = validator != null ? validator!(selectedCountry) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showCountryPicker(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null
                    ? NemorixColors.errorColor
                    : (selectedCountry != null
                        ? NemorixColors.primaryColor
                        : Colors.grey),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayText,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: selectedCountry != null
                              ? Theme.of(context).textTheme.titleMedium?.color
                              : Colors.grey[600],
                        ),
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 8),
            child: Text(
              errorText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: NemorixColors.errorColor,
                    fontSize: 12,
                  ),
            ),
          ),
      ],
    );
  }
}
