/// @file        crypto.dart
/// @brief       Class for managing some crypto utils.
/// @details
/// @author      Miguel Fagundez
/// @date        06/27/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class CryptoUtils {
  /// shortPublicKey
  /// Example:
  /// Public Key: GABCDEF1234567890XYZ1234567890ABCDEF1234567890XYZ1234567890ABCDEF1
  /// Short Public Key (UI): GABCDEF12345...67890ABCDEF1
  static String shortPublicKey(String publicKey) {
    return publicKey.length > 30
        ? '${publicKey.substring(0, 12)} ... ${publicKey.substring(publicKey.length - 12)}'
        : publicKey;
  }
}
