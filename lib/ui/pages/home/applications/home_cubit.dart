import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/data/repositories/user_repository.dart';
import '../data/repository/home_repository.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final UserRepository _userRepository;
  final HomeRepository _homeRepository;
  HomeCubit(this._userRepository, this._homeRepository ,) 
    : super(const HomeState.initial());

  Future<void> loadDoctorList() async {
    final resp = await _homeRepository.getHome();
    resp.fold((failure) => emit(HomeState.error(failure)), (response) {
      emit(
        HomeState.loaded(
          user: _userRepository.userDetails,
          doctors: response.data.doctors,
          blogs: response.data.blogs,
        ),
      );
    });
  }
}
