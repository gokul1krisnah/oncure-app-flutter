import 'package:flutter/material.dart';

import 'analytics_service.dart';

/// A [RouteObserver] that automatically tracks screen views and sends them
/// to the [AnalyticsService].
///
/// This observer hooks into the navigation events of the application (push, pop, replace)
/// to log which screen the user is currently viewing.
class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  /// The analytics service that will receive the screen view events.
  final AnalyticsService analytics;

  AnalyticsRouteObserver({required this.analytics});

  /// Called whenever a new route is pushed onto the navigation stack.
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    // Refresh route tracking, possibly for timing how long a screen is viewed.
    analytics.refreshRouteTracking(route.settings.name);
    // Log the screen view if it's a standard page route.
    if (route is PageRoute && route.settings.name != '/') {
      _sendScreenView(route);
    }
  }

  /// Called whenever a route is replaced with a new one.
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    // Refresh tracking for the new route.
    analytics.refreshRouteTracking(newRoute!.settings.name);
    // Log the screen view for the new route.
    if (newRoute is PageRoute && newRoute.settings.name != '/') {
      _sendScreenView(newRoute);
    }
  }

  /// Called whenever a route is popped from the navigation stack.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // When a route is popped, the `previousRoute` is the one that becomes visible.
    // We refresh tracking for this now-visible route.
    analytics.refreshRouteTracking(previousRoute!.settings.name);
    // Log a screen view for the screen that is now visible.
    if (previousRoute is PageRoute && route.settings.name != '/' && route is ModalRoute) {
      _sendScreenView(previousRoute);
    }
  }

  /// A helper method to extract the screen name and send it to the analytics service.
  void _sendScreenView(PageRoute<dynamic> route) {
    final String? screenName = route.settings.name;
    if (screenName != null) {
      // This call typically logs the 'screen_view' event in Firebase Analytics.
      analytics.setCurrentScreen(screenName: screenName);
    }
  }
}
