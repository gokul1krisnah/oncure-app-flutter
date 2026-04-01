import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plan_my_onco/ui/pages/splash/application/splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.onLoading());

  Future<void> initialize() async {
    await Future.delayed(Duration(seconds: 2));

    emit(SplashState.navigateToOnboarding());
  }
}
