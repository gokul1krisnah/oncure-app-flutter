import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@injectable
class DebugAnalytics {
  void errorLog({required StackTrace? s, required Object? e, String name = 'Exception'}) {
    Logger().e('$name :', stackTrace: s, error: e);
    // FirebaseAnalyticsConfig.recordError(name: name, s: s, e: e);
  }

  void infoLog({required String name, required String message}) {
    Logger().i('$name : $message');
  }
}