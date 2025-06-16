import 'package:shared_preferences/shared_preferences.dart';

/// @file        config_service.dart
/// @brief       Configuration service for the app.
/// @details     Handles app-wide configuration and preferences.
/// @author      Miguel Fagundez
/// @date        06/16/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class ConfigService {
  static ConfigService? _instance;
  late final SharedPreferences _prefs;

  ConfigService._();

  /// @brief       Gets the singleton instance.
  /// @details     Creates the instance if it doesn't exist.
  /// @return      The ConfigService instance.
  static Future<ConfigService> get instance async {
    if (_instance == null) {
      _instance = ConfigService._();
      await _instance!._init();
    }
    return _instance!;
  }

  /// @brief       Initializes the service.
  /// @details     Loads SharedPreferences.
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// @brief       Gets the SharedPreferences instance.
  /// @details     Returns the current SharedPreferences instance.
  /// @return      The SharedPreferences instance.
  SharedPreferences get prefs => _prefs;
}
