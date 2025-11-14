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
/// @version     1.1
/// @copyright   Apache 2.0 License
class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  bool _hasScanned = false; // Flag to prevent multiple scans

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                if (!_hasScanned) {
                  _hasScanned = true;
                  Navigator.of(context).pop('-1');
                }
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
          // Prevent multiple scans
          if (_hasScanned) {
            return;
          }

          final List<Barcode> barcode = capture.barcodes;
          if (barcode.isEmpty) {
            return;
          }

          debugPrint('QrScanPage - QR detected: ${barcode.first.rawValue}');

          // Taking first barcode detected (no duplicated or multiple barcode allowed)
          final rawValue = barcode.first.rawValue;

          // Mark as scanned to prevent multiple pops
          _hasScanned = true;

          if (rawValue == null) {
            // Return -1 if null
            debugPrint('QrScanPage - QR value is null, returning -1');
            Navigator.of(context).pop('-1');
            return;
          }

          // Basic stellar address validation
          if (!ValidationRules.isValidStellarAddress(rawValue)) {
            debugPrint('QrScanPage - Invalid Stellar address: $rawValue');
            Navigator.of(context).pop('-1');
            return;
          }

          // Return Stellar address
          debugPrint(
              'QrScanPage - Valid Stellar address, returning: $rawValue');
          Navigator.of(context).pop(rawValue);
        },
      ),
    );
  }
}
