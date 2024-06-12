import 'package:app_mensajeria/domain/models/Messages/messages.dart';
import 'package:app_mensajeria/domain/models/Messages/repository/messages_repository.dart';

class GetAllMessagesUseCase {
  final MessagesRepository _messagesRepository;
  GetAllMessagesUseCase(this._messagesRepository);

  Future<List<MessagesModel>> userLogin(String uid, String chatUid) async {
    return await _messagesRepository.getAllMessages(uid, chatUid);
  }
}
