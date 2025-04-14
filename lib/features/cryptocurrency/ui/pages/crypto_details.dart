import 'package:flutter/material.dart';
import 'package:nemorixpay/shared/ui/widgets/main_header.dart';

/// @file        crypto_details.dart
/// @brief       Crypto deatils screen implementation for NemorixPay.
/// @details     This file contains the layout and logic for the crypto details info of NemorixPay,
///              including crypto asset information, buy/sell buttons, charts, and more.
/// @author      Miguel Fagundez
/// @date        2025-04-14
/// @version     1
/// @copyright   Apache 2.0 License
class CryptoDetailsPage extends StatelessWidget {
  const CryptoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [MainHeader(title: 'XLM')],
        ),
      ),
    );
  }
}
