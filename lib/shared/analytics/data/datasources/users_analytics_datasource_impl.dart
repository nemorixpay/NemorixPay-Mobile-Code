/// @file        users_analytics_datasource_impl.dart
/// @brief       Concrete implementation of UsersAnalyticsDatasource.
/// @details     This class implements the UsersAnalyticsDatasource interface using HTTP
///              requests to Firebase Realtime Database. It handles GET and POST operations
///              for user analytics data with proper error handling and JSON serialization.
/// @author      Miguel Fagundez
/// @date        02/10/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nemorixpay/config/constants/app_constants.dart';
import '../models/user_analytics_model.dart';
import 'users_analytics_datasource.dart';

class UsersAnalyticsDatasourceImpl implements UsersAnalyticsDatasource {
  static const String _baseUrl = AppConstants.analyticsBaseUrl;
  static const String _usersEndpoint = AppConstants.analyticsUsersEndpoint;
  static const Duration _timeout = Duration(seconds: 30);

  final http.Client _httpClient;

  const UsersAnalyticsDatasourceImpl({
    required http.Client httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<UserAnalyticsModel>> getUsers() async {
    try {
      debugPrint('UsersAnalyticsDatasourceImpl: getUsers - Starting');

      final url = Uri.parse('$_baseUrl$_usersEndpoint');
      final response = await _httpClient.get(url).timeout(_timeout);

      debugPrint(
          'UsersAnalyticsDatasourceImpl: getUsers - Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseBody = response.body;
        debugPrint(
            'UsersAnalyticsDatasourceImpl: getUsers - Response body: $responseBody');

        if (responseBody.isEmpty || responseBody == 'null') {
          debugPrint(
              'UsersAnalyticsDatasourceImpl: getUsers - No users found, returning empty list');
          return [];
        }

        final dynamic jsonData = jsonDecode(responseBody);

        if (jsonData is List) {
          final users = jsonData
              .map((userJson) =>
                  UserAnalyticsModel.fromJson(userJson as Map<String, dynamic>))
              .toList();
          debugPrint(
              'UsersAnalyticsDatasourceImpl: getUsers - Successfully parsed ${users.length} users');
          return users;
        } else if (jsonData is Map<String, dynamic>) {
          // Firebase returns a map when there are users, convert to list
          final users = jsonData.values
              .map((userJson) =>
                  UserAnalyticsModel.fromJson(userJson as Map<String, dynamic>))
              .toList();
          debugPrint(
              'UsersAnalyticsDatasourceImpl: getUsers - Successfully parsed ${users.length} users from map');
          return users;
        } else {
          debugPrint(
              'UsersAnalyticsDatasourceImpl: getUsers - Unexpected response format');
          return [];
        }
      } else {
        debugPrint(
            'UsersAnalyticsDatasourceImpl: getUsers - HTTP error: ${response.statusCode}');
        throw Exception('Failed to get users: HTTP ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('UsersAnalyticsDatasourceImpl: getUsers - Error: $e');
      if (e is Exception) {
        rethrow;
      } else {
        throw Exception('Failed to get users: $e');
      }
    }
  }

  @override
  Future<UserAnalyticsModel> createUser(UserAnalyticsModel user) async {
    try {
      debugPrint('UsersAnalyticsDatasourceImpl: createUser - Starting');
      debugPrint(
          'UsersAnalyticsDatasourceImpl: createUser - User data: ${user.toJson()}');

      // First, get the current list to determine the next key
      final existingUsers = await getUsers();
      final nextKey = existingUsers.length;

      debugPrint(
          'UsersAnalyticsDatasourceImpl: createUser - Current users count: ${existingUsers.length}');
      debugPrint(
          'UsersAnalyticsDatasourceImpl: createUser - Next key will be: $nextKey');

      // Use the specific key endpoint
      final url = Uri.parse('$_baseUrl/users/$nextKey.json');

      final headers = {
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(user.toJson());
      debugPrint(
          'UsersAnalyticsDatasourceImpl: createUser - Request body: $body');

      final response = await _httpClient
          .put(url, headers: headers, body: body)
          .timeout(_timeout);

      debugPrint(
          'UsersAnalyticsDatasourceImpl: createUser - Response status: ${response.statusCode}');
      debugPrint(
          'UsersAnalyticsDatasourceImpl: createUser - Response body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint(
            'UsersAnalyticsDatasourceImpl: createUser - User created successfully with key: $nextKey');
        return user;
      } else {
        debugPrint(
            'UsersAnalyticsDatasourceImpl: createUser - HTTP error: ${response.statusCode}');
        throw Exception('Failed to create user: HTTP ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('UsersAnalyticsDatasourceImpl: createUser - Error: $e');
      if (e is Exception) {
        rethrow;
      } else {
        throw Exception('Failed to create user: $e');
      }
    }
  }
}
