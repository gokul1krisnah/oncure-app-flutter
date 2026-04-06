import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

/// A service that handles notification permissions.
@injectable
class NotificationPermissionService {
  /// Requests notification permission from the user.
  ///
  /// If the permission is already granted, this method does nothing.
  /// If the permission is permanently denied, it opens the app settings.
  /// Otherwise, it requests the permission.
  Future<void> requestPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted) return;
    if (status.isPermanentlyDenied) {
      // Directly guide to settings (modal won’t appear)
      await openAppSettings();
      return;
    }

    // Otherwise, request — this will trigger system modal
    await Permission.notification.request();
  }

  /// Checks if the user has granted notification permission.
  ///
  /// Returns `true` if the permission is granted, `false` otherwise.
  Future<bool> hasPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }
}
