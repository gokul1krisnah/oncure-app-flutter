import 'package:app_install_date/app_install_date.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../model/info/app_info/app_info_model.dart';
import '../../model/info/device_info/device_info_model.dart';
import '../../model/info/location_info/location_info_model.dart';
import '../../model/info/network_info/network_info_model.dart';
import '../../model/settings/settings_model.dart';
// import '../../notification/fcm_notification.dart';
import '../lds/settings_lds.dart';
import 'fcm_topic_key_repository.dart';

@lazySingleton
class SettingsRepository {
  final SettingsLDS settingsLDS;
  final FcmTopicKeyRepository _fcmTopicKeyRepository;
  // final SettingsRDS _settingsRDS;

  SettingsRepository(this.settingsLDS, this._fcmTopicKeyRepository);

  SettingsModel get settings => settingsLDS.getSettings();

  ValueListenable<Box<SettingsModel>> get settingsListenable => settingsLDS.settingsListenable;

  Future<void> saveFCMToken(String? fcmToken) async => settingsLDS.saveSettings(settings.copyWith(fcmToken: fcmToken));

  Future<void> saveAuthToken(String? authToken) async =>
      settingsLDS.saveSettings(settings.copyWith(token: authToken, hasLogged: authToken != null));

  Future<void> saveHasOnboarded() async => settingsLDS.saveSettings(settings.copyWith(hasOnboarded: true));

  Future<void> removeToken() => settingsLDS.saveSettings(settings.copyWith(token: null, hasLogged: false));

  Future<void> reset() =>
      settingsLDS.saveSettings(settings.copyWith(token: null, hasLogged: false, location: null, fcmToken: null));

  Future<void> saveLanguage(String locale) => settingsLDS.saveSettings(settings.copyWith(appLanguage: locale));

  Future<void> init({required AppVersion appVersion, required LocationInfoModel location}) async {
    if (settings.appInstallDate == null) {
      final appInstallDate = await AppInstallDate().installDate;
      await settingsLDS.saveSettings(settings.copyWith(appInstallDate: appInstallDate.toUtc()));
    }

    // await FCMNotification.unsubscribeFromTopic();
    await _fcmTopicKeyRepository.saveKey(country: location.country, state: location.state, district: location.district);
    await settingsLDS.saveSettings(settings.copyWith(location: settings.location ?? location, appVersion: appVersion));
    // await FCMNotification.subscribeToTopic();
  }

  Future<void> saveLocation({required LocationInfoModel location}) async {
    // await FCMNotification.unsubscribeFromTopic();
    await _fcmTopicKeyRepository.saveKey(country: location.country, state: location.state, district: location.district);
    await settingsLDS.saveSettings(settings.copyWith(location: location));
    // await FCMNotification.subscribeToTopic();
  }

  Future<void> saveAppInfo({AppInfoModel? app}) async => settingsLDS.saveSettings(settings.copyWith(app: app));

  Future<void> saveAppContactInfo({required AppContactInfo appContactInfo}) async =>
      settingsLDS.saveSettings(settings.copyWith(appContactInfo: appContactInfo));

  Future<void> saveDeviceInfo({DeviceInfoModel? device}) async =>
      settingsLDS.saveSettings(settings.copyWith(device: device));

  Future<void> saveNetworkInfo({NetworkInfoModel? network}) async =>
      settingsLDS.saveSettings(settings.copyWith(network: network));

  // Future<Either<Failure, ResponseModel>> changeLanguage({required String appLanguage}) async =>
  //     _settingsRDS.changeLanguage(ChangeLanguageRequestDTO(appLanguage: appLanguage));
}
