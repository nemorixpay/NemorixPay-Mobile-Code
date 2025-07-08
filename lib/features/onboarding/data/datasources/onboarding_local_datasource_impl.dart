import 'package:nemorixpay/core/errors/onboarding/onboarding_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nemorixpay/features/onboarding/data/models/onboarding_model.dart';
import 'package:nemorixpay/features/onboarding/data/datasources/onboarding_local_datasource.dart';

/// @file        onboarding_local_datasource.dart
/// @brief       Local data source for Onboarding feature.
/// @details     Handles local storage operations for onboarding data.
/// @author      Miguel Fagundez
/// @date        06/15/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class OnboardingLocalDatasourceImpl implements OnboardingLocalDatasource {
  final SharedPreferences _prefs;
  static const String _languageKey = 'language';
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _hasWalletKey = 'has_wallet';

  OnboardingLocalDatasourceImpl(this._prefs);

  @override
  Future<bool> saveLanguage(String language) async {
    try {
      return await _prefs.setString(_languageKey, language);
    } catch (e) {
      throw OnboardingFailure.unknown('Failed to save language: $e');
    }
  }

  @override
  Future<String?> getLanguage() async {
    return _prefs.getString(_languageKey);
  }

  @override
  Future<bool> completeOnboarding() async {
    try {
      return await _prefs.setBool(_onboardingCompletedKey, true);
    } catch (e) {
      throw OnboardingFailure.unknown('Failed to complete onboarding: $e');
    }
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  Future<OnboardingModel> getOnboardingData() async {
    try {
      // final config = await ConfigService.instance;
      final data = OnboardingModel(
        language: await getLanguage() ?? 'en',
        isCompleted: await isOnboardingCompleted(),
        hasWallet: _prefs.getBool(_hasWalletKey) ?? false,
      );
      return data;
    } catch (e) {
      return OnboardingModel(
        language: 'en',
        isCompleted: false,
        hasWallet: false,
      );
    }
  }

  Future<void> saveOnboardingData(OnboardingModel model) async {
    // final config = await ConfigService.instance;
    await _prefs.setString(_languageKey, model.language);
    await _prefs.setBool(_onboardingCompletedKey, model.isCompleted);
    await _prefs.setBool(_hasWalletKey, model.hasWallet);
  }

  @override
  Future<bool> resetOnboarding() async {
    try {
      await _prefs.setBool(_onboardingCompletedKey, false);
      return true;
    } catch (e) {
      throw OnboardingFailure.unknown('Failed to reset onboarding: $e');
    }
  }
}
