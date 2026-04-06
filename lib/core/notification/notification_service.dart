import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../networking/end_points.dart';

part 'notification_service.freezed.dart';
part 'notification_service.g.dart';

@RestApi()
@injectable
abstract class NotificationService {
  @factoryMethod
  factory NotificationService(Dio dio) = _NotificationService;

  @POST(EndPoints.saveFcmToken)
  Future<void> saveToken(@Body() NotificationServiceDTO body);
}

@freezed
abstract class NotificationServiceDTO with _$NotificationServiceDTO {
  const factory NotificationServiceDTO({
    @JsonKey(name: 'token') required String token,
    @JsonKey(name: 'latitude') required String? latitude,
    @JsonKey(name: 'longitude') required String? longitude,
    @JsonKey(name: 'country') required String? country,
    @JsonKey(name: 'state') required String? state,
    @JsonKey(name: 'district') required String? district,
  }) = _NotificationServiceDTO;

  factory NotificationServiceDTO.fromJson(Map<String, dynamic> json) => _$NotificationServiceDTOFromJson(json);
}
