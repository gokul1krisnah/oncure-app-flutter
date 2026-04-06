import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/constants/app_constants.dart';

@lazySingleton
class FcmTopicKeysLds {
  final Box<String> fcmTopicKeyBox;

  FcmTopicKeysLds(@Named('fcmTopicKeyBox') this.fcmTopicKeyBox);

  String get fcmTopicKey => fcmTopicKeyBox.get('current') ?? AppConstants.getFcmTopicKey();

  Future<void> saveKey({String? country, String? state, String? district}) async {
    final key = AppConstants.getFcmTopicKey(country: country, state: state, district: district);
    await fcmTopicKeyBox.put('current', key);
  }

  Future<void> deleteKey() async => fcmTopicKeyBox.delete('current');

  Future<void> clear() async => fcmTopicKeyBox.clear();
}
