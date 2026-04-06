// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

abstract class FirebaseAnalyticsConfig {
  static Future<void> initCrashlytics() async {
    if (kDebugMode) {
      // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      return;
    }

    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //
    //   return true;
    // };
  }

  static void recordError({required String name, required StackTrace? s, required Object? e}) {
    if (kDebugMode) {
      return;
    }
    // FirebaseCrashlytics.instance.recordError(e, s, information: [name]);
  }
}
