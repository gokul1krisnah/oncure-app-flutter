import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../model/user/user_model.dart';
import '../lds/user_lds.dart';

@lazySingleton
class UserRepository {
  final UserLds userLds;

  UserRepository(this.userLds);

  UserModel? get userDetails => userLds.getUser();

  ValueListenable<UserModel?> get userListener => userLds.userListener;

  Future<void> saveUser({required UserModel user}) => userLds.saveUser(user);

  Future<void> resetUser() => userLds.resetUser();
}
