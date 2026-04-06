import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

import '../info/app_info/app_info_model.dart';
import '../info/device_info/device_info_model.dart';
import '../info/location_info/location_info_model.dart';
import '../info/network_info/network_info_model.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
abstract class SettingsModel with _$SettingsModel {
  @HiveType(typeId: 0, adapterName: 'SettingsAdapter')
  const factory SettingsModel({
    @HiveField(0) String? token,
    @HiveField(1) String? fcmToken,
    @HiveField(2, defaultValue: false) @Default(false) bool hasOnboarded,
    @HiveField(3, defaultValue: false) @Default(false) bool hasLogged,
    @HiveField(4, defaultValue: 'en') @Default('en') String appLanguage,
    @HiveField(5) AppInfoModel? app,
    @HiveField(6) DeviceInfoModel? device,
    @HiveField(7) NetworkInfoModel? network,
    @HiveField(8) LocationInfoModel? location,
    @HiveField(9) AppVersion? appVersion,
    @HiveField(10) DateTime? appInstallDate,
    @HiveField(11) @Default(AppContactInfo()) AppContactInfo appContactInfo,
  }) = _SettingsModel;
}

@freezed
abstract class AppVersion with _$AppVersion {
  @HiveType(typeId: 7, adapterName: 'AppVersionAdapter')
  const factory AppVersion({@HiveField(0) required String android, @HiveField(1) required String ios}) = _AppVersion;

  factory AppVersion.fromJson(Map<String, dynamic> json) => _$AppVersionFromJson(json);
}

@freezed
abstract class AppContactInfo with _$AppContactInfo {
  @HiveType(typeId: 9, adapterName: 'AppContactInfoAdapter')
  const factory AppContactInfo({
    @HiveField(0) String? phone,
    @HiveField(1) String? email,
    @HiveField(2) String? whatsApp,
    @HiveField(3) String? website,
    @HiveField(4) String? facebook,
    @HiveField(5) String? linkedIn,
    @HiveField(6) String? instagram,
    @HiveField(7) String? twitter,
  }) = _AppContactInfo;

  factory AppContactInfo.fromJson(Map<String, dynamic> json) => _$AppContactInfoFromJson(json);
}