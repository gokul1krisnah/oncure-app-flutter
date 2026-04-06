import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../debug_analytics.dart';
import 'analytics_event.dart';

/// A service that acts as a central hub for all analytics-related activities.
///
/// This class provides a set of methods for logging various types of events,
/// such as user interactions, screen views, and API performance. It serves as an
/// abstraction layer, decoupling the rest of the application from the specific
/// analytics implementation (e.g., Firebase, Amplitude, or a debug logger).
///
/// The service is provided as a singleton via the `injectable` package.
@singleton
class AnalyticsService {
  // final FirebaseAnalytics _analytics;
  // final UserRepository _userRepository;
  final DebugAnalytics _debugAnalytics;
  Map<String?, Stopwatch> routeTimeTracker = Map.identity();
  // Map<StoreModel?, Stopwatch> storeViewTimeTracker = Map.identity();
  Map<String, Stopwatch> requestTimeTracker = Map.identity();

  AnalyticsService(
    // this._analytics,
    // this._userRepository,
    this._debugAnalytics,
  );

  void setCurrentScreen({required String screenName}) {
    // _analytics.logScreenView(screenName: screenName).catchError((error) {
    //     debugPrint(error.toString());
    //   });
  }

  void logEvent({required String name, required Map<String, Object> parameters}) {
    // _analytics.logEvent(name: name, parameters: parameters).catchError((error) {
    //     debugPrint(error.toString());
    //   });
  }

  void setUserId(String guid) {
    // _analytics.setUserId(id: guid);
  }

  void refreshRouteTracking(String? route) {
    final stopwatch = Stopwatch()..start();
    _logRoute();
    // _logStoreViewed();
    routeTimeTracker.putIfAbsent(route, () => stopwatch);
  }

  // void refreshStoreTracking(StoreModel? store) {
  //   final stopwatch = Stopwatch()..start();
  //   _logStoreViewed();
  //   storeViewTimeTracker.putIfAbsent(store, () => stopwatch);
  // }

  // void pauseTimingTrackers() {
  //   if (routeTimeTracker.isNotEmpty) {
  //     routeTimeTracker.entries.first.value.stop();
  //   }
  //   if (storeViewTimeTracker.isNotEmpty) {
  //     storeViewTimeTracker.entries.first.value.stop();
  //   }
  // }

  // void resumeTimingTrackers() {
  //   if (routeTimeTracker.isNotEmpty) {
  //     routeTimeTracker.entries.first.value.start();
  //   }
  //   if (storeViewTimeTracker.isNotEmpty) {
  //     storeViewTimeTracker.entries.first.value.start();
  //   }
  // }

  void startRequestTracking({required RequestOptions requestOptions}) {
    final stopwatch = Stopwatch()..start();
    requestTimeTracker.putIfAbsent(requestOptions.uri.path, () => stopwatch);
  }

  void endRequestTracking({required Response response}) {
    try {
      final MapEntry<String, Stopwatch> mapEntry = requestTimeTracker.entries.firstWhere(
        (element) => element.key == response.realUri.path,
      );
      final jsonResponse = jsonDecode(response.toString());
      mapEntry.value.stop();
      // final bool initial = _determineWhetherInitial();

      // if (mapEntry.key.contains(EndPoints.allStores)) {
      //   if (jsonResponse['status'] == 'ERROR' && jsonResponse['messages'] == 'no_records') {
      //     logFetchStoresNoStores(initial);
      //   } else if (jsonResponse['status'] == 'ERROR') {
      //     logFetchStoresUnknownError(initial);
      //   } else if (jsonResponse['status'] == 'SUCCESS') {
      //     logFetchStoresSuccessful(mapEntry.value.elapsedMilliseconds, initial);
      //   }
      // } else if (mapEntry.key.contains(EndPoints.store)) {
      //   if (jsonResponse['status'] == 'ERROR') {
      //     logFetchStoreDetailsUnknownError(initial);
      //   } else if (jsonResponse['status'] == 'SUCCESS') {
      //     logFetchStoreDetailsSuccessful(mapEntry.value.elapsedMilliseconds, initial);
      //   }
      // } else if (mapEntry.key.contains(EndPoints.addRemoveFavourites)) {
      //   if (jsonResponse['status'] == 'ERROR') {
      //     logAddRemoveFavoritesUnknownError(initial);
      //   } else if (jsonResponse['status'] == 'SUCCESS') {
      //     logAddRemoveFavoritesSuccessful(initial);
      //   }
      // }

      requestTimeTracker.remove(mapEntry.key);
    } catch (error, stackTrace) {
      _debugAnalytics.errorLog(e: error, s: stackTrace);
    }
  }

