import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'splash_state.dart';


@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.onLoading());

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    emit(const SplashState.navigateToOnboarding());
  }
}
