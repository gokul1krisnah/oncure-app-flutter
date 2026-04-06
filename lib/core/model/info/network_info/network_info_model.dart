import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'network_info_model.freezed.dart';
part 'network_info_model.g.dart';

@freezed
abstract class NetworkInfoModel with _$NetworkInfoModel {
  @HiveType(typeId: 5, adapterName: 'NetworkInfoAdapter')
  const factory NetworkInfoModel({
    @HiveField(0) required String connectionType,
    @HiveField(1) String? ip,
    @HiveField(2) DateTime? capturedAt,
  }) = _NetworkInfoModel;

  factory NetworkInfoModel.fromJson(Map<String, dynamic> json) => _$NetworkInfoModelFromJson(json);

}