  void logFetchStoresSuccessful(int time, bool initial) {
    final parameters = _prepareParameters(
      category: AnalyticsEventCategory.api,
      label: 'api_success',
      value: time.toString(),
    );
    logEvent(
      name: initial ? AnalyticsEvent.apiFetchStoresInitial : AnalyticsEvent.apiFetchStores,
      parameters: parameters,
    );
  }

  void logFetchStoresNoStores(bool initial) {
    final parameters = _prepareParameters(category: AnalyticsEventCategory.api, label: 'api_failure_no_stores');
    logEvent(
      name: initial ? AnalyticsEvent.apiFetchStoresInitial : AnalyticsEvent.apiFetchStores,
      parameters: parameters,
    );
  }

  void logFetchStoresUnknownError(bool initial) {
    final parameters = _prepareParameters(category: AnalyticsEventCategory.api, label: 'api_failure_unknown');
    logEvent(
      name: initial ? AnalyticsEvent.apiFetchStoresInitial : AnalyticsEvent.apiFetchStores,
      parameters: parameters,
    );
  }

  void logFetchStoreDetailsSuccessful(int time, bool initial) {
    final parameters = _prepareParameters(
      category: AnalyticsEventCategory.api,
      label: 'api_success',
      value: time.toString(),
    );
    logEvent(name: AnalyticsEvent.storeViewed, parameters: parameters);
  }

  void logFetchStoreDetailsUnknownError(bool initial) {
    final parameters = _prepareParameters(category: AnalyticsEventCategory.api, label: 'api_failure_unknown');
    logEvent(name: AnalyticsEvent.storeViewed, parameters: parameters);
  }

  void logAddRemoveFavoritesSuccessful(bool initial) {
    final parameters = _prepareParameters(category: AnalyticsEventCategory.api, label: 'api_success');
    logEvent(
      name: initial ? AnalyticsEvent.apiAddRemoveFavoritesInitial : AnalyticsEvent.apiAddRemoveFavorites,
      parameters: parameters,
    );
  }

  void logAddRemoveFavoritesUnknownError(bool initial) {
    final parameters = _prepareParameters(category: AnalyticsEventCategory.api, label: 'api_failure_unknown');
    logEvent(
      name: initial ? AnalyticsEvent.apiAddRemoveFavoritesInitial : AnalyticsEvent.apiAddRemoveFavorites,
      parameters: parameters,
    );
  }

  void logViewStore({required String storeId, required String storeName}) {
    final label = _prepareLabel(storeId, storeName);
    final parameters = _prepareParameters(category: AnalyticsEventCategory.userAction, label: label);
    logEvent(name: AnalyticsEvent.viewStore, parameters: parameters);
  }

  void logShareStore({required String storeId, required String storeName}) {
    final label = _prepareLabel(storeId, storeName);
    final parameters = _prepareParameters(category: AnalyticsEventCategory.userAction, label: label);
    logEvent(name: AnalyticsEvent.shareStore, parameters: parameters);
  }

  void logAddToFavorites({required String storeId, required String storeName}) {
    final label = _prepareLabel(storeId, storeName);
    final parameters = _prepareParameters(category: AnalyticsEventCategory.userAction, label: label);
    logEvent(name: AnalyticsEvent.addToFavorites, parameters: parameters);
  }

