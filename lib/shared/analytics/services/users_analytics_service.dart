/// @file        users_analytics_service.dart
/// @brief       Service for managing user analytics operations.
/// @details     This service provides high-level operations for user analytics tracking,
///              including user registration tracking and data retrieval. It acts as a
///              business logic layer between the presentation layer and the data layer.
/// @author      Miguel Fagundez
/// @date        02/10/2025
/// @version     1.1
/// @copyright   Apache 2.0 License

import 'dart:io';
import '../data/datasources/users_analytics_datasource.dart';
import '../data/models/user_analytics_model.dart';

class UsersAnalyticsService {
  final UsersAnalyticsDatasource _datasource;

  const UsersAnalyticsService({
    required UsersAnalyticsDatasource datasource,
  }) : _datasource = datasource;

  /// Tracks a new user registration for analytics purposes
  ///
  /// [userId] - The unique identifier of the user (Firebase Auth UID)
  /// [name] - The display name of the user
  /// [country] - The country of residence of the user
  /// [platform] - The platform used (ios/android/web)
  /// [registrationDate] - The registration date in YYYY-MM-DD format
  /// [birthDate] - The birth date in YYYY-MM-DD format
  ///
  /// Returns the created UserAnalyticsModel object.
  ///
  /// Throws an exception if the operation fails.
  Future<UserAnalyticsModel> trackUserRegistration({
    required String userId,
    required String name,
    required String country,
    required String platform,
    required String registrationDate,
    required String birthDate,
  }) async {
    try {
      final userModel = UserAnalyticsModel(
        id: userId,
        name: name,
        country: country,
        platform: platform,
        registrationDate: registrationDate,
        birthDate: birthDate,
      );

      return await _datasource.createUser(userModel);
    } catch (e) {
      throw Exception('Failed to track user registration: $e');
    }
  }

  /// Retrieves all users from the analytics database
  ///
  /// Returns a list of all UserAnalyticsModel objects.
  ///
  /// Throws an exception if the operation fails.
  Future<List<UserAnalyticsModel>> getAllUsers() async {
    try {
      return await _datasource.getUsers();
    } catch (e) {
      throw Exception('Failed to retrieve users: $e');
    }
  }

  /// Gets the current platform string based on the running platform
  ///
  /// Returns 'ios' for iOS, 'android' for Android, or 'web' for web platform.
  static String getCurrentPlatform() {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'web';
    }
  }

  /// Creates a UserAnalyticsModel with current date information
  ///
  /// [userId] - The unique identifier of the user
  /// [name] - The display name of the user
  /// [country] - The country of residence of the user
  /// [birthDate] - The birth date in YYYY-MM-DD format
  ///
  /// Returns a UserAnalyticsModel with current date and platform information.
  UserAnalyticsModel createUserModelWithCurrentDate({
    required String userId,
    required String name,
    required String country,
    required String birthDate,
  }) {
    final now = DateTime.now();
    final registrationDate =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    return UserAnalyticsModel(
      id: userId,
      name: name,
      country: country,
      platform: getCurrentPlatform(),
      registrationDate: registrationDate,
      birthDate: birthDate,
    );
  }

  /// Formats a DateTime object to YYYY-MM-DD string format
  ///
  /// [date] - The DateTime object to format
  ///
  /// Returns a string in YYYY-MM-DD format.
  static String formatDateToString(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
