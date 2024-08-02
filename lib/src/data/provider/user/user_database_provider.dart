import 'package:decoder/src/data/repositories_impl/user_repository_impl.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/user/user_model.dart';

class UserDatabaseProvider extends ChangeNotifier {
  User _userDatabase = User();
  User get user {
    getUserFromDB();
    return _userDatabase;
  }

  void getUserFromDB() async {
    _userDatabase = await UserRepositoryImpl().getUser();
  }

  void addUserToDb(User user) {
    UserRepositoryImpl().insertOne(user);
  }
}
