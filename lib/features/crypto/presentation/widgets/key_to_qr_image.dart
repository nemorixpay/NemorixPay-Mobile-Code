import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// @file        qr_image.dart
/// @brief       Widget for displaying the QR code.
/// @details     Displays a QR code representing a public address.
/// @author      Miguel Fagundez
/// @date        06/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class KeyToQrImage extends StatelessWidget {
  final String data;

  /// @brief Widget for displaying the QR code
  const KeyToQrImage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 160,
      backgroundColor: Colors.white,
    );
  }
}
