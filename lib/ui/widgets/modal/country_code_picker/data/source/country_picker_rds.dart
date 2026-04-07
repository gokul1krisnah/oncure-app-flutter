import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../core/model/error/failure.dart';
import '../../../../../../core/model/response/response_model.dart';
import '../../../../../../core/networking/data_adapter.dart';
import '../../../../../../core/networking/end_points.dart';
import '../model/country/country_model.dart';

part 'country_picker_rds.freezed.dart';
part 'country_picker_rds.g.dart';

@RestApi(callAdapter: DataAdapter)
// @RestApi()
@injectable
abstract class CountryPickerRds {
  @factoryMethod
  factory CountryPickerRds(Dio dio) = _CountryPickerRds;

  @GET(EndPoints.countries)
  Future<Either<Failure, ResponseModel<GetCountriesDTO>>> getCountries();
}

@freezed
abstract class GetCountriesDTO with _$GetCountriesDTO {
  const factory GetCountriesDTO({@Default([]) List<CountryModel> countries}) = _GetCountriesDTO;

  factory GetCountriesDTO.fromJson(Map<String, dynamic> json) => _$GetCountriesDTOFromJson(json);
}
