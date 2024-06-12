import '../models/User/repository/user_repository.dart';
import '../models/User/user.dart';

class UserLoginUseCase {
  final UserRepository _userRepository;
  UserLoginUseCase(this._userRepository);

  Future<UserModel> userLogin(String email, String password) async {
    return await _userRepository.loginUser(email, password);
  }
}

class CreateUserUseCase {
  final UserRepository _userRepository;
  CreateUserUseCase(this._userRepository);

  Future<void> createUser(String name, String lastname, String email, String password) async {
    await _userRepository.createUser(name, lastname, email, password);
  }
}
