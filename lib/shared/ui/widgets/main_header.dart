import 'package:flutter/material.dart';
import 'package:nemorixpay/shared/ui/widgets/custom_back_button.dart';

/// @file        main_header.dart
/// @brief       Implementation of a custom header.
/// @details     This file contains the basic widget for creating a custom header including a back button.
///              This widget is being used in the following files:
///              sign_up_page.dart, crypto_details.dart.dart.
/// @author      Miguel Fagundez
/// @date        04/14/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class MainHeader extends StatelessWidget {
  final String title;

  const MainHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBackButton(),
        Align(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
