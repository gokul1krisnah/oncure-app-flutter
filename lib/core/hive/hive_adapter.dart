import 'package:hive_ce/hive.dart';

// import '../model/info/app_info/app_info_model.dart';
// import '../model/info/device_info/device_info_model.dart';
// import '../model/info/location_info/location_info_model.dart';
// import '../model/info/network_info/network_info_model.dart';
// import '../model/notification/notification_model.dart';
// import '../model/settings/settings_model.dart';
// import '../model/user/user_model.dart';
import '../model/info/app_info/app_info_model.dart';
import '../model/info/device_info/device_info_model.dart';
import '../model/info/location_info/location_info_model.dart';
import '../model/info/network_info/network_info_model.dart';
import '../model/notification/notification_model.dart';
import '../model/settings/settings_model.dart';
import '../model/user/user_model.dart';

/// A utility class for registering all Hive type adapters.
///
/// Type adapters are responsible for converting Dart objects to and from their
/// binary representation for storage in a Hive box.
abstract class HiveAdapter {
  /// Registers all the type adapters used in the application.
  ///
  /// This method should be called once during app initialization.
  /// It ensures that Hive knows how to serialize and deserialize the custom models.
  static void register() {
    _registerAdapter(SettingsAdapter()); // Type ID: 0
    _registerAdapter(NotificationAdapter()); // Type ID: 1
    _registerAdapter(UserAdapter()); // Type ID: 2
    _registerAdapter(AppInfoAdapter()); // Type ID: 3
    _registerAdapter(DeviceInfoAdapter()); // Type ID: 4
    _registerAdapter(NetworkInfoAdapter()); // Type ID: 5
    _registerAdapter(LocationAdapter()); // Type ID: 6
    _registerAdapter(AppVersionAdapter()); // Type ID: 7
    _registerAdapter(AppContactInfoAdapter()); // Type ID: 9
  }

  /// A helper method to register a type adapter only if it hasn't been
  /// registered already.
  ///
  /// This prevents errors that can occur from trying to register the same
  /// type adapter multiple times, especially in tests.
  static void _registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }
}
