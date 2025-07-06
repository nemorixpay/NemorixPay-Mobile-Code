import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/terms_acceptance_model.dart';

/// @file        terms_local_datasource.dart
/// @brief       Local datasource for Terms and Conditions content and acceptance.
/// @details     Provides access to the terms and conditions text stored locally in the app assets
///              and manages user acceptance status using SharedPreferences.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

abstract class TermsLocalDatasource {
  /// Gets the terms and conditions content from local assets
  Future<String> getTermsContent();

  /// Checks if the user has accepted the current version of terms and conditions
  Future<bool> isTermsAccepted();

  /// Saves the user's acceptance of terms and conditions
  Future<void> saveTermsAcceptance(String version, DateTime acceptedAt);

  /// Gets the complete terms acceptance model
  Future<TermsAcceptanceModel> getTermsAcceptance();

  /// Clears all terms acceptance data (useful for testing)
  Future<void> clearTermsAcceptance();
}
