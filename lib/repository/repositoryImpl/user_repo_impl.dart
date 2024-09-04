import 'package:decoder/models/user/user_model.dart';
import 'package:decoder/repository/user_db_repository.dart';
import 'package:decoder/services/database_service.dart';
import 'package:decoder/util/constants.dart';

class UserRepoImpl implements UserDbRepository {
  @override
  Future<void> addUser(User user) async {
    final db = await DatabaseService.instance.database;
    db.insert(userTable, user.toMap());
  }

  @override
  Future<void> deleteUser(int id) async {
    final db = await DatabaseService.instance.database;
    db.delete(userTable, where: "$userColumnId = ?", whereArgs: [id]);
  }

  @override
  Future<List<User>> getUser() async {
    final db = await DatabaseService.instance.database;
    final List<Map<String, Object?>> res = await db.query(userTable);
    return res.map((e) => User.fromMap(e)).toList();
  }

  @override
  Future<void> updateUser(User user) async {
    final db = await DatabaseService.instance.database;
    db.update(userTable, user.toMap(),
        where: "$userColumnId = ?", whereArgs: [user.id]);
  }
}
