import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState.currentPage({@Default(0) int currentPage}) =
      CurrentPage;
    
      const factory OnboardingState.navigateToLogin() = NavigateToLogin;
}
