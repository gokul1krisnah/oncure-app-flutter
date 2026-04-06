import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  @HiveType(typeId: 1, adapterName: 'NotificationAdapter')
  const factory NotificationModel({
    @HiveField(0) @JsonKey(name: 'id') required int id,
    @HiveField(1) @JsonKey(name: 'title') required String title,
    @HiveField(2) @JsonKey(name: 'body') required String body,
    @HiveField(3) @JsonKey(name: 'data') required String data,
    @HiveField(4) @JsonKey(name: 'date') required String date,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
}
