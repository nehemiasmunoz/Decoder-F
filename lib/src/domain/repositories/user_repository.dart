import 'package:decoder/src/domain/models/user/user_model.dart';

abstract interface class UserRepository {
  Future<User> getUser();
  Future<int> insertOne(User user);
  Future<int> updateOne(User user);
  Future<int> deleteOne(int userId);
}
