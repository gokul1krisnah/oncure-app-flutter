import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// import '../../analytics/firebase/analytics_interceptor.dart';
import '../data/repositories/settings_repository.dart';
import '../env/env.dart';
import '../injection/injection.dart';
import '../services/app_details_service.dart';

// Default timeout duration for network requests.
const Duration _timeoutDuration = Duration(seconds: 30);

/// A utility class for configuring the Dio instance for the application.
///
/// This class handles the setup of the base URL, timeouts, and interceptors.
abstract class DioConfig {
  /// Configures and returns a [Dio] instance.
  static Dio configure() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Config.baseUrl, // The base URL for all API requests.
        connectTimeout: _timeoutDuration,
        receiveTimeout: _timeoutDuration,
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'Accept': 'application/json'},
      ),
    );

    return _addInterceptors(dio);
  }

  /// Adds all necessary interceptors to the [Dio] instance.
  static Dio _addInterceptors(Dio dio) {
    // Interceptor for logging network requests and responses in debug mode.
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, error: true, compact: true),
      );
    }

    // Interceptor for analytics.
    // dio.interceptors.add(AnalyticsInterceptor());

    // Interceptor to dynamically add the authentication token and device info to headers.
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Retrieve the auth token from the settings repository.
          final token = await _getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Add device information to headers for every request.
          final deviceInfo = await locator<AppDetailsService>().getAllDetails();
          options.headers['DeviceInfo'] = deviceInfo.toJson();

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // You can add custom error handling logic here if needed.
          handler.next(e);
        },
      ),
    );

    return dio;
  }

  /// A helper function to retrieve the authentication token.
  static Future<String?> _getToken() async {
    final token = locator<SettingsRepository>().settings.token;
    return token;
  }
}

/// A utility class to manage environment-specific configurations.
///
/// This class provides the correct base URL and other configuration values
/// based on the build environment (debug vs. release).
abstract class Config {
  /// Returns the base URL for the API.
  ///
  /// In both debug and release mode, this currently points to the URL
  /// defined in the environment variables.
  static String get baseUrl => Env.baseUrl;

  /// Returns the base URL for storage.
  ///
  /// This is useful if your app fetches files (like images or documents)
  /// from a different domain or path than the main API.
  // ignore: prefer_expression_function_bodies
  static String get storageUrl {
    // Note: In a real-world scenario, this might point to a different URL
    // than the API, e.g., a CDN or a separate storage server.
    return Env.baseUrl;
  }
}
