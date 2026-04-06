/// Defines a centralized list of all analytics event names used in the application.
///
/// Using constants for event names helps prevent typos and ensures consistency
/// across the app and with the analytics platform (e.g., Firebase, Google Analytics).
class AnalyticsEvent {
  // --- User Interaction Events ---

  /// Logged when a user views the details of a specific store.
  static const String viewStore = 'view_store';

  /// Logged when a user shares a store.
  static const String shareStore = 'share_store';

  /// Logged when a user adds a store to their favorites.
  static const String addToFavorites = 'add_to_favorites';

  /// Logged when a user removes a store from their favorites.
  static const String removeFromFavorites = 'remove_from_favorites';

  /// Logged when a user taps on a promotional banner.
  static const String tapBanner = 'tap_banner';

  /// Logged when a user taps on a store category.
  static const String tapCategory = 'tap_category';

  /// Logged when a user views a specific offer.
  static const String viewOffer = 'view_offer';

  /// Logged when a user successfully submits a review.
  static const String addReview = 'add_review';

  /// Logged to track that a user has viewed a store.
  static const String storeViewed = 'store_viewed';

  /// A generic event for logging screen views.
  static const String screen = 'screen';

  // --- API Performance & Tracking Events ---

  /// Logged for the API call to fetch a list of stores.
  static const String apiFetchStores = 'api_fetchStores';

  /// Logged for the API call to add or remove a store from favorites.
  static const String apiAddRemoveFavorites = 'api_add_remove_favorites';

  /// Logged for the initial API call to fetch stores when the app starts.
  static const String apiFetchStoresInitial = 'api_fetchStores_initial';

  /// Logged for the initial API call to add/remove favorites.
  static const String apiAddRemoveFavoritesInitial = 'api_add_remove_favorites_initial';
}

/// Defines the standard parameter names to be used in analytics events.
///
/// Using standardized parameter names is crucial for creating meaningful and
/// easy-to-filter reports in your analytics dashboard.
class AnalyticsParameter {
  /// The category of the event (e.g., 'user_action', 'api').
  static const String category = 'event_category';

  /// A more specific label for the event (e.g., the name of the button clicked).
  static const String label = 'event_label';

  /// A longer description for the event or parameter.
  static const String description = 'description';

  /// A numeric value associated with the event (e.g., a rating, a price).
  static const String value = 'value';
}

/// Defines the categories for analytics events to group them logically.
///
/// Categorizing events helps in analyzing user behavior patterns and app performance
/// more effectively.
class AnalyticsEventCategory {
  /// For events that are a direct result of a user's interaction with the UI.
  static const String userAction = 'user_action';

  /// For events related to API calls, used to monitor network performance and reliability.
  static const String api = 'api';

  /// For events that measure the time taken for specific operations in the app.
  static const String appTimings = 'app_timings';
}
