/// @file        onboarding_local_datasource.dart
/// @brief       Local data source contract for Onboarding feature.
/// @details     Handles local storage operations for onboarding data.
/// @author      Miguel Fagundez
/// @date        06/16/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
abstract class OnboardingLocalDatasource {
  /// @brief       Saves the selected language.
  /// @details     Persists the user's language preference.
  /// @param       language The language code to save.
  /// @return      True if successful.
  /// @throws      Exception if saving fails.
  Future<bool> saveLanguage(String language);

  /// @brief       Gets the saved language.
  /// @details     Retrieves the user's language preference.
  /// @return      The saved language (null if no language is saved).
  Future<String?> getLanguage();

  /// @brief       Marks onboarding as completed.
  /// @details     Persists the onboarding completion status.
  /// @return      True if successful.
  /// @throws      Exception if saving fails.
  Future<bool> completeOnboarding();

  /// @brief       Checks if onboarding is completed.
  /// @details     Verifies if the user has already completed the onboarding process.
  /// @return      True if onboarding is completed.
  Future<bool> isOnboardingCompleted();
}
