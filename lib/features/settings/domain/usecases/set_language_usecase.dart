import 'package:nemorixpay/features/settings/domain/repositories/settings_repository.dart';

/// @file        set_language_preference.dart
/// @brief       Use case for setting the language preference.
/// @details     Saves the user's language preference to local storage.
/// @author      Miguel Fagundez
/// @date        07/27/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class SetLanguageUseCase {
  final SettingsRepository _repository;

  SetLanguageUseCase(this._repository);

  Future<void> call(String languageCode) async {
    await _repository.saveLanguagePreference(languageCode);
  }
}
