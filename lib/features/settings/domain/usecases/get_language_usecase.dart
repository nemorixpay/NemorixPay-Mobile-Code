import 'package:nemorixpay/features/settings/domain/repositories/settings_repository.dart';

/// @file        get_language_preference.dart
/// @brief       Use case for getting the current language preference.
/// @details     Retrieves the user's current language preference from local storage.
/// @author      Miguel Fagundez
/// @date        07/27/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetLanguageUseCase {
  final SettingsRepository _repository;

  GetLanguageUseCase(this._repository);

  Future<String> call() async {
    return await _repository.getLanguagePreference();
  }
}
