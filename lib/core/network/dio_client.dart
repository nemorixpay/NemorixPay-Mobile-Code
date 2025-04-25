import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// @file        dio_client.dart
/// @brief       HTTP client implementation using Dio for NemorixPay.
/// @details     This file contains the Dio client configuration with interceptors,
///              logging, and error handling for all HTTP requests in the application.
/// @author      Miguel Fagundez
/// @date        2024-04-24
/// @version     1.0
/// @copyright   Apache 2.0 License
class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio() {
    _dio.options.baseUrl = 'https://api.nemorixpay.com';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }

  Dio get dio => _dio;
}
