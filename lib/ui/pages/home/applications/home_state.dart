import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/error/failure.dart';
import '../../../../core/model/user/user_model.dart';
import '../data/model/blog/blog_model.dart';
import '../data/model/doctor/doctor_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loaded({
    UserModel? user,
    @Default([]) List<DoctorModel> doctors,
    @Default([]) List<BlogModel> blogs,

}) = _Loaded;
  const factory HomeState.doctorListLoaded(List<dynamic> data) = _DoctorListLoaded;

  const factory HomeState.error(Failure failure) = _Error;

  


  }


