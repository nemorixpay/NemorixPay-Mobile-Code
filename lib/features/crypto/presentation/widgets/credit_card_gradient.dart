import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nemorixpay/features/crypto/domain/entities/credit_card.dart';

/// @file        credit_card_gradient.dart
/// @brief       Credit card widget.
/// @details     This file contains general code for building a credit card widget using a three-color gradient.
/// @author      Miguel Fagundez
/// @date        2025-04-21
/// @version     1.1
/// @copyright   Apache 2.0 License
class CreditCardGradient extends StatelessWidget {
  final CreditCard card;
  const CreditCardGradient({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF833AB4), Color(0xFFFD1D1D), Color(0xFFFFC371)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.bolt, color: Colors.white),
                (card.type == 'Visa')
                    ? FaIcon(FontAwesomeIcons.ccVisa)
                    : FaIcon(FontAwesomeIcons.ccMastercard),
              ],
            ),
            Text(
              card.number,
              style: GoogleFonts.inconsolata(
                fontSize: 22,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Valid till',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      card.expiry,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  card.holder,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
