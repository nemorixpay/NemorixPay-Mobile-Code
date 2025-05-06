import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// @file        birthdate_picker_field.dart
/// @brief       Implementation of a basic date picker widget.
/// @details     This file contains the basic widget for creating a custom date picker
///              This widget is being used in the following files:
///              sign_up_page.dart.
/// @author      Miguel Fagundez
/// @date        04/07/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class BirthdatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function(DateTime?) onDateSelected;
  final String? Function(DateTime?) validator;

  const BirthdatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.validator,
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        selectedDate != null
            ? DateFormat('dd-MMM-yyyy').format(
              selectedDate!,
            ) //DateFormat('yyyy-MM-dd').format(selectedDate!)
            : 'Select your birthdate';

    final errorText = validator(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _pickDate(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              dateText,
              style: TextStyle(
                color: selectedDate != null ? Colors.white : Colors.grey[600],
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 8),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
