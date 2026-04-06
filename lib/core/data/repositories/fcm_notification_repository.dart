import 'package:injectable/injectable.dart';

import '../lds/notification_lds.dart';
import 'settings_repository.dart';

@lazySingleton
class FcmNotificationRepository {
  final NotificationLds _notificationLDS;
  final SettingsRepository _settingsRepository;

  FcmNotificationRepository(this._notificationLDS, this._settingsRepository);

  Future<void> saveNotification(String id) async => _notificationLDS.saveKey(id: id);

  Future<void> reset() async => _notificationLDS.clear();

  Future<void> deleteKey({required String id}) async => _notificationLDS.deleteKey(key: id);

  bool isUnread({required String id, required String createdDate}) {
    final appDate = _settingsRepository.settings.appInstallDate;
    if (appDate == null) {
      return false;
    }
    final dateTime = DateTime.tryParse(createdDate);
    if (dateTime == null) {
      return false;
    }
    final isAfter = dateTime.isAfter(appDate);

    final isUnread = _notificationLDS.isUnread(id: id);
    return isUnread && isAfter;
  }
}
