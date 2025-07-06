import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/terms_acceptance_model.dart';
import 'terms_local_datasource.dart';

/// @file        terms_local_datasource_impl.dart
/// @brief       Implementation of TermsLocalDatasource using SharedPreferences.
/// @details     Provides concrete implementation for local storage of terms acceptance
///              using SharedPreferences with version tracking and error handling.
/// @author      Miguel Fagundez
/// @date        07/02/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class TermsLocalDatasourceImpl implements TermsLocalDatasource {
  static const String _termsAcceptedKey = 'terms_accepted';
  static const String _termsVersionKey = 'terms_version';
  static const String _termsAcceptedAtKey = 'terms_accepted_at';
  static const String _currentTermsVersion = '1.0';

  @override
  Future<String> getTermsContent() async {
    try {
      // Load terms content from assets
      return await rootBundle.loadString('assets/terms/terms_en.txt');
    } catch (e) {
      // Fallback content if file is not found
      return '';
    }
  }

  @override
  Future<bool> isTermsAccepted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isAccepted = prefs.getBool(_termsAcceptedKey) ?? false;
      final acceptedVersion = prefs.getString(_termsVersionKey) ?? '';

      // Check if accepted and if it's the current version
      return isAccepted && acceptedVersion == _currentTermsVersion;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> saveTermsAcceptance(String version, DateTime acceptedAt) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_termsAcceptedKey, true);
      await prefs.setString(_termsVersionKey, version);
      await prefs.setString(_termsAcceptedAtKey, acceptedAt.toIso8601String());
    } catch (e) {
      throw Exception('Failed to save terms acceptance: $e');
    }
  }

  @override
  Future<TermsAcceptanceModel> getTermsAcceptance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isAccepted = prefs.getBool(_termsAcceptedKey) ?? false;
      final version = prefs.getString(_termsVersionKey) ?? '';
      final acceptedAtString = prefs.getString(_termsAcceptedAtKey);

      final acceptedAt =
          acceptedAtString != null ? DateTime.parse(acceptedAtString) : null;

      return TermsAcceptanceModel(
        isAccepted: isAccepted,
        version: version,
        acceptedAt: acceptedAt,
      );
    } catch (e) {
      return TermsAcceptanceModel.notAccepted();
    }
  }

  @override
  Future<void> clearTermsAcceptance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_termsAcceptedKey);
      await prefs.remove(_termsVersionKey);
      await prefs.remove(_termsAcceptedAtKey);
    } catch (e) {
      throw Exception('Failed to clear terms acceptance: $e');
    }
  }

  /// Gets the current terms version
  String get currentTermsVersion => _currentTermsVersion;
}
