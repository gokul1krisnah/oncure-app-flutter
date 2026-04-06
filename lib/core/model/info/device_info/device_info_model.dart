import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'device_info_model.freezed.dart';
part 'device_info_model.g.dart';

@freezed
abstract class DeviceInfoModel with _$DeviceInfoModel {
  @HiveType(typeId: 4, adapterName: 'DeviceInfoAdapter')
  const factory DeviceInfoModel({
    @HiveField(0) required String platform,
    @HiveField(1) required String deviceId,
    @HiveField(2) String? model,
    @HiveField(3) String? brand,
    @HiveField(4) String? manufacturer,
    @HiveField(5) String? osVersion,
    @HiveField(6) int? sdkInt,
    @HiveField(7) String? systemName,
    @HiveField(8) String? systemVersion,
    @HiveField(9) String? identifierForVendor,
  }) = _DeviceInfoModel;

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) => _$DeviceInfoModelFromJson(json);

}
