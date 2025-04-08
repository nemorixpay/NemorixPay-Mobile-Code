import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

/// @file        custom_back_button.dart
/// @brief       Implementation of a custom back button widget.
/// @details     This file contains the basic widget for creating a custom back button.
///              This widget is being used in the following files:
///              sign_up_page.dart.
/// @author      Miguel Fagundez
/// @date        04/07/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: onPressed ?? () => Navigator.of(context).pop(),
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: NemorixColors.greyLevel1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                //color: NemorixColors.primaryColor,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
