import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../data/model/country/country_model.dart';
import '../data/repository/country_picker_repository.dart';
import 'country_picker_state.dart';

@injectable
class CountryPickerCubit extends Cubit<CountryPickerState> {
  final CountryPickerRepository _countryPickerRepository;
  List<CountryModel> _countries = [];
  List<CountryModel> _filteredCountries = [];
  CountryModel? _selectedCountry;
  String? code;

  CountryPickerCubit(@factoryParam this.code, this._countryPickerRepository) : super(const CountryPickerStateIdle()) {
    _initialize();
  }

  Future<void> _initialize() async {
    emit(state.copyWith(isLoading: true));
    final result = await _countryPickerRepository.getCountries();
    result.fold(
      (l) => emit(state.copyWith(isLoading: false)),
      (r) => emit(state.copyWith(isLoading: true, countries: r.data.countries, filteredCountries: r.data.countries)),
    );
    _countries = state.countries;
    _filteredCountries = _countries;
    final selected = _countries.firstWhereOrNull((c) => c.code == code);
    emit(
      state.copyWith(
        isLoading: false,
        countries: _countries,
        filteredCountries: _filteredCountries,
        selectedCountry: selected,
      ),
    );
  }

  Future<void> onSearch(String? value) async {
    if (value?.isEmpty ?? true) {
      _filteredCountries = _countries;
    } else {
      _filteredCountries = _countries
          .where(
            (c) =>
                (c.code.toLowerCase().contains(value!.trim().toLowerCase())) ||
                c.name.toLowerCase().contains(value.trim().toLowerCase()),
          )
          .toList();
    }

    emit(state.copyWith(filteredCountries: _filteredCountries));
  }

  Future<void> selectCountry(CountryModel country, ValueSetter<CountryModel> onSelectCountry) async {
    _selectedCountry = country;
    emit(state.copyWith(selectedCountry: _selectedCountry));
    onSelectCountry(_selectedCountry!);
  }
}
