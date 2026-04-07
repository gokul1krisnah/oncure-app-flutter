import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';


import '../../../../core/injection/injection.dart';
import '../../../../core/model/settings/settings_model.dart';
import 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.onLoading());

  final settingsBox = locator<Box<SettingsModel>>();

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    final settings = settingsBox.get('settings');

    if (isClosed) return;

    if (settings == null || !settings.hasOnboarded) {
      emit(const SplashState.navigateToOnboarding());
    
    
      await settingsBox.put(
        'settings',
        const SettingsModel(
          hasOnboarded: true,
          hasLogged: false,
        ),
      );

      return;
    }

    if (isClosed) return;

    
    if (!settings.hasLogged) {
      emit(const SplashState.navigateToLogin());
      return;
    }

    if (isClosed) return;

    
    emit(const SplashState.navigateToHome());
  }
}