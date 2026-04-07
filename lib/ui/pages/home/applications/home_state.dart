import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/user/user_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({required UserModel user, required List<dynamic> doctors, required int selectedDoctorIndex}) = _Loaded;
  const factory HomeState.error(String error) = _Error;

  const factory HomeState.doctorListLoaded(List<dynamic> data) = _DoctorListLoaded;
}
