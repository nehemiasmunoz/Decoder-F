import 'package:decoder/src/domain/models/user/user_model.dart';

abstract interface class UserRepository {
  Future<List<User>> getAll();
  Future<User> insertOne(User user);
  Future<bool> updateOne(User user);
  Future<bool> deleteOne(int userId);
}
