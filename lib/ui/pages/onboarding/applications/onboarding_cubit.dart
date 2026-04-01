import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plan_my_onco/ui/pages/onboarding/applications/onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  final PageController pageController = PageController();

  void nextPage() {
    if (state.currentPage < 2) {
      final next = state.currentPage + 1;

      pageController.animateToPage(
        next,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state.copyWith(currentPage: next));
    }
  }

  void skip() {
    pageController.jumpToPage(2);
    emit(state.copyWith(currentPage: 2));
    pageController.animateToPage(
      2,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onChangedPage(int index) {
    emit(state.copyWith(currentPage: index));
  }
  
}
