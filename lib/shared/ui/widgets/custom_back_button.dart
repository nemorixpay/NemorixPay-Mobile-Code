import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

/// @file        custom_back_button.dart
/// @brief       Implementation of a custom back button widget.
/// @details     This file contains the basic widget for creating a custom back button.
///              This widget is being used in the following files:
///              sign_up_page.dart, main_header.dart.
/// @author      Miguel Fagundez
/// @date        04/28/2025
/// @version     1.2
/// @copyright   Apache 2.0 License
class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
