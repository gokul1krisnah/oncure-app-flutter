import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success() = _Success;
  const factory LoginState.error(String error) = _Error;
  const factory LoginState.navigateToLogin() = NavigateToLogin;
}
