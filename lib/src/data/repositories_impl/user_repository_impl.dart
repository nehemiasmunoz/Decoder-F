import 'package:decoder/src/data/services/database_service.dart';
import 'package:decoder/src/data/util/constants.dart';
import 'package:decoder/src/domain/models/user/user_model.dart';
import 'package:decoder/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<int> deleteOne(int userId) async {
    final db = await DatabaseService.instance.database;
    return db
        .delete(userTableName, where: '$userColumnId = ?', whereArgs: [userId]);
  }

  @override
  Future<User> getUser() async {
    final db = await DatabaseService.instance.database;
    List<Map<String, Object?>> users = await db.query(userTableName, columns: [
      userColumnId,
      userColumnName,
      userColumnAge,
      userColumnHasDiabetes,
      userColumnHasHypertension,
      userColumnDiabetesType,
      userColumnHypertensionType
    ]);
    if (users.length > 0) {
      return User.fromMap(users.first);
    }
    return Future(() => User());
  }

  @override
  Future<int> insertOne(User user) async {
    final db = await DatabaseService.instance.database;
    return db.insert(userTableName, user.toMap());
  }

  @override
  Future<int> updateOne(User user) async {
    final db = await DatabaseService.instance.database;
    return db.update(userTableName, user.toMap(),
        where: '$userColumnId = ?', whereArgs: [user.id]);
  }
}
