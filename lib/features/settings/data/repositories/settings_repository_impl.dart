import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

/// @file        settings_repository_impl.dart
/// @brief       Implementation of SettingsRepository using local datasource.
/// @details     Provides access to settings preferences using SharedPreferences.
/// @author      Miguel Fagundez
/// @date        07/12/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource _localDatasource;

  SettingsRepositoryImpl(this._localDatasource);

  @override
  Future<bool> getDarkModePreference() async {
    return await _localDatasource.getDarkModePreference();
  }

  @override
  Future<void> saveDarkModePreference(bool isDarkMode) async {
    await _localDatasource.saveDarkModePreference(isDarkMode);
  }

  @override
  Future<bool> toggleDarkMode() async {
    return await _localDatasource.toggleDarkMode();
  }
}
