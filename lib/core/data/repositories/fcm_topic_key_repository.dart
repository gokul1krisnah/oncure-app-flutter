import 'package:injectable/injectable.dart';

import '../lds/fcm_topic_keys_lds.dart';

@lazySingleton
class FcmTopicKeyRepository {
  final FcmTopicKeysLds fcmTopicKeysLds;

  FcmTopicKeyRepository(this.fcmTopicKeysLds);

  String get fcmTopicKey => fcmTopicKeysLds.fcmTopicKey;

  Future<void> saveKey({String? country, String? state, String? district}) async =>
      fcmTopicKeysLds.saveKey(district: district, state: state, country: country);

  Future<void> deleteKey() async => fcmTopicKeysLds.deleteKey();

  Future<void> clear() async => fcmTopicKeysLds.clear();
}
