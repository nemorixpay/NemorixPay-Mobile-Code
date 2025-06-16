import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences implements SharedPreferences {
  final Map<String, Object?> _storage = {};

  @override
  Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _storage[key] = value;
    return true;
  }

  @override
  String? getString(String key) => _storage[key] as String?;

  @override
  bool? getBool(String key) => _storage[key] as bool?;

  // Métodos no implementados lanzan UnimplementedError
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
