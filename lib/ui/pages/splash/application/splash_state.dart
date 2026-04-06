import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState.onLoading() = ShowLoading;

  const factory SplashState.navigateToOnboarding() = NavigateToOnboarding;

  const factory SplashState.navigateToLogin() = NavigateToLogin;

  const factory SplashState.navigateToHome() = NavigateToHome;

  const factory SplashState.error(String messege) = SplashError;
}
