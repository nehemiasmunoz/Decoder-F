import '../models/models.dart';

abstract class UserDbRepository {
  Future<List<User>> getUser();
  Future<void> addUser(User user);
  Future<void> deleteUser(int id);
  Future<void> updateUser(User user);
}
