import '../user.dart';

abstract class UserRepository {
  Future<UserModel> loginUser(String email, String password);
  Future<void> createUser(String name, String lastname, String email, String password);
}