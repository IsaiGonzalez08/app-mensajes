import 'package:app_mensajeria/domain/models/Messages/messages.dart';
import 'package:app_mensajeria/domain/models/Messages/repository/messages_repository.dart';
import 'package:app_mensajeria/infrastructure/repositories/messages_repository_impl.dart';
import 'package:flutter/material.dart';

class MessagesProvider extends ChangeNotifier {
  final MessagesRepository _messagesRepository = MessagesRepositoryImpl();

  MessagesProvider();

  late List<MessagesModel> _messagesList = [];
  List<MessagesModel> get messagesList => _messagesList;

  late String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getAllMessages(String uid, String chatId) async {
    try {
      print('Obtener todos los chats desde el provider');
      _messagesList = await _messagesRepository.getAllMessages(uid, chatId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
