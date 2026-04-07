import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/analytics/debug_analytics.dart';
import '../../../../../core/enums/animated_button_state_enum.dart';
import '../../../../../core/services/location_service.dart';

@injectable
class RequestLocationPermissionCubit extends Cubit<AnimatedButtonStateEnum> {
  final LocationService _locationService;
  final DebugAnalytics _analytics;
  RequestLocationPermissionCubit(this._locationService, this._analytics) : super(AnimatedButtonStateEnum.idle);

  Future<void> getPermission() async {
    if (state.isLoading) return;
    if(isClosed) return;
    emit(AnimatedButtonStateEnum.loading);
    try {
      await _locationService.requestPermission();
      if(isClosed) return;
      emit(AnimatedButtonStateEnum.success);
    } catch (e, s) {
      _analytics.errorLog(s: s, e: e);
      if(isClosed) return;
      emit(AnimatedButtonStateEnum.error);
    }
  }
}
