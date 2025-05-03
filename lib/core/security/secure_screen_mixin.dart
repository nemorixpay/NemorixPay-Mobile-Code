/// @file        secure_screen_mixin.dart
/// @brief       Mixin for handling secure screen functionality.
/// @details     This mixin provides screen security features to prevent
///             unauthorized screen captures on sensitive screens.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'package:flutter/material.dart';
import 'package:secure_application/secure_application.dart';
import 'app_security_service.dart';

/// Mixin for handling security of sensitive screens
mixin SecureScreenMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    // Activar seguridad al iniciar la pantalla
    AppSecurityService.secureScreen();
  }

  @override
  void dispose() {
    // Desactivar seguridad al salir de la pantalla
    AppSecurityService.unsecureScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SecureApplication(
      nativeRemoveDelay: 0,
      child: buildSecureScreen(context),
    );
  }

  /// Method to be implemented by classes using this mixin
  Widget buildSecureScreen(BuildContext context);
}
