import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../model/user/user_model.dart';

@injectable
class UserLds {
  final Box<UserModel> userBox;
  static const _userBoxKey = 'user';

  UserLds(this.userBox);

  Future<void> saveUser(UserModel user) => userBox.put(_userBoxKey, user);

  UserModel? getUser() => userBox.get(_userBoxKey);

  Future<void> resetUser() => userBox.clear();

  ValueListenable<UserModel?> get userListener =>
      UserValueListenable(box: userBox, key: _userBoxKey);

}

class UserValueListenable extends ValueListenable<UserModel?> {
  final Box<UserModel> box;
  final String key;
  late final ValueListenable<Box<UserModel>> _boxListener;

  UserValueListenable({required this.box, required this.key}) {
    _boxListener = box.listenable(keys: [key]);
    _value = box.get(key);
  }

  UserModel? _value;
  final List<VoidCallback> _listeners = [];

  void _handleBoxChange() {
    final newValue = box.get(key);
    if (newValue != _value) {
      _value = newValue;
      for (final listener in List<VoidCallback>.from(_listeners)) {
        listener();
      }
    }
  }

  @override
  UserModel? get value => _value;

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
    if (_listeners.length == 1) {
      _boxListener.addListener(_handleBoxChange);
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
    if (_listeners.isEmpty) {
      _boxListener.removeListener(_handleBoxChange);
    }
  }

  void dispose() {
    if (_listeners.isNotEmpty) {
      _boxListener.removeListener(_handleBoxChange);
    }
    _listeners.clear();
  }
}
