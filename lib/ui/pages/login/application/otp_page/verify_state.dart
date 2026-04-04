import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_state.freezed.dart';

@freezed
abstract class VerifyState with _$VerifyState {
  const factory VerifyState.initial() = _Initial;
  const factory VerifyState.loading() = _Loading;
  const factory VerifyState.error(String error) = _Error;
  const factory VerifyState.navigateToCreateAccount() = NavigateToCreateAccount;
}
