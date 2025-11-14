import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

/// @file        platform_utils.dart
/// @brief       Platform detection utilities for the app.
/// @details     Provides utilities to detect platform-specific information,
///              particularly Android version for TLS/Handshake compatibility checks.
/// @author      Miguel Fagundez
/// @date        11/05/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class PlatformUtils {
  /// Checks if the current Android version is supported (Android 13 or higher)
  ///
  /// Android 13 = API level 33
  /// Returns true if Android version is 13+ (API 33+), false otherwise.
  /// Returns true for non-Android platforms (iOS, web, etc.)
  ///
  /// This check is used to prevent wallet creation on older Android versions
  /// that may have TLS/Handshake issues with Stellar network.
  static Future<bool> isAndroidVersionSupported() async {
    if (!Platform.isAndroid) {
      // iOS and other platforms are always supported
      return true;
    }

    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      
      // Android 13 = API level 33
      // We require Android 13 or higher (API 33+)
      return sdkInt >= 33;
    } catch (e) {
      // If we can't determine the version, assume it's not supported
      // to be safe (prevent potential TLS issues)
      return false;
    }
  }

  /// Gets the Android SDK version as an integer
  ///
  /// Returns the SDK version (e.g., 30, 33, 34) or null if not Android or error
  static Future<int?> getAndroidSdkVersion() async {
    if (!Platform.isAndroid) {
      return null;
    }

    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    } catch (e) {
      return null;
    }
  }
}

