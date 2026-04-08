import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../core/model/error/failure.dart';
import '../../../../../../core/model/response/response_model.dart';
import '../../../../../../core/networking/data_adapter.dart';
import '../../../../../../core/networking/end_points.dart';
import '../../model/blog/blog_model.dart';
import '../../model/doctor/doctor_model.dart';

part 'home_rds.freezed.dart';
part 'home_rds.g.dart';

@RestApi(callAdapter: DataAdapter)
@injectable
abstract class HomeRds {
  @factoryMethod
  factory HomeRds(Dio dio) = _HomeRds;

  @GET(EndPoints.home)
  Future<Either<Failure, ResponseModel<GetHomeResponse>>> getHome();


}

@freezed
abstract class GetHomeResponse with _$GetHomeResponse {
  const factory GetHomeResponse({
    required List<DoctorModel> doctors,
    required List<BlogModel> blogs,

  }) = _GetHomeResponse;

  factory GetHomeResponse.fromJson(Map<String, dynamic> json) => _$GetHomeResponseFromJson(json);
}




