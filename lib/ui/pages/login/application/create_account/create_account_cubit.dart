import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/injection/injection.dart';
import '../../../../../core/model/settings/settings_model.dart';
import '../../../../../core/model/user/user_model.dart';
import 'create_account_state.dart';

@injectable
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

    // 🔥 CREATE USER
    final user = UserModel(
      name: name,
      email: email,
      phoneCode: '+91',
      phoneNumber: '',
      dob: dob,
      gender: gender,
      address: address,
    );

    // 🔥 SAVE USER
    await locator<Box<UserModel>>().put('user', user);

    // 🔥 SAVE SETTINGS (THIS IS THE MAIN FIX 💥)
    await locator<Box<SettingsModel>>().put(
      'settings',
      const SettingsModel(
        hasOnboarded: true,
        hasLogged: true,
      ),
    );

    // 🔥 NAVIGATE
    emit(const CreateAccountState.navigateToHome());
  }
}