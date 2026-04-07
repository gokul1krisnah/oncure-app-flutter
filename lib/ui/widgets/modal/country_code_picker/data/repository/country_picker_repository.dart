import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/model/error/failure.dart';
import '../../../../../../core/model/response/response_model.dart';
import '../source/country_picker_rds.dart';

@injectable
class CountryPickerRepository {
  final CountryPickerRds _countryPickerRds;

  CountryPickerRepository(this._countryPickerRds);

  Future<Either<Failure, ResponseModel<GetCountriesDTO>>> getCountries() => _countryPickerRds.getCountries();
}
