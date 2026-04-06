import 'package:freezed_annotation/freezed_annotation.dart';

import '../../user/user_model.dart';
import '../app_info/app_info_model.dart';
import '../device_info/device_info_model.dart';
import '../network_info/network_info_model.dart';

part 'system_details_model.g.dart';

part 'system_details_model.freezed.dart';

@freezed
abstract class SystemDetailsModel with _$SystemDetailsModel{
  const factory SystemDetailsModel({
    required AppInfoModel app,
    required DeviceInfoModel device,
    required NetworkInfoModel network,
    required UserModel? user,
    required String timestamp,
  }) = _SystemDetailsModel;

  factory SystemDetailsModel.fromJson(Map<String, dynamic> json) => _$SystemDetailsModelFromJson(json);
}
