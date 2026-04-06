import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  @HiveType(typeId: 2, adapterName: 'UserAdapter')
  const factory UserModel({
    @HiveField(0) @JsonKey(name: 'full_name') required String name,
    @HiveField(1) @JsonKey(name: 'email') required String email,
    @HiveField(2) @JsonKey(name: 'phone_code') required String phoneCode,
    @HiveField(3) @JsonKey(name: 'phoneNumber') required String phoneNumber,
    @HiveField(4) @JsonKey(name: 'gender') required String gender,
    @HiveField(5) @JsonKey(name: 'dob') required String dob,
    @HiveField(6) @JsonKey(name: 'address') required String address,
    @HiveField(7) @JsonKey(name: 'image') String? image,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

