import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(const VerifyState.initial());

  Future<void> verifyOtp(String otp) async {
    if (otp.length != 6) {
      emit(const VerifyState.error('Enter valid OTP'));
      return;
    }

    emit(const VerifyState.initial()); // reset

    // 🔥 later API call here

    emit(const VerifyState.navigateToCreateAccount());
  }
}