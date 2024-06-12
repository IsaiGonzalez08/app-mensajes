import 'package:app_mensajeria/domain/models/Chat/chat.dart';
import 'package:flutter/material.dart';

import '../../domain/models/User/repository/user_repository.dart';
import '../../domain/models/User/user.dart';
import '../../infrastructure/repositories/user_repository_impl.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepositoryImpl();

  UserProvider();

  late List<ChatModel> _chatList = [];
  List<ChatModel> get chatList => _chatList;

  late String _errorMessage = '';
  String get errorMessage => _errorMessage;

  late UserModel _user = UserModel(uid: '', name: '', lastname: '', email: '');
  UserModel get userData => _user;

  Future<void> loginUser(String email, String password) async {
    print('voy en el provider');
    UserModel userData = await _userRepository.loginUser(email, password);
    _user = userData;
    notifyListeners();
  }

  Future<void> createUser(
      String name, String lastname, String email, String password) async {
    print('voy en el provider');
    await _userRepository.createUser(name, lastname, email, password);
  }
}
