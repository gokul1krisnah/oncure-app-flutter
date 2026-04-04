import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(const CreateAccountState.initial());

  String? validateName(String value) {
    if (value.isEmpty) return 'Enter your name';
    if (value.length < 3) return 'Name too short';
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Enter email';

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(value)) {
      return 'Invalid email';
    }

    return null;
  }

  String? validateDob(String value) {
    if (value.isEmpty) return 'Select DOB';
    return null;
  }

  String? validateGender(String value) {
    if (value.isEmpty) return 'Select gender';
    return null;
  }

  String? validateAddress(String value) {
    if (value.isEmpty) return 'Enter address';
    return null;
  }

  Future<void> submit({
    required String name,
    required String email,
    required String dob,
    required String gender,
    required String address,
  }) async {
    String? error;

    error = validateName(name);
    error ??= validateEmail(email);
    error ??= validateDob(dob);
    error ??= validateGender(gender);
    error ??= validateAddress(address);

    if (error != null) {
      emit(CreateAccountState.error(error));
      return;
    }

    emit(const CreateAccountState.initial());

    // 🔥 later API call here

    emit(const CreateAccountState.navigateToHome());
  }
}