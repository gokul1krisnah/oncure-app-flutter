import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_account_state.freezed.dart';

@freezed
class CreateAccountState with _$CreateAccountState {
  const factory CreateAccountState.initial() = _Initial;
  const factory CreateAccountState.loading() = _Loading;
  const factory CreateAccountState.error(String message) = _Error;
  const factory CreateAccountState.navigateToHome() = _NavigateToHome;
}