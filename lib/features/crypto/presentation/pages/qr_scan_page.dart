import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nemorixpay/config/constants/app_constants.dart';
import 'package:nemorixpay/core/utils/validation_rules.dart';

/// @file        qr_scan_page.dart
/// @brief       QR code scanner page for cryptocurrency address input.
/// @details     Provides a full-screen camera interface using mobile_scanner package to scan QR codes
///              containing cryptocurrency addresses. Automatically returns the scanned address to the
///              previous screen or '-1' if cancelled.
/// @author      Miguel Fagundez
/// @date        06/29/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context, '-1');
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: false,
        ),
        onDetect: (capture) {
          final List<Barcode> barcode = capture.barcodes;
          debugPrint('QrScanPage - QR: ${barcode.first.rawValue}');

          // Taking first barcode detected (no duplicated or multiple barcode allowed)
          final rawValue = barcode.first.rawValue;

          if (rawValue == null) {
            // Return -1 if null
            Navigator.pop(context, '-1');
            return;
          }

          // Basic stellar address validation
          if (!ValidationRules.isValidStellarAddress(rawValue)) {
            debugPrint('QrScanPage - Invalid Stellar address: $rawValue');
            Navigator.pop(context, '-1');
            return;
          }

          // Return Stellar address
          Navigator.pop(context, rawValue);
        },
      ),
    );
  }
}
