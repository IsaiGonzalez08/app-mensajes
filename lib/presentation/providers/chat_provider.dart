import 'package:app_mensajeria/domain/models/Chat/chat.dart';
import 'package:app_mensajeria/domain/models/Chat/repository/chat_repository.dart';
import 'package:app_mensajeria/infrastructure/repositories/chat_repository_impl.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepository _chatRepository = ChatRepositoryImpl();

  ChatProvider();

  late List<ChatModel> _chatList = [];
  List<ChatModel> get chatList => _chatList;

  late String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getAllChats(String uid) async {
    try {
      print('Obtener todos los chats desde el provider');
      _chatList = await _chatRepository.getAllChats(uid);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> createMessage(String chatId, String message, String imgUrl, String? audioUrl, String? videoUrl) async {
    await _chatRepository.createMessage(chatId, message, imgUrl, audioUrl, videoUrl);
  }
}
