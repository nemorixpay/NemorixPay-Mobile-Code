import 'package:flutter/material.dart';

/// @file        rounded_elevated_button.dart
/// @brief       General design of a button in the application.
/// @details     This file contains the basic widget for creating a button the width
///              of the device with an optional icon.
///              This widget is being used in the following files:
///              sign_in_page.dart, sign_up_page.dart.
/// @author      Miguel Fagundez
/// @date        04/05/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class RoundedElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String? icon;

  const RoundedElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Image.asset(icon ?? '', height: 20, width: 20),
            if (icon != null) SizedBox(width: 10),
            Text(text, style: TextStyle(color: textColor)),
          ],
        ),
      ),
    );
  }
}
