import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:plan_my_onco/core/routes/app_router.dart';

import 'injection.config.dart';

/// Global instance of the dependency injection container.
final GetIt locator = GetIt.instance;

/// Initializes the dependency injection system.
///
/// This function uses the `injectable` package to automatically register
/// all the annotated classes in the project.
@InjectableInit(generateForDir: ['lib'])
Future<void> configureInjection() async {
  // Avoid re-registering if already configured (e.g., in tests).
  // if (locator.isRegistered<DebugAnalytics>()) {
  //   return;
  // }
  // `init()` is a generated function by injectable that registers all dependencies.
  await locator.init();
}

/// A module for registering third-party dependencies and other concrete implementations.
///
/// This abstract class is processed by `injectable` to generate the necessary
/// dependency injection code for classes that we don't own or that require
/// complex initialization.
@module
abstract class RegisterModule {
  /// Provides a singleton instance of the [AppRouter].
  @lazySingleton
  AppRouter get instance => AppRouter();

  /// Provides a singleton instance of [Dio], configured with project-specific settings.
  // @lazySingleton
  // Dio get dio => DioConfig.configure();

  // /// Provides a singleton instance of [FirebaseAnalytics].
  // @lazySingleton
  // FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;

  // /// Provides a singleton instance of the Hive [Box] for [SettingsModel].
  // ///
  // /// The `@preResolve` annotation ensures that the Future completes before the
  // /// dependency is registered.
  // @lazySingleton
  // @preResolve
  // Future<Box<SettingsModel>> get settingsBox async =>
  //     Hive.openBox<SettingsModel>('settings', encryptionCipher: await HiveConfig.getEncryptionKey());

  // /// Provides a singleton instance of the Hive [Box] for [UserModel].
  // @lazySingleton
  // @preResolve
  // Future<Box<UserModel>> get userBox async =>
  //     Hive.openBox<UserModel>('user', encryptionCipher: await HiveConfig.getEncryptionKey());

  // /// Provides a singleton instance of the Hive [Box] for [AppInfoModel].
  // @lazySingleton
  // @preResolve
  // Future<Box<AppInfoModel>> get appInfoBox async =>
  //     Hive.openBox<AppInfoModel>('appInfo', encryptionCipher: await HiveConfig.getEncryptionKey());

  // /// Provides a singleton instance of the Hive [Box] for [DeviceInfoModel].
  // @lazySingleton
  // @preResolve
  // Future<Box<DeviceInfoModel>> get deviceInfoBox async =>
  //     Hive.openBox<DeviceInfoModel>('deviceInfo', encryptionCipher: await HiveConfig.getEncryptionKey());

  // /// Provides a singleton instance of the Hive [Box] for [NetworkInfoModel].
  // @lazySingleton
  // @preResolve
  // Future<Box<NetworkInfoModel>> get networkInfoBox async =>
  //     Hive.openBox<NetworkInfoModel>('networkInfo', encryptionCipher: await HiveConfig.getEncryptionKey());

  // /// Provides a named singleton instance of a Hive [Box] for storing FCM topic keys.
  // @lazySingleton
  // @preResolve
  // @Named('fcmTopicKeyBox')
  // Future<Box<String>> get fcmTopicKeys async =>
  //     Hive.openBox<String>('fcmTopicKeys', encryptionCipher: await HiveConfig.getEncryptionKey());

  // /// Provides a named singleton instance of a Hive [Box] for storing notification keys.
  // @lazySingleton
  // @preResolve
  // @Named('notificationsKeysBox')
  // Future<Box<String>> get notificationsKeys async =>
  //     Hive.openBox<String>('notificationsKeys', encryptionCipher: await HiveConfig.getEncryptionKey());
}
