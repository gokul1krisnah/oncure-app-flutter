// import 'package:bloc/bloc.dart';
// import 'package:injectable/injectable.dart';

// import '../../../../../analytics/debug_analytics.dart';
// import '../../../../../core/enums/animated_button_state_enum.dart';
// import '../../../../../core/services/notification_permission_service.dart';

// @injectable
// class RequestNotificationPermission extends Cubit<AnimatedButtonStateEnum> {
//   final NotificationPermissionService _notificationPermissionService;
//   final DebugAnalytics _analytics;
//   RequestNotificationPermission(this._notificationPermissionService, this._analytics)
//     : super(AnimatedButtonStateEnum.idle);

//   Future<void> requestPermission() async {
//     if (state.isLoading) return;
//     emit(AnimatedButtonStateEnum.loading);
//     try {
//       await _notificationPermissionService.requestPermission();
//       emit(AnimatedButtonStateEnum.success);
//     } catch (e, s) {
//       _analytics.errorLog(s: s, e: e, name: 'Request Notification');
//       emit(AnimatedButtonStateEnum.error);
//     }
//   }
// }