  void logRemoveFromFavorites({required String storeId, required String storeName}) {
    final label = _prepareLabel(storeId, storeName);
    final parameters = _prepareParameters(category: AnalyticsEventCategory.userAction, label: label);
    logEvent(name: AnalyticsEvent.removeFromFavorites, parameters: parameters);
  }

  void logTapBanner({required String bannerId, required String bannerName}) {
    final label = _prepareLabel(bannerId, bannerName);
    final parameters = _prepareParameters(category: AnalyticsEventCategory.userAction, label: label);
    logEvent(name: AnalyticsEvent.tapBanner, parameters: parameters);
  }

  void logTapCategory({required String categoryId, required String categoryName}) {
    final label = _prepareLabel(categoryId, categoryName);
    final parameters = _prepareParameters(category: AnalyticsEventCategory.userAction, label: label);
    logEvent(name: AnalyticsEvent.tapCategory, parameters: parameters);
  }

  void logViewOffer({required String offerId, required String offerName, String? storeId}) {
    final label = _prepareLabel(offerId, offerName);
    final parameters = _prepareParameters(
      category: AnalyticsEventCategory.userAction,
      label: label,
      value: storeId ?? '',
    );
    logEvent(name: AnalyticsEvent.viewOffer, parameters: parameters);
  }

  void logAddReview({required String storeId, required String storeName, int? rating}) {
    final label = _prepareLabel(storeId, storeName);
    final parameters = _prepareParameters(
      category: AnalyticsEventCategory.userAction,
      label: label,
      value: rating?.toString() ?? '',
    );
    logEvent(name: AnalyticsEvent.addReview, parameters: parameters);
  }

  bool _determineWhetherInitial() {
    // final UserModel? user = _userRepository.userDetails;
    // Consider initial if user doesn't exist (first time user)
    // if (user == null) {
    //   return true;
    // }

    return false;
  }

  void _logRoute() {
    if (routeTimeTracker.isNotEmpty) {
      try {
        routeTimeTracker.entries.first.value.stop();
        final int timeElapsed = routeTimeTracker.entries.first.value.elapsed.inMilliseconds;
        final String? routeName = routeTimeTracker.entries.first.key;
        final parameters = _prepareParameters(
          category: AnalyticsEventCategory.userAction,
          label: '$routeName',
          value: timeElapsed.toString(),
        );
        logEvent(name: AnalyticsEvent.screen, parameters: parameters);
        routeTimeTracker.clear();
      } catch (error, stackTrace) {
        _debugAnalytics.errorLog(e: error, s: stackTrace);
      }
    }
  }

  // void _logStoreViewed() {
  //   if (storeViewTimeTracker.isNotEmpty) {
  //     try {
  //       storeViewTimeTracker.entries.first.value.stop();
  //       final int storeTimeElapsed = storeViewTimeTracker.entries.first.value.elapsed.inMilliseconds;
  //       final StoreModel store = storeViewTimeTracker.entries.first.key!;
  //       final label = _prepareLabel(store.id, store.name);
  //       final parameters = _prepareParameters(
  //         category: AnalyticsEventCategory.appTimings,
  //         label: label,
  //         value: storeTimeElapsed.toString(),
  //       );
  //       logEvent(name: AnalyticsEvent.storeViewed, parameters: parameters);
  //       storeViewTimeTracker.clear();
  //     } catch (error, stackTrace) {
  //       _debugAnalytics.errorLog(e: error, s: stackTrace);
  //     }
  //   }
  // }

  String _prepareLabel(dynamic id, String title) => '$id|$title';

  Map<String, Object> _prepareParameters({required String category, String label = '', String value = ''}) => {
    AnalyticsParameter.category: category,
    AnalyticsParameter.label: label,
    AnalyticsParameter.value: value,
  };
}
