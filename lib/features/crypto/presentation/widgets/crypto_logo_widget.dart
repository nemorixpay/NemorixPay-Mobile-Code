import 'package:flutter/material.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';

/// @file        crypto_logo_widget.dart
/// @brief       Widget for displaying the crypto logo
/// @details     Displays a crypto logo using some color conventions
/// @author      Miguel Fagundez
/// @date        06/28/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class CryptoLogoWidget extends StatelessWidget {
  final String logo;
  const CryptoLogoWidget({
    super.key,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: NemorixColors.greyLevel6,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(
              logo,
              width: 36,
              height: 36,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.currency_exchange, size: 48),
            ),
          ),
        ),
      ),
    );
  }
}
