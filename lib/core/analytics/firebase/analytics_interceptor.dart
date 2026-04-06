/// A Dio interceptor that integrates with the [AnalyticsService] to track
/// the performance and status of network requests.
///
/// This interceptor automatically starts a timer when a request is sent and
/// stops the timer when a response is received, logging the duration and
/// result to the analytics service.
import 'package:dio/dio.dart';

import '../../injection/injection.dart';
import 'analytics_service.dart';

class AnalyticsInterceptor extends Interceptor {
  AnalyticsService? _analytics;

  /// Lazily initializes and provides access to the [AnalyticsService].
  ///
  /// This getter ensures that the [AnalyticsService] is only retrieved from the
  /// service locator [locator] once and when it's first needed.
  AnalyticsService get _analyticsService {
    _analytics ??= locator<AnalyticsService>();
    return _analytics!;
  }

  /// Called when a new request is about to be sent.
  ///
  /// This method starts the performance tracking for the outgoing request.
  /// It defensively wraps the call in a try-catch block to prevent crashes
  /// if the analytics service is not yet available during app startup.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      _analyticsService.startRequestTracking(requestOptions: options);
    } catch (e) {
      // Analytics service might not be available yet, skip tracking.
    }
    return handler.next(options);
  }

  /// Called when a response is received.
  ///
  /// This method ends the performance tracking for the completed request,
  /// logging the outcome (success or failure) and the duration.
  /// It defensively wraps the call in a try-catch block.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      _analyticsService.endRequestTracking(response: response);
    } catch (e) {
      // Analytics service might not be available yet, skip tracking.
    }
    return handler.next(response);
  }
}
