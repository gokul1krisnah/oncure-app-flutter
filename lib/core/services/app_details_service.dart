/// A service that provides details about the application, device, and network.
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../data/repositories/settings_repository.dart';
import '../data/repositories/user_repository.dart';
import '../injection/injection.dart';
import '../model/info/app_info/app_info_model.dart';
import '../model/info/device_info/device_info_model.dart';
import '../model/info/network_info/network_info_model.dart';
import '../model/info/system_details/system_details_model.dart';

/// A service that provides details about the application, device, and network.
@lazySingleton
class AppDetailsService {
  /// An instance of [DeviceInfoPlugin] for getting device information.
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// An instance of [Uuid] for generating unique identifiers.
  final Uuid _uuid = const Uuid();

  /// The cached device ID.
  String? _cachedDeviceId;

  /// Gets a [SystemDetailsModel] containing information about the app, device, network, and user.
  ///
  /// It retrieves the user details from [UserRepository] and settings from [SettingsRepository].
  /// If app, device, or network info is not available in settings, it fetches them.
  Future<SystemDetailsModel> getAllDetails() async {
    final user = locator<UserRepository>().userDetails;
    final settings = locator<SettingsRepository>().settings;
    final appInfo = settings.app ?? await _getAppInfo();
    final deviceInfo = settings.device ?? await _getDeviceInfo();
    final networkInfo = settings.network ?? await _getNetworkInfo();

    return SystemDetailsModel(
      app: appInfo,
      device: deviceInfo,
      network: networkInfo,
      user: user,
      timestamp: DateTime.now().toUtc().toIso8601String(),
    );
  }

  /// Retrieves application information from [PackageInfo].
  ///
  /// It then saves the information to [SettingsRepository].
  Future<AppInfoModel> _getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appInfo = AppInfoModel(
      name: packageInfo.appName,
      package: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
    unawaited(locator<SettingsRepository>().saveAppInfo(app: appInfo));

    return appInfo;
  }

  /// Retrieves device information using [DeviceInfoPlugin].
  ///
  /// It handles Android and iOS platforms and saves the information to [SettingsRepository].
  /// For other platforms, it returns a [DeviceInfoModel] with 'unknown' platform.
  Future<DeviceInfoModel> _getDeviceInfo() async {
    DeviceInfoModel? info;
    if (Platform.isAndroid) {
      final android = await _deviceInfo.androidInfo;
      info = DeviceInfoModel(
        platform: 'android',
        model: android.model,
        brand: android.brand,
        manufacturer: android.manufacturer,
        osVersion: android.version.release,
        sdkInt: android.version.sdkInt,
        deviceId: await _getDeviceId(),
      );
    } else if (Platform.isIOS) {
      final ios = await _deviceInfo.iosInfo;
      info = DeviceInfoModel(
        platform: 'ios',
        model: ios.utsname.machine,
        systemName: ios.systemName,
        systemVersion: ios.systemVersion,
        identifierForVendor: ios.identifierForVendor,
        deviceId: await _getDeviceId(),
      );
    } else {
      unawaited(locator<SettingsRepository>().saveDeviceInfo());

      return const DeviceInfoModel(platform: 'unknown', deviceId: '', model: '');
    }
    unawaited(locator<SettingsRepository>().saveDeviceInfo(device: info));

    return info;
  }

  /// Retrieves network information using [Connectivity] and [NetworkInfo].
  ///
  /// It gets the connection type and IP address and saves the information to [SettingsRepository].
  Future<NetworkInfoModel> _getNetworkInfo() async {
    try {
      final connectivityResults = await Connectivity().checkConnectivity();

      final connectivity = connectivityResults.isNotEmpty ? connectivityResults.first : ConnectivityResult.none;

      final connectionType = connectivity.toString().replaceAll('ConnectivityResult.', '');

      final String? ipAddress = await NetworkInfo().getWifiIP();

      final network = NetworkInfoModel(
        connectionType: connectionType,
        capturedAt: DateTime.timestamp(),
        ip: ipAddress ?? '',
      );

      unawaited(locator<SettingsRepository>().saveNetworkInfo(network: network));

      return network;
    } catch (e) {
      unawaited(locator<SettingsRepository>().saveNetworkInfo());
      return const NetworkInfoModel(connectionType: 'unknown');
    }
  }

  /// Retrieves the device ID.
  ///
  /// It first tries to get the cached device ID from [SettingsRepository].
  /// If it's not available, it generates a new UUID and returns it.
  Future<String> _getDeviceId() async {
    _cachedDeviceId = locator<SettingsRepository>().settings.device?.deviceId;
    if (_cachedDeviceId != null) return _cachedDeviceId!;

    _cachedDeviceId = _uuid.v4();
    return _cachedDeviceId!;
  }
}
