/// @file        users_analytics_datasource.dart
/// @brief       Abstract interface for user analytics data operations.
/// @details     This abstract class defines the contract for user analytics data operations
///              including retrieving existing users and creating new user registrations
///              for analytics tracking purposes.
/// @author      Miguel Fagundez
/// @date        02/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

import '../models/user_analytics_model.dart';

abstract class UsersAnalyticsDatasource {
  /// Retrieves all existing users from the analytics database
  ///
  /// Returns a list of UserAnalyticsModel objects representing all users
  /// that have been registered for analytics tracking.
  ///
  /// Throws an exception if the operation fails.
  Future<List<UserAnalyticsModel>> getUsers();

  /// Creates a new user registration in the analytics database
  ///
  /// [user] - The UserAnalyticsModel object containing user data to be stored
  ///
  /// Returns the created UserAnalyticsModel object.
  ///
  /// Throws an exception if the operation fails.
  Future<UserAnalyticsModel> createUser(UserAnalyticsModel user);
}
