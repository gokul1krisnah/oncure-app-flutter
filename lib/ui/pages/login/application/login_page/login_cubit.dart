import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../onboarding/applications/onboarding_state.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  String? validateInput(String value) {
    if (value.isEmpty) {
      return 'Enter email or phone number';
    }

    // Phone check
    if (RegExp(r'^[0-9]+$').hasMatch(value)) {
      if (value.length != 10) {
        return 'Enter valid phone number';
      }
      return null;
    }

    // Email check
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter valid email';
    }

    return null;
  }

  // login page
  Future<void> login(String input) async {
    final error = validateInput(input);

    if (error != null) {
      emit(LoginState.error(error));
      return;
    }
    emit(const LoginState.initial());
    emit(const LoginState.navigateToLogin());
  }
}
