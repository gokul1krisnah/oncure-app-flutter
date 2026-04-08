
import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
abstract class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
     @JsonKey(name: 'doctor_name') required String name,
     @JsonKey(name: 'specialization') required String specialization,
     @JsonKey(name: 'doctor_image') String? image,
  }) = _DoctorModel;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => _$DoctorModelFromJson(json);
}

