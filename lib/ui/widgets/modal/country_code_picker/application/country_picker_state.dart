import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/model/country/country_model.dart';

part 'country_picker_state.freezed.dart';

@freezed
abstract class CountryPickerState with _$CountryPickerState {
  const factory CountryPickerState.idle({
    @Default([]) List<CountryModel> countries,
    @Default([]) List<CountryModel> filteredCountries,
    CountryModel? selectedCountry,
    @Default(false) bool isLoading,
  }) = CountryPickerStateIdle;
}
