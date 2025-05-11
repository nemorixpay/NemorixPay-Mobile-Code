import 'package:flutter/foundation.dart';
import 'package:secure_application/secure_application.dart';

/// @file        app_security_service.dart
/// @brief       Security service for handling screen capture protection.
/// @details     This service manages screen security features, preventing screenshots
///             on sensitive screens and handling platform-specific security measures.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License

/// Service responsible for managing application security
class AppSecurityService {
  static final SecureApplicationController _controller =
      SecureApplicationController(SecureApplicationState());

  /// Blocks screen capture in the application
  ///
  /// On Android, completely prevents screen capture
  /// On iOS, dims the screen when attempting to capture
  static Future<void> secureScreen() async {
    try {
      _controller.secure();
    } catch (e) {
      // Handle error appropriately
      debugPrint('Error blocking screen capture: $e');
    }
  }

  /// Restores screen capture capability
  static Future<void> unsecureScreen() async {
    try {
      _controller.unlock();
    } catch (e) {
      // Handle error appropriately
      debugPrint('Error unblocking screen capture: $e');
    }
  }
}
