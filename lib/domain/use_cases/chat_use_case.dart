import 'package:app_mensajeria/domain/models/Chat/chat.dart';
import 'package:app_mensajeria/domain/models/Chat/repository/chat_repository.dart';

class GetAllChatsUseCase {
  final ChatRepository _chatRepository;
  GetAllChatsUseCase(this._chatRepository);

  Future<List<ChatModel>> userLogin(String uid) async {
    return await _chatRepository.getAllChats(uid);
  }
}

class CreateMessage {
  final ChatRepository _chatRepository;
  CreateMessage(this._chatRepository);

  Future<void> createMessage(String chatId, String message, String imgUrl, String? audioUrl, String? videoUrl) async {
    return await _chatRepository.createMessage(chatId, message, imgUrl, audioUrl, videoUrl);
  }
}
