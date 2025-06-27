import 'package:flutter/material.dart';
import 'package:nemorixpay/core/utils/crypto.dart';

/// @file        address_short_field.dart
/// @brief       Widget for displaying the public address in a readonly field
/// @details     Display first 12 characters and last 12 characters of a public key
/// @author      Miguel Fagundez
/// @date        06/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class AddressShortField extends StatelessWidget {
  final String address;

  /// @brief Widget for displaying the public address in a readonly field
  const AddressShortField({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Text(
        CryptoUtils.shortPublicKey(address),
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
