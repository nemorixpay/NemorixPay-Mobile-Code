/// @file        didit_api_config.dart
/// @brief       Configuration for Didit API endpoints and URLs
/// @details     Contains all API endpoints and configuration for Didit KYC integration
/// @author      Miguel Fagundez
/// @date        08/04/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

/// Configuration class for Didit API endpoints
class DiditApiConfig {
  // Base URLs
  static const String baseUrl = 'https://verification.didit.me';
  static const String apiVersion = 'v2';

  // API Endpoints
  static const String createSessionEndpoint = '/v2/session/';
  static const String getSessionDecisionEndpoint =
      '/v2/session/{sessionId}/decision/';
  static const String idVerificationEndpoint = '/v2/id-verification/';

  // Headers
  static const String apiKeyHeader = 'x-api-key';
  static const String contentTypeHeader = 'Content-Type';
  static const String contentTypeValue = 'application/json';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);

  // Session configuration
  static const Duration sessionTimeout = Duration(hours: 24);
  static const int maxRetries = 3;

  /// Build the full URL for creating a session
  static String getCreateSessionUrl() {
    return '$baseUrl$createSessionEndpoint';
  }

  /// Build the full URL for getting session decision
  static String getSessionDecisionUrl(String sessionId) {
    return '$baseUrl${getSessionDecisionEndpoint.replaceAll('{sessionId}', sessionId)}';
  }

  /// Build the full URL for ID verification
  static String getIdVerificationUrl() {
    return '$baseUrl$idVerificationEndpoint';
  }

  /// Get default headers for API requests
  static Map<String, String> getDefaultHeaders(String apiKey) {
    return {
      apiKeyHeader: apiKey,
      contentTypeHeader: contentTypeValue,
    };
  }
}
