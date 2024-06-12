import 'package:app_mensajeria/domain/models/Chat/chat.dart';

abstract class ChatRepository {
  Future<List<ChatModel>> getAllChats(String uid);
  Future<void> createMessage(String chatId, String message, String imgUrl, String? audioUrl, String? videoUrl);
}
