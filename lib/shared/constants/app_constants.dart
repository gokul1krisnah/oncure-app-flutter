import 'package:flutter/foundation.dart';

abstract class AppConstants {
  static const String defaultFontFamily = 'DM Sans';
  static const String defaultAppName = 'Fiinder';
  static const String defaultAndroidIcon = '@drawable/notification';
  static const String defaultNotificationId = 'fiinder_notification';
  static const String defaultNotificationName = 'Fiinder';
  static const String defaultFCMTopicGeneral = kDebugMode
      ? 'fiinder-push-notification-general-test'
      : 'fiinder-push-notification-general';

  static const String englishLocale = 'en';

  static String getFcmTopicKey({String? country, String? state, String? district}) {
    String sanitize(String? value) {
      if (value == null || value.isEmpty) return 'all';
      return value.toLowerCase().trim().replaceAll(' ', '_').replaceAll(RegExp('[^a-zA-Z0-9_-]'), '_');
    }

    final key = 'country_${sanitize(country)}_state_${sanitize(state)}_district_${sanitize(district)}';
    return key;
  }
}
