import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'location_info_model.freezed.dart';
part 'location_info_model.g.dart';

@freezed
abstract class LocationInfoModel with _$LocationInfoModel {
  @HiveType(typeId: 6, adapterName: 'LocationAdapter')
  const factory LocationInfoModel({@HiveField(0) required String latitude, @HiveField(1) required String longitude,
    @HiveField(3) required String place,
    @HiveField(4) String? country,
    @HiveField(5) String? state,
    @HiveField(6) String? district,
  }) =
      _LocationInfoModel;

  factory LocationInfoModel.fromJson(Map<String, dynamic> json) => _$LocationInfoModelFromJson(json);
}

@freezed
abstract class LocationInfoHeaderDTO with _$LocationInfoHeaderDTO {
  const factory LocationInfoHeaderDTO({
    required double latitude,
    required double longitude,
  }) = _LocationInfoHeaderDTO;

  factory LocationInfoHeaderDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoHeaderDTOFromJson(json);
}
