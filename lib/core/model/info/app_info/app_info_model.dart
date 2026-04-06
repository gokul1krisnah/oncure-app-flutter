import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'app_info_model.freezed.dart';
part 'app_info_model.g.dart';

@freezed
abstract class AppInfoModel with _$AppInfoModel {
  @HiveType(typeId: 3, adapterName: 'AppInfoAdapter')
  const factory AppInfoModel({
    @HiveField(0) required String name,
    @HiveField(1) required String package,
    @HiveField(2) required String version,
    @HiveField(3) required String buildNumber,
  }) = _AppInfoModel;

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => _$AppInfoModelFromJson(json);

}
