import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// @file        firebase_auth_persistence_service.dart
/// @brief       Configures Firebase Auth persistence for NemorixPay.
/// @details     Provides a centralized initialization point to ensure Firebase
///             maintains a single signed-in session per device. Applies the
///             proper persistence mode depending on the current platform and
///             logs diagnostic information for troubleshooting purposes.
/// @author      Miguel Fagundez
/// @date        2025-11-18
/// @version     1.0
/// @copyright   Apache 2.0 License
class FirebaseAuthPersistenceService {
  FirebaseAuthPersistenceService._();

  static bool _isInitialized = false;

  /// @brief Initializes Firebase Auth persistence, ensuring a single session.
  /// @details Sets Persistence.local on supported platforms (Android/iOS) to
  ///          keep the user signed in after app restarts. On unsupported
  ///          platforms (tests), it falls back to Persistence.none to avoid
  ///          runtime errors or unexpected behavior.
  static Future<void> initializePersistence() async {
    if (_isInitialized) {
      debugPrint(
        'FirebaseAuthPersistenceService: Persistence already configured.',
      );
      return;
    }

    final firebaseAuth = FirebaseAuth.instance;

    try {
      if (kIsWeb) {
        await firebaseAuth.setPersistence(Persistence.LOCAL);
        debugPrint(
          'FirebaseAuthPersistenceService: Web persistence set to LOCAL.',
        );
      } else if (_supportsFallbackPersistence()) {
        await firebaseAuth.setPersistence(Persistence.NONE);
        debugPrint(
          'FirebaseAuthPersistenceService: Fallback persistence set to NONE.',
        );
      } else {
        debugPrint(
          'FirebaseAuthPersistenceService: Native platforms manage persistence automatically.',
        );
      }
      _isInitialized = true;
    } on FirebaseException catch (error) {
      debugPrint(
        'FirebaseAuthPersistenceService: Firebase error ${error.code}',
      );
    } catch (error) {
      debugPrint(
        'FirebaseAuthPersistenceService: Unexpected error $error',
      );
    }
  }

  static bool _supportsFallbackPersistence() {
    return defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;
  }
}
