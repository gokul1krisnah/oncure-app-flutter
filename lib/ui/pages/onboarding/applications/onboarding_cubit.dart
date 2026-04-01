
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState.currentPage());

  void onChangedPage(int index) {
    final currentState = state;
    if (currentState is CurrentPage) {
      emit(currentState.copyWith(currentPage: index));
    }
  }

  void loginPageNavigate() {
    emit(const OnboardingState.navigateToLogin());
  }
}
