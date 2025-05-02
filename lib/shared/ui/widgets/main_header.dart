import 'package:flutter/material.dart';
import 'package:nemorixpay/shared/ui/widgets/custom_back_button.dart';

/// @file        main_header.dart
/// @brief       Reusable widget for the main header of the app.
/// @details     This widget displays a title and optional back button and search button.
/// @author      Miguel Fagundez
/// @date        04/28/2025
/// @version     1.1
/// @copyright   Apache 2.0 License
class MainHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final bool showSearchButton;

  const MainHeader({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.showSearchButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBackButton)
            CustomBackButton()
          // IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () => Navigator.pop(context),
          // )
          else
            const SizedBox(width: 48),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (showSearchButton)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO: Implement search functionality
              },
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}
