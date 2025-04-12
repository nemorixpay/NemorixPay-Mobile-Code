import 'package:flutter/material.dart';

class WalletBalance extends StatelessWidget {
  final String balance;
  const WalletBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Current Wallet Balance',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 4),
          Text(
            balance,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
