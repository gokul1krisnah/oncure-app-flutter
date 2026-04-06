// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:logger/logger.dart';

// // import '../../firebase_options.dart';
// import '../../shared/constants/app_constants.dart';
// import '../../shared/theme/app_colors.dart';
// import '../data/repositories/fcm_notification_repository.dart';
// import '../data/repositories/fcm_topic_key_repository.dart';
// import '../data/repositories/settings_repository.dart';
// import '../hive/hive_config.dart';
// import '../injection/injection.dart';
// import '../routes/app_router.dart';
// import '../routes/app_router.gr.dart';
// import 'notification_service.dart';
// // import '../routes/app_router.dart';
// // import '../routes/app_router.gr.dart';

// ///This class helps to show [FCM notification](https://firebase.flutter.dev/docs/messaging/overview)
// ///with help of [flutter local notification plugin](https://pub.dev/packages/flutter_local_notifications).
// ///
// /// Specify the fcm notification channel, drawable icon and color in AndroidManifest.xml before activity tag.
// /// The notification icons can be generated from [Icon Generator]
// /// (https://romannurik.github.io/AndroidAssetStudio/icons-notification.html#source.space.trim=1&source.space.pad=0&name=notification)
// ///
// /// Example:
// /// ```xml
// /// <application>
// ///         <meta-data
// ///             android:name="com.google.firebase.messaging.default_notification_channel_id"
// ///             android:value="<CHANNEL_NAME>" />
// ///         <meta-data
// ///             android:name="com.google.firebase.messaging.default_notification_icon"
// ///             android:resource="@drawable/notification" />
// ///         <activity>
// ///           --------
// ///         </activity>
// /// </application>
// /// ```

// const AndroidNotificationChannel _androidChannel = AndroidNotificationChannel(
//   AppConstants.defaultNotificationId,
//   AppConstants.defaultNotificationName,
//   importance: Importance.max,
//   enableLights: true,
//   playSound: true,
//   enableVibration: true,
// );

// final NotificationDetails _notificationDetails = NotificationDetails(
//   android: AndroidNotificationDetails(
//     _androidChannel.id,
//     _androidChannel.name,
//     channelDescription: _androidChannel.description,
//     importance: _androidChannel.importance,
//     priority: Priority.max,
//     enableLights: true,
//     color: AppColors.primary,
//     playSound: true,
//     // icon: 'notification',
//     enableVibration: true,
//     styleInformation: const BigTextStyleInformation(''),
//   ),
//   iOS: const DarwinNotificationDetails(presentBadge: true, presentAlert: true, presentSound: true),
// );

// abstract class FCMNotification {
//   static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

//   static final Set<String> _shownNotifications = {};

//   static Future<void> init([bool setBackground = true]) async {
//     if (Firebase.apps.isEmpty) {
//       await Firebase.initializeApp(name: AppConstants.defaultAppName, options: DefaultFirebaseOptions.currentPlatform);
//     }
//     await _initializeLocalNotifications();
//     await _setupAndroidHeadsUp();

//     if (setBackground) {
//       FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     }
//   }

//   static Future<void> runFCM() async {
//     // Request permissions
//     if (Platform.isIOS) {
//       await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);
//     } else {
//       await _plugin
//           .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//           ?.requestNotificationsPermission();
//     }
//     // TODO: Hangs on iOS
//     // // // Handle app opened from TERMINATED state (notification already shown by system)
//     // final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     // if (initialMessage != null) {
//     //   _handleNotificationTap(initialMessage.data);
//     // }

//     // Handle app opened from BACKGROUND state (notification already shown by system)
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       _handleNotificationTap(message.data);
//     });

//     // Handle notification received while app in FOREGROUND (system won't show it)
//     FirebaseMessaging.onMessage.listen((message) {
//       showNotification(message, isForeground: true);
//     });

//     unawaited(getToken(isTokenListenerInitialized: false));

//     // Subscribe to topics
//   }

//   // Separate method for handling notification taps
//   static void _handleNotificationTap(Map<String, dynamic> data) {
//     _onSelectNotification(
//       NotificationResponse(
//         notificationResponseType: NotificationResponseType.selectedNotification,
//         payload: jsonEncode(data),
//       ),
//     );
//   }

//   /// SUBSCRIBES TO DYNAMIC TOPIC
//   static Future<void> subscribeToTopic() async {
//     try {
//       final hasPermission = await _checkNotificationPermission();
//       if (!hasPermission) {
//         Logger().e('Cannot subscribe to topic: Notification permission not granted');
//         return;
//       }

//       final key = locator<FcmTopicKeyRepository>().fcmTopicKey;

//       await FirebaseMessaging.instance.subscribeToTopic(key);
//     } catch (e, s) {
//       Logger().e('Error subscribing to topic', error: e, stackTrace: s);
//     }
//   }

//   static Future<void> unsubscribeFromTopic() async {
//     try {
//       final hasPermission = await _checkNotificationPermission();
//       if (!hasPermission) {
//         Logger().e('Cannot unsubscribe to topic: Notification permission not granted');
//         return;
//       }

//       final key = locator<FcmTopicKeyRepository>().fcmTopicKey;
//       await FirebaseMessaging.instance.unsubscribeFromTopic(key);
//       await locator<FcmTopicKeyRepository>().deleteKey();
//     } catch (e, s) {
//       Logger().e('Error unsubscribing from topic', error: e, stackTrace: s);
//     }
//   }

//   /// Helper method to check notification permissions
//   static Future<bool> _checkNotificationPermission() async {
//     final settings = await FirebaseMessaging.instance.getNotificationSettings();

