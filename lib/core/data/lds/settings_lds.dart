import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../model/settings/settings_model.dart';

@injectable
class SettingsLDS {
  final Box<SettingsModel> settingsBox;
  static const _settingsKey = 'settings';

  const SettingsLDS(this.settingsBox);

  Future<void> saveSettings(SettingsModel settings) async => settingsBox.put(_settingsKey, settings);

  SettingsModel getSettings() => settingsBox.get(_settingsKey) ?? const SettingsModel();

  ValueListenable<Box<SettingsModel>> get settingsListenable =>
      settingsBox.listenable(keys: [_settingsKey]);
}
