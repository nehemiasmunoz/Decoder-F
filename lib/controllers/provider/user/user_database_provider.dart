import 'package:decoder/repository/repositoryImpl/user_repo_impl.dart';
import 'package:flutter/material.dart';

import '/models/user/user_model.dart';

class UserDatabaseProvider extends ChangeNotifier {
  final UserRepoImpl _userRepoImpl = UserRepoImpl();
  List<User> _users = [];
  List<User> get user => _users;

  fetchUser() async {
    _users = await _userRepoImpl.getUser();
    notifyListeners();
  }

  addUser(User user) async {
    _userRepoImpl.addUser(user);
    await fetchUser();
  }

  deleteUser(int id) async {
    _userRepoImpl.deleteUser(id);
    await fetchUser();
  }

  updateUser(User user) async {
    _userRepoImpl.updateUser(user);
    await fetchUser();
  }

  void init() {
    fetchUser();
    notifyListeners();
  }
}