//     return settings.authorizationStatus == AuthorizationStatus.authorized ||
//         settings.authorizationStatus == AuthorizationStatus.provisional;
//   }

//   static Future<void> showNotification(RemoteMessage message, {bool isForeground = false}) async {
//     final data = message.data;
//     Logger().i('Message: ${message.data}');

//     // Prevent duplicates
//     final messageId = message.messageId ?? message.hashCode.toString();
//     if (_shownNotifications.contains(messageId)) {
//       Logger().i('Notification already shown: $messageId');
//       return;
//     }

//     if (isForeground && data['foreground'] == 'false') return;

//     final title = data['title'] ?? message.notification?.title ?? 'New Notification';
//     final body = data['body'] ?? message.notification?.body ?? '';

//     await _plugin.show(message.hashCode, title, body, _notificationDetails, payload: jsonEncode(data));

//     _shownNotifications.add(messageId);

//     // Clean up old entries (keep last 100)
//     if (_shownNotifications.length > 100) {
//       _shownNotifications.clear();
//     }
//     final id = data['uuid'] ?? '';

//     try {
//       await locator<FcmNotificationRepository>().saveNotification(id);
//       Logger().i('Saved notification ID: $id');
//     } catch (e) {
//       Logger().e('Error saving notification ID', error: e);
//     }
//   }

//   @pragma('vm:entry-point')
//   static void _onSelectNotification(NotificationResponse response) {
//     final String? payload = response.payload;
//     Logger().i('Payload:: $payload');

//     if (payload != null) {
//       // Check if app is ready
//       try {
//         // App is ready, navigate immediately
//         _navigateToScreen(payload);
//       } catch (e) {
//         // Router not initialized yet, store for later
//         Logger().i('NavigateToScreen to , storing payload: $e');
//       }
//     }
//   }

//   static Future<void> _navigateToScreen(String payload) async {
//     try {
//       final Map<String, dynamic> data = jsonDecode(payload) as Map<String, dynamic>;

//       if (data.containsKey('uuid') && data['uuid'] is String && data['uuid'].isNotEmpty) {
//         unawaited(locator<FcmNotificationRepository>().deleteKey(id: data['uuid']));
//       }

//       final router = locator<AppRouter>();

//       // if (data.containsKey('store') && data['store'] != null) {
//       //   dynamic storeJson = data['store'];
//       //   if (storeJson is String) {
//       //     storeJson = jsonDecode(storeJson) as Map<String, dynamic>;
//       //   }
//       //   final store = StoreModel.fromJson(storeJson);
//       //
//       //   await router.replaceAll([const HomeRoute(), StoreDetailsRoute(store: store)]);
//       //   return;
//       // }

//       await router.replaceAll([const HomeRoute()]);
//     } catch (e, s) {
//       Logger().e('Navigation error', error: e, stackTrace: s);
//     }
//   }

//   static Future<void> getToken({bool isTokenListenerInitialized = true}) async {
//     final token = await FirebaseMessaging.instance.getToken();

//     // Send to backend

//     await _handleTokenRefresh(token);

//     if (isTokenListenerInitialized) {
//       return;
//     }

//     // Listen for refresh
//     FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async => _handleTokenRefresh(newToken));
//   }

//   static Future<void> _handleTokenRefresh(String? newToken) async {
//     unawaited(_sendTokenToBackend(newToken));
//     final hasPermission = await _checkNotificationPermission();

//     if (!hasPermission) return;
//     unawaited(FirebaseMessaging.instance.subscribeToTopic(AppConstants.defaultFCMTopicGeneral));
//     if (!locator<SettingsRepository>().settings.hasLogged) return;
//     unawaited(subscribeToTopic());
//     return;
//   }

//   /// SEND TOKEN TO BACKEND
//   static Future<void> _sendTokenToBackend(String? token) async {
//     if (locator<SettingsRepository>().settings.hasLogged && (token?.isNotEmpty ?? false)) {
//       Logger().i('Token: $token');
//       await locator<SettingsRepository>().saveFCMToken(token);
//       final location = locator<SettingsRepository>().settings.location;
//       unawaited(
//         locator<NotificationService>().saveToken(
//           NotificationServiceDTO(
//             token: token!,
//             district: location?.district,
//             state: location?.state,
//             country: location?.country,
//             longitude: location?.longitude,
//             latitude: location?.latitude,
//           ),
//         ),
//       );
//     }
//   }

//   static Future<void> _initializeLocalNotifications() async {
//     const androidSettings = AndroidInitializationSettings(AppConstants.defaultAndroidIcon);
//     const darwinSettings = DarwinInitializationSettings();
//     const settings = InitializationSettings(android: androidSettings, iOS: darwinSettings);
//     await _plugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: _onSelectNotification,
//       onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
//     );
//   }

//   /// Create an Android Notification Channel.
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   static Future<void> _setupAndroidHeadsUp() async {
//     if (!Platform.isAndroid) {
//       return;
//     }
//     await _plugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_androidChannel);
//   }
// }

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (Firebase.apps.isEmpty) {
//     await Firebase.initializeApp(name: AppConstants.defaultAppName, options: DefaultFirebaseOptions.currentPlatform);
//   }

//   try {
//     // Step 1: Initialize Hive manually (important for background isolate)
//     await HiveConfig.init();

//     // Step 2: Initialize Firebase DI (after Hive)
//     await configureInjection();

//     // Step 3: Initialize FCM Notification without re-registering background handler
//     await FCMNotification.init(false);

//     Logger().i('A background message just showed up : ${message.messageId}  ${message.data}');
//   } catch (e, s) {
//     Logger().e('Notification Error', error: e, stackTrace: s);
//   }
// }
