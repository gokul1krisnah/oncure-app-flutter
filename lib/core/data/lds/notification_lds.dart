import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationLds {
  final Box<String> notificationsKeysBox;

  NotificationLds(@Named('notificationsKeysBox') this.notificationsKeysBox);

  Future<void> saveKey({required String id}) async => notificationsKeysBox.put(id, id);

  Future<void> deleteKey({required String key}) async => notificationsKeysBox.delete(key);

  bool isUnread({required String id}) => notificationsKeysBox.containsKey(id);

  Future<void> clear() async => notificationsKeysBox.clear();
}
